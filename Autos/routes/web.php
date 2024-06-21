<?php

use App\Http\Controllers\AutosController;
use App\Http\Controllers\ServiciosController;
use App\Http\Controllers\CitasController;
use App\Http\Controllers\EtapasController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Auth::routes();

Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');



Route::get('/auto/nuevo', [AutosController::class, 'view'])->name('auto.nuevo');

Route::post('/auto/guardar', [AutosController::class, 'store'])->name('auto.guardar');

Route::get('/autos', [AutosController::class, 'index'])->name('autos');

Route::delete('/auto/eliminar/{id}', [AutosController::class, 'delete'])->name('auto.eliminar');




Route::get('/servicio/nuevo', [ServiciosController::class, 'view'])->name('servicio.nuevo');

Route::post('/servicio/guardar', [ServiciosController::class, 'store'])->name('servicio.guardar');

Route::get('/servicios', [ServiciosController::class, 'index'])->name('servicios');

Route::delete('/servicio/eliminar/{id}', [ServiciosController::class, 'delete'])->name('servicio.eliminar');



Route::get('/etapa/nuevo', [EtapasController::class, 'view'])->name('etapa.nuevo');

Route::post('/etapa/guardar', [EtapasController::class, 'store'])->name('etapa.guardar');

Route::get('/etapas', [EtapasController::class, 'index'])->name('etapas');

Route::delete('/etapa/eliminar/{id}', [EtapasController::class, 'delete'])->name('etapa.eliminar');

Route::put('etapa/{id}/update', [EtapasController::class, 'update'])->name('etapa.update');






Route::get('/cita/nuevo', [CitasController::class, 'view'])->name('cita.nuevo');

Route::post('/cita/guardar', [CitasController::class, 'store'])->name('cita.guardar');

Route::get('/citas', [CitasController::class, 'index'])->name('citas');

Route::delete('/cita/eliminar/{id}', [CitasController::class, 'delete'])->name('cita.eliminar');



Route::post('/etapa/store', [EtapasController::class, 'store'])->name('etapa.store');
Route::delete('/etapa/destroy', [EtapasController::class, 'destroy'])->name('etapa.destroy');
Route::post('/etapa/moveUp', [EtapasController::class, 'moveUp'])->name('etapa.moveUp');
Route::post('/etapa/moveDown', [EtapasController::class, 'moveDown'])->name('etapa.moveDown');

