<?php

namespace App\Http\Controllers;

use App\Models\Auto;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException; 

class AutosController extends Controller
{
    public function view(Request $req)
    {
        if ($req->id == 0) {
            $auto = new Auto();
        } else {
            $auto = Auto::find($req->id);
        }

        return view('auto', compact('auto'));
    }


    public function store(Request $req)
    {

            $req->validate([
                'matricula' => 'required|numeric',
                'color' => 'required|string|max:20', 
                'modelo' => 'required|string',
                'marca' => 'required|string',
            ], 
            [
                'codigo.required' => 'El campo código es obligatorio.',
                'codigo.numeric' => 'El campo código debe ser un número.',
                'nombre.required' => 'El campo nombre es obligatorio.',
                'nombre.string' => 'El campo nombre debe ser una cadena de caracteres.',
                'nombre.max' => 'El campo nombre no puede tener más de :20.',
            ]);

            if ($req->id == 0) {
                $auto = new Auto();
            } else {
                $auto = Auto::findOrFail($req->id);
            }
            
            $auto->matricula = $req->matricula;
            $auto->color = $req->color;
            $auto->modelo = $req->modelo;
            $auto->marca = $req->marca;

            $auto->save();

            return redirect('auto/nuevo')->with('success', 'El auto se ha guardado correctamente.');

    }


    public function index()
    {
        $autos = Auto::all();

        return view('autos', compact('autos'));
    }


    public function delete($id)
    {
        $auto = Auto::findOrFail($id);
        $auto->delete();

        return redirect('autos')->with('success', 'El auto se ha eliminado correctamente.');
    }

    
}
