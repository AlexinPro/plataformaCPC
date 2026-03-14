<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Integrante;
use App\Models\Consejo;
use App\Models\IntegranteBaja;
use Inertia\Inertia;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class IntegranteController extends Controller
{
    public function index(Consejo $consejo)
    {
        $integrantes = $consejo->integrantes()
        ->with('documentos')
        ->get();

        return Inertia::render('Integrantes/Index', [
            'consejo' => $consejo,
            'integrantes' => $integrantes
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'nombre' => 'required|string|max:255',
            'apellido' => 'required|string|max:255',
            'genero' => 'nullable|string|max:50',
            'colonia' => 'nullable|string|max:255',
            'discapacidad' => 'nullable|string|max:25',
            'discapacidad_tipo' => 'nullable|string|max:255|required_if:discapacidad,si',
            'puesto' => 'required|string|max:255',
            'correo' => 'required|email|unique:integrantes,correo',
            'consejo_id' => 'required|exists:consejos,id',
            'formula' => 'required|integer|min:1',
        ]);

        Integrante::create($validated);

        return redirect()->route('consejos.integrantes', $request->consejo_id);
    }

    public function update(Request $request, Integrante $integrante)
    {
        $validated = $request->validate([
            'nombre' => 'required|string|max:255',
            'apellido' => 'required|string|max:255',
            'genero' => 'nullable|string|max:50',
            'colonia' => 'nullable|string|max:255',
            'discapacidad' => 'nullable|string|max:25',
            'discapacidad_tipo' => 'nullable|string|max:255|required_if:discapacidad,si',
            'puesto' => 'required|string|max:255',
            'correo' => 'required|email|unique:integrantes,correo,' . $integrante->id,
        ]);

        $integrante->update($validated);

        return redirect()->route('consejos.integrantes', $integrante->consejo_id);
    }

    public function destroy(Request $request, Integrante $integrante)
    {
        // Validación del formulario de baja
        $request->validate([
            'motivo' => 'required|in:inasistencia,sancion,fin_periodo,renuncia',
            'fecha_baja' => 'required|date',
            'evidencia_pdf' => 'required|file|mimes:pdf|max:5120',
        ]);

        DB::transaction(function () use ($request, $integrante) {

            // Guardar PDF en storage/app/public/bajas
            $pdfPath = $request->file('evidencia_pdf')->store('bajas', 'public');

            // Registrar baja histórica
            IntegranteBaja::create([
                'integrante_id' => $integrante->id,
                'consejo_id'    => $integrante->consejo_id,
                'nombre'        => $integrante->nombre,
                'apellido'      => $integrante->apellido,
                'motivo'        => $request->motivo,
                'fecha_baja'    => $request->fecha_baja,
                'evidencia_pdf' => $pdfPath,
            ]);

            // Eliminar integrante de la tabla principal
            $integrante->delete();
        });

        return redirect()->route('consejos.integrantes', $integrante->consejo_id);
    }
}
