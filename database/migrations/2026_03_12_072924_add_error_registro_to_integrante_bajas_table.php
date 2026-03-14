<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('integrante_bajas', function (Blueprint $table) {
            $table->enum('motivo', [
                'inasistencia',
                'sancion',
                'fin_periodo',
                'renuncia',
                'error_registro'
            ])->change();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('integrante_bajas', function (Blueprint $table) {
            $table->enum('motivo', [
                'inasistencia',
                'sancion',
                'fin_periodo',
                'renuncia'
            ])->change();
        });
    }
};
