<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\TagController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\IngresoEgresoController;
use App\Http\Controllers\Admin\Rol\RolesController;
use App\Http\Controllers\Carpeta\CarpetaController;
use App\Http\Controllers\Patient\PatientController;
use App\Http\Controllers\Carpeta\MovimientoCarpetas;
use App\Http\Controllers\Admin\Staff\StaffsController;
use App\Http\Controllers\Admin\Doctor\DoctorsController;
use App\Http\Controllers\Dashboard\DashboardKpiController;
use App\Http\Controllers\Admin\Doctor\SpecialityController;
use App\Http\Controllers\Appointment\AppointmentController;
use App\Http\Controllers\Appointment\AppointmentPayController;
use App\Http\Controllers\Carpeta\MovimientoCarpetasController;
use App\Http\Controllers\Appointment\AppointmentAttentionController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::group([

   //'middleware' => 'auth:api',
   'prefix' => 'auth',
   // 'middleware' => ['role:admin','permission:publish articles'],
], function ($router) {
    Route::post('/register', [AuthController::class, 'register'])->name('register');
    Route::post('/login', [AuthController::class, 'login'])->name('login');
    Route::post('/logout', [AuthController::class, 'logout'])->name('logout');
    Route::post('/refresh', [AuthController::class, 'refresh'])->name('refresh');
    Route::post('/me', [AuthController::class, 'me'])->name('me');
    Route::post('/list', [AuthController::class, 'list']);
    Route::post('/reg', [AuthController::class, 'reg']);
});

Route::group([
    'middleware' => 'auth:api',
], function ($router) {
    Route::resource("roles",RolesController::class);
    Route::get("staffs/config",[StaffsController::class,"config"]);
    Route::post("staffs/{id}",[StaffsController::class,"update"]);
    Route::resource("staffs",StaffsController::class);
    Route::resource("specialities",SpecialityController::class);
    Route::get("doctors/profile/{id}",[DoctorsController::class,"profile"]);
    Route::get("doctors/config",[DoctorsController::class,"config"]);
    Route::post("doctors/{id}",[DoctorsController::class,"update"]);
    Route::resource("doctors",DoctorsController::class);
    Route::get("patients/profile/{id}",[PatientController::class,"profile"]);
    Route::post("patients/{id}",[PatientController::class,"update"]);
    Route::resource("patients",PatientController::class);
    Route::get("appointment/config",[AppointmentController::class,"config"]);
    Route::get("appointment/patient",[AppointmentController::class,"query_patient"]);
    Route::post("appointment/filter",[AppointmentController::class,"filter"]);
    Route::post("appointment/calendar",[AppointmentController::class,"calendar"]);
    Route::resource("appointment",AppointmentController::class);
    Route::resource("appointment-pay",AppointmentPayController::class);
    Route::resource("appointment-attention",AppointmentAttentionController::class);
    Route::post("dashboard/admin",[DashboardKpiController::class,"dashboard_admin"]);
    Route::post("dashboard/admin-year",[DashboardKpiController::class,"dashboard_admin_year"]);
    Route::post("dashboard/doctor",[DashboardKpiController::class,"dashboard_doctor"]);
    Route::post("dashboard/doctor-year",[DashboardKpiController::class,"dashboard_doctor_year"]);
    Route::get("dashboard/config",[DashboardKpiController::class,"config"]);
    Route::get("carpetas/profile/{id}",[CarpetaController::class,"profile"]);
    Route::get('carpetas/{id}', [CarpetaController::class, 'show']);
    Route::resource("carpetas",CarpetaController::class);
    Route::get("carpeta/config",[CarpetaController::class,"config"]);
    Route::resource("movimiento-carpetas",MovimientoCarpetasController::class);
    Route::get('movimientos', [MovimientoCarpetasController::class, 'getMovimientos']);

    Route::get('carpetas/{carpeta_id}/archivos', [MovimientoCarpetasController::class, 'getArchivosAdjuntos']);
    Route::put('/carpeta/{id}/estado', [CarpetaController::class, 'updateEstado']);

    Route::get('carpetas/{id}/ingresos_egresos', [IngresoEgresoController::class, 'index']);
    Route::post('ingresos_egresos', [IngresoEgresoController::class, 'store']);
    Route::delete('ingresos_egresos/{id}', [IngresoEgresoController::class, 'destroy']);


    Route::get('in_out', [IngresoEgresoController::class, 'index']);



    Route::get('tags', [TagController::class, 'index']);
    Route::post('tags', [TagController::class, 'store']);
    Route::get('tags/{id}', [TagController::class, 'show']);
    Route::put('tags/{id}', [TagController::class, 'update']);
    Route::delete('tags/{id}', [TagController::class, 'destroy']);


    Route::put('carpetas/{id}/tags', [CarpetaController::class, 'updateTags']);
    Route::get('carpetas/{id}/tags', [CarpetaController::class, 'getTags']);

    // Agregar la ruta para obtener sugerencias de apellidos
    Route::get('/patients/surname-suggestions', [PatientController::class, 'getSurnameSuggestions']);
    Route::get('/patients/document-suggestions', [PatientController::class, 'getDocumentSuggestions']);
    Route::get('/patients/document-suggestions', [PatientController::class, 'getDocumentSuggestions']);

    Route::post('/carpetas/filter', [CarpetaController::class, 'filterCarpetas']);

});
