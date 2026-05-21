<?php

namespace App\Http\Controllers;

use App\Models\Docu;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Integrante;
use Illuminate\Support\Facades\Storage;

class DocuController extends Controller
{
    public function index($integranteId)
    {
        $integrante = Integrante::with('documentos')->findOrFail($integranteId);

        return Inertia::render('Docu/Index', [
            'integrante' => $integrante,
            'flash' => session('success') //para después de regresar a la vista de consejos 
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
            if ($request->hasFile($tipo)) {
                $archivo = $request->file($tipo);

                $ruta = $archivo->store("documentos/{$integranteId}", 'public'); // se habilita con storage:link

                Docu::updateOrCreate(
                    [
                        'integrante_id' => $integranteId,
                        'tipo' => $tipo,
                    ],
                    [
                        'archivo' => $ruta,
                    ]
                );
            }
        }

        return redirect()->back()->with('success', 'Documentos subidos correctamente.');
    }

    //Manejo de descarga de archivos
    public function download($id)
    {
        $documento = Docu::findOrFail($id);

        if (!Storage::disk('public')->exists($documento->archivo)) {
            abort(404);}
        

        $path = Storage::disk('public')->path($documento->archivo);
        return response()->download($path);
    }
    
}
