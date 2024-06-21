<?php

namespace App\Http\Controllers;

use App\Models\Servicio;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException; 

class ServiciosController extends Controller
{
    public function view(Request $req)
    {
        if ($req->id == 0) {
            $servicio = new Servicio();
        } else {
            $servicio = Servicio::find($req->id);
        }

        $servicios = Servicio::all();

        return view('servicio', compact('servicio', 'servicios'));
    }

    
    public function show(Request $request){
        $servicio = Servicio::find($request->id);
        return response()->json($servicio);
    }

    public function viewApi(Request $req)
    {
        if ($req->id == 0) {
            $servicio = new Servicio();
        } else {
            $servicio = Servicio::find($req->id);
            if (!$servicio) {
                return response()->json(['error' => 'Servicio not found'], 404);
            }
        }

        $servicio->update($req->all());

        return response()->json($servicio);
    }

    public function store(Request $req)
    {
        $req->validate([
            'codigo' => 'required|numeric',
            'nombre' => 'required|string|max:20', 
            'descripcion' => 'required|string',
            'precio' => 'required|numeric',
        ], 
        [
            'codigo.required' => 'El campo código es obligatorio.',
            'codigo.numeric' => 'El campo código debe ser un número.',
            'nombre.required' => 'El campo nombre es obligatorio.',
            'nombre.string' => 'El campo nombre debe ser una cadena de caracteres.',
            'nombre.max' => 'El campo nombre no puede tener más de :max caracteres.',
            'descripcion.required' => 'El campo descripción es obligatorio.',
            'descripcion.string' => 'El campo descripción debe ser una cadena de caracteres.',
            'precio.required' => 'El campo precio es obligatorio.',
            'precio.numeric' => 'El campo precio debe ser un número.',
        ]);

        if ($req->id == 0) {
            $servicio = new Servicio();
        } else {
            $servicio = Servicio::findOrFail($req->id);
        }
        
        $servicio->codigo = $req->codigo;
        $servicio->nombre = $req->nombre;
        $servicio->descripcion = $req->descripcion;
        $servicio->precio = $req->precio;

        $servicio->save();

        return redirect('servicio/nuevo')->with('success', 'El servicio se ha guardado correctamente.');
    }

    public function storeApi(Request $req)
    {
        $req->validate([
            'codigo' => 'required|numeric',
            'nombre' => 'required|string|max:20', 
            'descripcion' => 'required|string',
            'precio' => 'required|numeric',
        ], 
        [
            'codigo.required' => 'El campo código es obligatorio.',
            'codigo.numeric' => 'El campo código debe ser un número.',
            'nombre.required' => 'El campo nombre es obligatorio.',
            'nombre.string' => 'El campo nombre debe ser una cadena de caracteres.',
            'nombre.max' => 'El campo nombre no puede tener más de :max caracteres.',
            'descripcion.required' => 'El campo descripción es obligatorio.',
            'descripcion.string' => 'El campo descripción debe ser una cadena de caracteres.',
            'precio.required' => 'El campo precio es obligatorio.',
            'precio.numeric' => 'El campo precio debe ser un número.',
        ]);

        if ($req->id == 0) {
            $servicio = new Servicio();
        } else {
            $servicio = Servicio::find($req->id);
            if (!$servicio) {
                return response()->json(['error' => 'Servicio not found'], 404);
            }
        }

        $servicio->codigo = $req->codigo;
        $servicio->nombre = $req->nombre;
        $servicio->descripcion = $req->descripcion;
        $servicio->precio = $req->precio;

        $servicio->save();

        return 'OK';
    }

    public function index()
    {
        $servicios = Servicio::all();

        return view('servicios', compact('servicios'));
    }

    public function indexApi()
    {
        $servicios = Servicio::all();
        return response()->json($servicios);
    }

    public function delete($id)
    {
        $servicio = Servicio::findOrFail($id);
        $servicio->delete();

        return redirect('servicios')->with('success', 'El servicio se ha eliminado correctamente.');
    }

    public function deleteApi($id)
    {
        $servicio = Servicio::find($id);
        if (!$servicio) {
            return response()->json(['error' => 'Servicio not found'], 404);
        }
    
        $servicio->delete();
        return 'OK';
    }
        
    

    public function showServicioForm($id = null)
    {
        $servicio = $id ? Servicio::with('etapas')->find($id) : new Servicio();
        return view('servicio.form', compact('servicio'));
    }
}
