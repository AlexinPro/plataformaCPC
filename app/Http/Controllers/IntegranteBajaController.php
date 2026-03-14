<?php

namespace App\Http\Controllers;

use App\Models\Integrante;
use App\Models\IntegranteBaja;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class IntegranteBajaController extends Controller
{
    public function store(Request $request, Integrante $integrante)
    {
        // Validar motivo primero
        $request->validate([
            'motivo' => 'required|in:inasistencia,sancion,fin_periodo,renuncia,error_registro',
        ]);

        // Si es error de registro → solo eliminar
        if ($request->motivo === 'error_registro') {
            $integrante->delete();

            return redirect()
                ->back()
                ->with('success', 'Integrante eliminado por error de registro.');
        }

        // Validación para bajas reales
        $request->validate([
            'fecha_baja' => 'required|date',
            'evidencia_pdf' => 'required|file|mimes:pdf|max:5120',
        ]);

        DB::transaction(function () use ($request, $integrante) {

            $pdfPath = $request->file('evidencia_pdf')->store('bajas', 'public');

            IntegranteBaja::create([
                'integrante_id' => $integrante->id,
                'consejo_id'    => $integrante->consejo_id,
                'nombre'        => $integrante->nombre,
                'apellido'      => $integrante->apellido,
                'motivo'        => $request->motivo,
                'fecha_baja'    => $request->fecha_baja,
                'evidencia_pdf' => $pdfPath,
            ]);

            $integrante->delete();
        });

        return redirect()
            ->back()
            ->with('success', 'Integrante dado de baja correctamente.');
    }
}
