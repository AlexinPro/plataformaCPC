<?php

namespace App\Http\Controllers;

use App\Models\Docu;
use App\Models\Integrante;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class DocuController extends Controller
{
    public function index($integranteId)
    {
        $integrante = Integrante::with('documentos')->findOrFail($integranteId);

        return Inertia::render('Docu/Index', [
            'integrante' => $integrante,
            'flash' => session('success'),
        ]);
    }

    public function store(Request $request, $integranteId)
    {
        $integrante = Integrante::findOrFail($integranteId);

        $tipos = [
            'ine',
            'comprobante_domiciliario',
            'bajo_protesta_art_170',
            'integracion_formula',
            'curriculum_vitae',
            'carta_motivos',
            'cumplimiento_normatividad',
        ];

        foreach ($tipos as $tipo) {

            if (!$request->hasFile($tipo)) {
                continue;
            }

            $archivo = $request->file($tipo);

            $documentoExistente = Docu::where(
                'integrante_id',
                $integranteId
            )->where(
                'tipo',
                $tipo
            )->first();

            // Si ya existe y está aprobado, por ahora no permitir reemplazarlo
            if (
                $documentoExistente &&
                $documentoExistente->estatus === 'aprobado'
            ) {
                continue;
            }

            // Eliminar archivo anterior si existe
            if (
                $documentoExistente &&
                $documentoExistente->archivo &&
                Storage::disk('public')->exists($documentoExistente->archivo)
            ) {
                Storage::disk('public')->delete(
                    $documentoExistente->archivo
                );
            }

            // Guardar nuevo archivo
            $ruta = $archivo->store(
                "documentos/{$integranteId}",
                'public'
            );

            if ($documentoExistente) {

                // Si el documento fue rechazado y se reemplaza,
                // vuelve al flujo de validación
                $documentoExistente->update([
                    'archivo' => $ruta,
                    'estatus' => 'pendiente',
                    'observacion' => null,
                    'validado_por' => null,
                    'validado_at' => null,
                ]);

            } else {

                // Documento nuevo
                Docu::create([
                    'integrante_id' => $integranteId,
                    'tipo' => $tipo,
                    'archivo' => $ruta,
                    'estatus' => 'pendiente',
                ]);
            }
        }

        return redirect()
            ->back()
            ->with('success', 'Documentos guardados correctamente.');
    }

    // Descarga de archivos
    public function download($id)
    {
        $documento = Docu::findOrFail($id);

        if (!Storage::disk('public')->exists($documento->archivo)) {
            abort(404);
        }

        $path = Storage::disk('public')->path($documento->archivo);

        return response()->download($path);
    }

    // Aprobar documento
public function aprobar(Docu $documento)
{
    $documento->update([
        'estatus' => 'aprobado',
        'observacion' => null,
        'validado_por' => Auth::id(),
        'validado_at' => now(),
    ]);

    return redirect()
        ->back()
        ->with('success', 'Documento aprobado correctamente.');
}


// Rechazar documento
public function rechazar(Request $request, Docu $documento)
{
    $request->validate([
        'observacion' => ['required', 'string', 'max:2000'],
    ]);

    $documento->update([
        'estatus' => 'rechazado',
        'observacion' => $request->observacion,
        'validado_por' => Auth::id(),
        'validado_at' => now(),
    ]);

    return redirect()
        ->back()
        ->with('success', 'Documento rechazado y observación registrada.');
}
}