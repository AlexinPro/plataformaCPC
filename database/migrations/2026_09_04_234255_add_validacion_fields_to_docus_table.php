<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('docus', function (Blueprint $table) {

            $table->enum('estatus', [
                'pendiente',
                'aprobado',
                'rechazado',
            ])->default('pendiente')->after('ruta');

            $table->text('observacion')
                ->nullable()
                ->after('estatus');

            $table->foreignId('validado_por')
                ->nullable()
                ->after('observacion')
                ->constrained('users')
                ->nullOnDelete();

            $table->timestamp('validado_at')
                ->nullable()
                ->after('validado_por');

        });
    }

    public function down(): void
    {
        Schema::table('docus', function (Blueprint $table) {

            $table->dropForeign(['validado_por']);

            $table->dropColumn([
                'estatus',
                'observacion',
                'validado_por',
                'validado_at',
            ]);

        });
    }
};