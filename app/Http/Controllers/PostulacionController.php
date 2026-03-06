<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Postulacion;
use App\Models\PostulacionDocumento;
use App\Models\Consejo;
use App\Models\Integrante;
use App\Models\Docu;
use App\Models\Legalidad;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class PostulacionController extends Controller
{

    public function index()
    {
        $postulaciones = Postulacion::with('consejo', 'documentos')
            ->latest()
            ->get();

        $consejos = Consejo::orderBy('nombre')->get();

        return Inertia::render('Postulaciones/Index', [
            'postulaciones' => $postulaciones,
            'consejos' => $consejos,
        ]);
    }

    public function store(Request $request)
    {

        $rules = [
            'nombre'     => 'required|string|max:255',
            'apellidos'  => 'required|string|max:255',
            'correo'     => 'required|email|max:255',
            'consejo_id' => 'required|exists:consejos,id',
            'puesto'     => 'required|string|max:255',
        ];

        foreach (Postulacion::TIPOS_DOCUMENTOS as $tipo) {
            $rules["documentos.$tipo"] = 'required|file|mimes:pdf|max:2048';
        }

        $request->validate($rules);

        return DB::transaction(function () use ($request) {

            $postulacion = Postulacion::create([
                'nombre'            => $request->nombre,
                'apellidos'         => $request->apellidos,
                'correo'            => $request->correo,
                'consejo_id'        => $request->consejo_id,
                'puesto'            => $request->puesto,
                'estatus'           => 'pendiente',
                'fecha_postulacion' => now(),
            ]);

            foreach (Postulacion::TIPOS_DOCUMENTOS as $tipo) {

                $archivo = $request->file("documentos.$tipo");

                $ruta = $archivo->store('postulaciones', 'public');

                PostulacionDocumento::create([
                    'postulacion_id' => $postulacion->id,
                    'tipo' => $tipo,
                    'archivo' => $ruta,
                ]);
            }

            return redirect()
                ->route('postulaciones.index')
                ->with('success', 'Postulación creada correctamente.');
        });
    }

    public function validacion()
    {
        $postulaciones = Postulacion::with(['consejo', 'documentos'])
            ->where('estatus', 'pendiente')
            ->latest()
            ->get();

        return Inertia::render('Postulaciones/Postulacion', [
            'postulaciones' => $postulaciones,
        ]);
    }
    public function aprobar(Request $request, Postulacion $postulacion)
    {
        $request->validate([
            'fecha_validacion' => 'required|date',
            'acta_resolucion' => 'required|file|mimes:pdf|max:4096'
        ]);

        return DB::transaction(function () use ($request, $postulacion) {

            if ($postulacion->estatus !== 'pendiente') {
                return redirect()
                    ->route('postulaciones.validacion')
                    ->with('error', 'Esta postulación ya fue procesada.');
            }

            $archivo = $request->file('acta_resolucion');

            $nombre = 'acta_' . $postulacion->id . '_' . time() . '.' . $archivo->getClientOriginalExtension();
            $ruta = $archivo->storeAs('resoluciones', $nombre, 'public');

            /* CREAR INTEGRANTE */

            $integrante = Integrante::create([
                'nombre' => $postulacion->nombre,
                'apellido' => $postulacion->apellidos,
                'puesto' => $postulacion->puesto,
                'correo' => $postulacion->correo,
                'genero' => null,
                'colonia' => null,
                'discapacidad' => null,
                'discapacidad_tipo' => null,
                'consejo_id' => $postulacion->consejo_id,
            ]);

            /* COPIAR DOCUMENTOS DE POSTULACION A DOCU */

            foreach ($postulacion->documentos as $doc) {
                Docu::create([
                    'integrante_id' => $integrante->id,
                    'tipo' => $doc->tipo,
                    'archivo' => $doc->archivo,
                ]);
            }

            /* CREAR PERIODO EN LEGALIDAD */
            Legalidad::create([
                'consejo_id' => $postulacion->consejo_id,
                'integrante_id' => $integrante->id,
                'inicio_cargo' => Carbon::parse($request->fecha_validacion)->format('Y-m-d'),
                'fin_cargo' => Carbon::parse($request->fecha_validacion)
                    ->addYears(3)
                    ->format('Y-m-d'),
                'periodo_habil' => '1',
                'estatus_reeleccion' => 'pendiente',
                'fecha_inicio_reeleccion' => null,
                'fecha_validacion' => Carbon::parse($request->fecha_validacion)->format('Y-m-d'),
                'validado_por' => Auth::id(),
                'ya_reelegido' => false
            ]);

            /* ACTUALIZAR POSTULACION */

            $postulacion->update([
                'estatus' => 'aprobada',
                'validado_por' => Auth::id(),
                'fecha_validacion' => $request->fecha_validacion,
                'acta_resolucion' => $ruta
            ]);

            return redirect()
                ->route('postulaciones.validacion')
                ->with('success', 'Postulación aprobada correctamente.');
        });
    }

    public function rechazar(Request $request, Postulacion $postulacion)
    {

        $request->validate([
            'fecha_validacion' => 'required|date',
            'acta_resolucion' => 'required|file|mimes:pdf|max:4096'
        ]);

        $archivo = $request->file('acta_resolucion');

        $nombre = 'acta_' . $postulacion->id . '_' . time() . '.' . $archivo->getClientOriginalExtension();

        $ruta = $archivo->storeAs('resoluciones', $nombre, 'public');

        $postulacion->update([
            'estatus' => 'no_aprobada',
            'validado_por' => Auth::id(),
            'fecha_validacion' => $request->fecha_validacion,
            'acta_resolucion' => $ruta
        ]);

        return redirect()
            ->route('postulaciones.validacion')
            ->with('success', 'Postulación rechazada.');
    }
}
