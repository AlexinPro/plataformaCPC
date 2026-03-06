<?php

namespace App\Http\Controllers;

use App\Models\Consejo;
use App\Models\Integrante;
use App\Models\Asistencia;
use Illuminate\Http\Request;
use Inertia\Inertia;

class AsistenciaController extends Controller
{
    public function index(Consejo $consejo)
    {
        $integrantes = Integrante::where('consejo_id', $consejo->id)->orderBy('nombre')->get();

        $asistencias = Asistencia::whereIn(
            'integrante_id',
            $integrantes->pluck('id')
        )->get();

        return Inertia::render('Asistencia/Index', [
            'consejo' => $consejo,
            'integrantes' => $integrantes,
            'asistencias' => $asistencias,
        ]);
    }

    public function create(Consejo $consejo, Request $request)
    {
        return Inertia::render('Asistencia/Form', [
            'consejo' => $consejo,
            'fecha' => $request->fecha,
            'integrantes' => Integrante::where('consejo_id', $consejo->id)->get(),
        ]);
    }

    // 📅 Vista calendario
    public function calendar(Consejo $consejo)
    {
        $integrantes = Integrante::where('consejo_id', $consejo->id)->get();

        $sesiones = Asistencia::whereIn('integrante_id', $integrantes->pluck('id'))
            ->select('fecha', 'tipo_sesion')
            ->groupBy('fecha', 'tipo_sesion')
            ->get();

        return Inertia::render('Asistencia/Calendar', [
            'consejo' => $consejo,
            'integrantes' => $integrantes,
            'sesiones' => $sesiones,
        ]);
    }

    // 📄 Historial por integrante
    public function history($consejoId, $integranteId)
    {
        $integrante = Integrante::where('id', $integranteId)
            ->where('consejo_id', $consejoId)
            ->firstOrFail();

        $historial = Asistencia::where('integrante_id', $integranteId)
            ->orderBy('fecha', 'desc')
            ->get([
                'id',
                'fecha',
                'estado',
                'tipo_sesion',
                'evidencia'
            ]);

        return Inertia::render('Asistencia/History', [
            'integrante' => $integrante,
            'historial' => $historial
        ]);
    }

    // 🟢 REGISTRO POR SESIÓN (desde calendario)
    public function storeSesion(Request $request, Consejo $consejo)
    {
        $validated = $request->validate([
            'fecha' => 'required|date',
            'tipo_sesion' => 'required|in:ordinaria,solemne,extraordinaria',
            'asistencias' => 'required|array',
            'asistencias.*.integrante_id' => 'required|exists:integrantes,id',
            'asistencias.*.estado' => 'required|in:asistio,falto,justificada',
            'evidencia' => 'nullable|file|mimes:pdf|max:4096',
        ]);

        // 📎 Guardar evidencia (una sola vez por sesión)
        $evidenciaPath = null;

        if ($request->hasFile('evidencia')) {
            $evidenciaPath = $request->file('evidencia')
                ->store('evidencias', 'public');
        }

        foreach ($validated['asistencias'] as $item) {
            Asistencia::updateOrCreate(
                [
                    'integrante_id' => $item['integrante_id'],
                    'fecha' => $validated['fecha'],
                    'tipo_sesion' => $validated['tipo_sesion'],
                ],
                [
                    'estado' => $item['estado'],
                    'evidencia' => $evidenciaPath,
                ]
            );
        }

        return back()->with('success', 'Asistencia registrada correctamente');
    }

    // 📁 Vista de evidencias
    public function evidencias(Consejo $consejo)
    {
        $integrantes = Integrante::where('consejo_id', $consejo->id)->pluck('id');

        $sesiones = Asistencia::whereIn('integrante_id', $integrantes)
            ->whereNotNull('evidencia')
            ->select('fecha', 'tipo_sesion', 'evidencia')
            ->groupBy('fecha', 'tipo_sesion', 'evidencia')
            ->orderBy('fecha', 'desc')
            ->get();

        return Inertia::render('Asistencia/Evidencia', [
            'consejo' => $consejo,
            'sesiones' => $sesiones,
        ]);
    }
}