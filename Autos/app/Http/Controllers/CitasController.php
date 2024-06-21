<?php

namespace App\Http\Controllers;

use App\Models\Cita;
use App\Models\User;
use App\Models\Auto;
use App\Models\Servicio;
use Illuminate\Http\Request;

class CitasController extends Controller
{
    public function view(Request $req)
    {
        if ($req->id == 0) {
            $cita = new Cita();
        } else {
            $cita = Cita::find($req->id);
        }

        $users = User::all();
        $autos = Auto::all();
        $servicios = Servicio::all();

        return view('cita', compact('cita','users','autos','servicios'));
    }


    public function store(Request $req)
    {

        $req->validate([
            'id_usuario' => 'required|string',
            'id_auto' => 'required|string|max:20', 
            'id_servicio' => 'required|string',
            'fecha' => 'required|date',
            'hora_cita' => 'required|string',
        ], 
        [
            'codigo.required' => 'El campo código es obligatorio.',
            'codigo.numeric' => 'El campo código debe ser un número.',
            'nombre.required' => 'El campo nombre es obligatorio.',
            'nombre.string' => 'El campo nombre debe ser una cadena de caracteres.',
            'nombre.max' => 'El campo nombre no puede tener más de :20.',
        ]);

        if ($req->id == 0) {
            $cita = new Cita();
        } else {
            $cita = Cita::findOrFail($req->id);
        }

        $cita->id_usuario =$req->id_usuario;
        $cita->id_servicios=$req->id_servicio;
        $cita->id_auto =$req->id_auto;
        $cita->fecha =$req->fecha;
        $cita->hora_cita =$req->hora_cita;

        $cita->save();

        return redirect('cita/nuevo')->with('success', 'La cita se ha guardado correctamente.');
    }


    public function index()
    {
        $citas = Cita::all();
        $cita_usuario = User::pluck('name', 'id');

    
        return view('citas', compact('citas'));
    }

    public function delete($id)
    {
        $cita = Cita::findOrFail($id);
        $cita->delete();

        return redirect('citas')->with('success', 'La cita se ha eliminado correctamente.');
    }  

}


