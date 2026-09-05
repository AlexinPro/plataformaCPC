<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;

class PermissionSeeder extends Seeder
{
    public function run(): void
    {
        $permissions = [

            //-------------archivo digital------------
            'archivo_digital.ver',

            'integrantes.crear',
            'integrantes.editar',
            'integrantes.baja',

            'documentos.subir',
            'documentos.ver',
            'documentos.observar',
            'documentos.aprobar',

            // ---------consejos------
            'consejos.ver',

            // -----------asistencias-------
            'asistencias.ver',
            'asistencias.crear',
            'sesiones.ver',

            // -------legalidad------------
            'legalidad.ver',
            'legalidad.solicitar_reeleccion',
            'legalidad.validar_reeleccion',
            'legalidad.rechazar_reeleccion',

            // -------------convocatorias------
            'convocatorias.ver',
            'convocatorias.crear',
            'convocatorias.editar',

            //-------- reportes--------------
            'reportes.ver',

            // -----------usuarios------------
            'usuarios.ver',
            'usuarios.crear',
            'usuarios.editar',

            // ------------postulaciones---------------
            'postulaciones.crear',
            'postulaciones.ver',
            'postulaciones.validar',
        ];

        foreach ($permissions as $permission) {
            Permission::firstOrCreate([
                'name' => $permission,
            ]);
        }
    }
}