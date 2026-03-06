<?php

use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

/*
|--------------------------------------------------------------------------
| Controllers
|--------------------------------------------------------------------------
*/
use App\Http\Controllers\AsistenciaController;
use App\Http\Controllers\ConsejoController;
use App\Http\Controllers\ConvocatoriaController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\DocuController;
use App\Http\Controllers\IntegranteController;
use App\Http\Controllers\IntegranteBajaController;
use App\Http\Controllers\LegalidadController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\PostulacionController;
use App\Http\Controllers\ReporteController;
use App\Http\Controllers\UserController;

/*
|--------------------------------------------------------------------------
| Rutas públicas
|--------------------------------------------------------------------------
*/
Route::get('/', function () {
    return Inertia::render('Dashboard');
});

Route::get('/about', fn () => Inertia::render('About'))
    ->name('about');

/*
|--------------------------------------------------------------------------
| Dashboard protegido
|--------------------------------------------------------------------------
*/
Route::get('/dashboard', [DashboardController::class, 'index'])
    ->middleware(['auth', 'verified'])
    ->name('dashboard');

/*
|--------------------------------------------------------------------------
| Rutas protegidas
|--------------------------------------------------------------------------
*/
Route::middleware('auth')->group(function () {

    /*
    |--------------------------------------------------------------------------
    | ASISTENCIAS (consulta)
    |--------------------------------------------------------------------------
    */
    Route::get('/consejos/asistencias', [ConsejoController::class, 'index'])
        ->name('consejos.asistencias');

    Route::get('/asistencias/{consejo}', [AsistenciaController::class, 'index'])
        ->name('asistencias.index');

    Route::get('/asistencia/{consejo}', [AsistenciaController::class, 'show'])
        ->name('asistencia.show');

    Route::get('/consejos/{consejo}/calendar', [AsistenciaController::class, 'calendar'])
        ->name('asistencia.calendar');

    Route::get(
        '/consejos/{consejo}/asistencias/{integrante}/historial',
        [AsistenciaController::class, 'history']
    )->name('asistencia.history');

    Route::get('/consejos/{consejo}/evidencias', [AsistenciaController::class, 'evidencias'])
        ->name('asistencias.evidencias');

    /*
    |--------------------------------------------------------------------------
    | ASISTENCIAS (registro)
    |--------------------------------------------------------------------------
    */
    Route::middleware('permission:convocatorias.crear')->group(function () {

        Route::get('/consejos/{consejo}/asistencias/create', [AsistenciaController::class, 'create'])
            ->name('asistencias.create');

        Route::post('/asistencias/{consejo}', [AsistenciaController::class, 'store'])
            ->name('asistencias.store');

        Route::post(
            '/consejos/{consejo}/asistencias/sesion',
            [AsistenciaController::class, 'storeSesion']
        )->name('asistencias.sesion.store');
    });

    /*
    |--------------------------------------------------------------------------
    | CONSEJOS (consulta y edición )
    |--------------------------------------------------------------------------
    */
    Route::get('/consejos', [ConsejoController::class, 'index'])
        ->name('consejos.index');

    Route::get('/consejos/convocatorias', [ConsejoController::class, 'index'])
        ->name('consejos.convocatorias');

    Route::get('/consejos/legalidad', [ConsejoController::class, 'index'])
        ->name('consejos.legalidad');

    Route::get('/consejos/reportes', [ConsejoController::class, 'index'])
        ->name('consejos.reportes');

    Route::patch('/consejos/{consejo}/descripcion', [ConsejoController::class, 'updateDescripcion'])
    ->name('consejos.descripcion.update');

    /*
    |--------------------------------------------------------------------------
    | CONVOCATORIAS
    |--------------------------------------------------------------------------
    */
    Route::get('/convocatorias/{consejo}', [ConvocatoriaController::class, 'index'])
        ->name('convocatorias.index');

    Route::middleware('permission:convocatorias.crear')->group(function () {

        Route::post('/convocatorias/{consejo}', [ConvocatoriaController::class, 'store'])
            ->name('convocatorias.store');

        Route::patch('/convocatorias/{convocatoria}/estado', [ConvocatoriaController::class, 'toogleEstado'])
            ->name('convocatorias.toogleEstado');

        Route::post('/convocatorias/subir', [ConvocatoriaController::class, 'subir'])
            ->name('convocatorias.subir');
    });

    /*
    |--------------------------------------------------------------------------
    | DOCUMENTOS
    |--------------------------------------------------------------------------
    */
    Route::get('/documentos/{integrante}', [DocuController::class, 'index'])
        ->name('docu.index');

    Route::middleware('permission:documentos.subir')->group(function () {

        Route::post('/documentos/{integrante}', [DocuController::class, 'store'])
            ->name('docu.store');
    });

    Route::get('/documento/descargar/{id}', [DocuController::class, 'download'])
        ->name('docu.download');

    Route::get('/documento/ver/{id}', [DocuController::class, 'show'])
        ->name('docu.show');

    /*
    |--------------------------------------------------------------------------
    | INTEGRANTES
    |--------------------------------------------------------------------------
    */
    Route::middleware('permission:usuarios.editar')->group(function () {

        Route::resource('integrantes', IntegranteController::class);

        Route::get('/consejos/{consejo}/integrantes', [IntegranteController::class, 'index'])
            ->name('consejos.integrantes');

        Route::post('/integrantes/{integrante}/baja', [IntegranteBajaController::class, 'store'])
            ->name('integrantes.baja');
    });

    /*
|--------------------------------------------------------------------------
| LEGALIDAD Y REPORTES
|--------------------------------------------------------------------------
*/
Route::middleware('permission:legalidad.ver')->group(function () {

    // ======= LEGALIDAD (USUARIOS NORMALES Y ADMIN) =======

    Route::get('/legalidad/{consejo}', [LegalidadController::class, 'index'])
        ->name('legalidad.index');

    Route::post('/legalidad/{consejo}', [LegalidadController::class, 'store'])
        ->name('legalidad.store');

    Route::post('/legalidad/{legalidad}/reeleccion', [LegalidadController::class, 'solicitarReeleccion'])
        ->name('legalidad.reeleccion');

    Route::delete('/legalidad/{legalidad}', [LegalidadController::class, 'destroy'])
        ->name('legalidad.destroy');

    // ======= SOLO SUPER ADMIN (VALIDACIONES) =======
    Route::middleware(['auth', 'role:super_admin'])->group(function () {

        Route::get('/legalidad/estatus/{consejo}', [LegalidadController::class, 'estatus'])
            ->name('legalidad.estatus');

        Route::post('/legalidad/{legalidad}/aprobar', [LegalidadController::class, 'aprobarReeleccion'])
            ->name('legalidad.aprobar');

        Route::post('/legalidad/{legalidad}/rechazar', [LegalidadController::class, 'rechazarReeleccion'])
            ->name('legalidad.rechazar');
    });

    //-------------Postulaciones----------------
    Route::get('/postulaciones', [PostulacionController::class, 'index'])
        ->name('postulaciones.index');

    Route::post('/postulaciones', [PostulacionController::class, 'store'])
        ->name('postulaciones.store'); 

    Route::get('/postulaciones/validacion', [PostulacionController::class, 'validacion'])
        ->name('postulaciones.validacion');   
        
    Route::post('/postulaciones/{postulacion}/aprobar',  [PostulacionController::class, 'aprobar'])
        ->name('postulaciones.aprobar');

    Route::post('/postulaciones/{postulacion}/rechazar',  [PostulacionController::class, 'rechazar'])
        ->name('postulaciones.rechazar');
    
        
        //rutas para super_admin
            

    // ======= REPORTES =======
    Route::get('/consejos/reportes', [ConsejoController::class, 'index'])
        ->name('consejos.reportes');

    Route::get('/consejos/{consejo}/reportes', [ReporteController::class, 'show'])
        ->name('reportes.consejo');
});

    /*
    |--------------------------------------------------------------------------
    | USUARIOS
    |--------------------------------------------------------------------------
    */
    Route::middleware('permission:usuarios.crear')->group(function () {

        Route::get('/users', [UserController::class, 'index'])
            ->name('users.index');
    });

    /*
    |--------------------------------------------------------------------------
    | PERFIL
    |--------------------------------------------------------------------------
    */
    Route::get('/profile', [ProfileController::class, 'edit'])
        ->name('profile.edit');

    Route::patch('/profile', [ProfileController::class, 'update'])
        ->name('profile.update');

    Route::delete('/profile', [ProfileController::class, 'destroy'])
        ->name('profile.destroy');
});

/*
|--------------------------------------------------------------------------
| Autenticación
|--------------------------------------------------------------------------
*/
require __DIR__ . '/auth.php';