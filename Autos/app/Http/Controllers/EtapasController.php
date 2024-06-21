<?php

namespace App\Http\Controllers;

use App\Models\Etapa;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;

class EtapasController extends Controller
{
    public function viewApi(Request $req)
    {
        if ($req->id == 0) {
            $etapa = new Etapa();
        } else {
            $etapa = Etapa::find($req->id);
            if (!$etapa) {
                return response()->json(['error' => 'Etapa not found'], 404);
            }
        }

        $etapa->update($req->all());

        return response()->json($etapa);
    }

    public function show($id_servicios)
    {
        $etapas = Etapa::where('id_servicios', $id_servicios)->get();

        if ($etapas->isEmpty()) {
            return response()->json(['error' => 'No se encontraron etapas para este servicio'], 404);
        }

        return response()->json($etapas);
    }

    public function store(Request $request)
    {
        $request->validate([
            'id_servicios' => 'required|exists:servicios,id',
            'nombre' => 'required|string|max:255',
            'duracion' => 'required|integer',
        ]);

        $etapa = new Etapa();
        $etapa->id_servicios = $request->id_servicios;
        $etapa->nombre = $request->nombre;
        $etapa->duracion = $request->duracion;
        $etapa->save();

        return redirect()->back()->with('success', 'Etapa añadida correctamente.');
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'nombre' => 'required|string|max:255',
            'duracion' => 'required|integer',
        ]);

        $etapa = Etapa::findOrFail($id);
        $etapa->nombre = $request->nombre;
        $etapa->duracion = $request->duracion;
        $etapa->save();

        return 'OK';
    }

    public function storeApi(Request $request)
    {
        $request->validate([
            'id_servicios' => 'required|exists:servicios,id',
            'nombre' => 'required|string|max:255',
            'duracion' => 'required|integer',
        ]);

        $etapa = new Etapa();
        $etapa->id_servicios = $request->id_servicios;
        $etapa->nombre = $request->nombre;
        $etapa->duracion = $request->duracion;
        $etapa->save();

        return "OK";
    }

    public function delete($id)
    {
        $etapa = Etapa::findOrFail($id);
        $etapa->delete();

        return redirect()->back()->with('success', 'Etapa eliminada correctamente.');
    }

    public function deleteApi($id)
    {
        $etapa = Etapa::findOrFail($id);
        $etapa->delete();

        return "OK";
    }

    public function moveUp(Etapa $etapa)
    {
        $etapa->moveOrderUp();
        return redirect()->back()->with('success', 'Etapa movida hacia arriba correctamente.');
    }

    public function moveDown(Etapa $etapa)
    {
        $etapa->moveOrderDown();
        return redirect()->back()->with('success', 'Etapa movida hacia abajo correctamente.');
    }
}
