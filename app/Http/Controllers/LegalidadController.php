<?php

namespace App\Http\Controllers;

use App\Models\Consejo;
use App\Models\Integrante;
use App\Models\Legalidad;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Illuminate\Support\Facades\Storage;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;

class LegalidadController extends Controller
{
    /* =========================
       INDEX (vista normal)
    ========================= */
    public function index(Consejo $consejo)
    {
        return Inertia::render('Legalidad/Index', [
            'consejo' => $consejo,
            'integrantes' => Integrante::where('consejo_id', $consejo->id)->get(),
            'registros' => Legalidad::with('integrante')
                ->where('consejo_id', $consejo->id)
            //    ->orderBy('nombre')
                ->get(),
        ]);
    }

    /* =========================
       VISTA EXCLUSIVA SUPER ADMIN
    ========================= */
    public function estatus(Consejo $consejo)
{
    return Inertia::render('Legalidad/Estatus', [
        'consejo' => $consejo,
        'registros' => Legalidad::with('integrante')
            ->where('consejo_id', $consejo->id)
            ->get(),
    ]);
}

    /* =========================
       CREAR PERIODO NORMAL
    ========================= */
    public function store(Request $request, Consejo $consejo)
    {
        $validated = $request->validate([
            'integrante_id' => 'required|exists:integrantes,id',
            'inicio_cargo'  => 'required|date',
            'fin_cargo'     => 'required|date|after_or_equal:inicio_cargo',
        ]);

        $inicio = Carbon::parse($validated['inicio_cargo']);
        $fin    = Carbon::parse($validated['fin_cargo']);

        $periodo = $inicio->diff($fin);
        $periodoHabil = sprintf('%02d:%02d:%02d', $periodo->y, $periodo->m, $periodo->d);

        Legalidad::create([
            'consejo_id'    => $consejo->id,
            'integrante_id' => $validated['integrante_id'],
            'inicio_cargo'  => $validated['inicio_cargo'],
            'fin_cargo'     => $validated['fin_cargo'],
            'periodo_habil' => $periodoHabil,
            'estatus_reeleccion' => 'pendiente',
            'ya_reelegido' => 0,
        ]);

        return back()->with('success', 'Periodo registrado correctamente.');
    }

    /* =========================
       FASE 1: SOLICITAR REELECCIÓN
    ========================= */
    public function solicitarReeleccion(Request $request, Legalidad $legalidad)
    {
        $request->validate([
            'doc_nombramiento' => 'required|file|mimes:pdf|max:5120',
            'doc_carta_reeleccion' => 'required|file|mimes:pdf|max:5120',
            'doc_otros' => 'nullable|file|mimes:pdf|max:5120',
        ]);

        $legalidad->update([
            'doc_nombramiento' => $request->file('doc_nombramiento')
                ->store('legalidad/documentos', 'public'),

            'doc_carta_reeleccion' => $request->file('doc_carta_reeleccion')
                ->store('legalidad/documentos', 'public'),

            'doc_otros' => $request->hasFile('doc_otros')
                ? $request->file('doc_otros')->store('legalidad/documentos', 'public')
                : null,

            'fecha_inicio_reeleccion' => now(),
            'estatus_reeleccion' => 'pendiente',
        ]);

        return back()->with('success', 'Solicitud enviada para validación.');
    }

    /* =========================
       FASE 2: APROBAR REELECCIÓN
    ========================= */
    public function aprobarReeleccion(Legalidad $legalidad)
    {
        if ($legalidad->ya_reelegido) {
            return back()->with('error', 'Este integrante ya fue reelegido una vez.');
        }

        $inicio = Carbon::now();
        $fin = Carbon::now()->addYears(3);

        $legalidad->update([
            'inicio_cargo' => $inicio,
            'fin_cargo' => $fin,
            'periodo_habil' => '03:00:00',
            'estatus_reeleccion' => 'aprobado',
            'fecha_validacion' => now(),
            'validado_por' => Auth::id(),
            'ya_reelegido' => 1,
        ]);

        return back()->with('success', 'Reelección aprobada y periodo reiniciado.');
    }
    

    /* =========================
       FASE 2: RECHAZAR REELECCIÓN
    ========================= */
    public function rechazarReeleccion(Legalidad $legalidad)
    {
        $legalidad->update([
            'estatus_reeleccion' => 'rechazado',
            'fecha_validacion' => now(),
            'validado_por' => Auth::id(),
        ]);

        return back()->with('warning', 'Solicitud de reelección rechazada.');
    }
}
