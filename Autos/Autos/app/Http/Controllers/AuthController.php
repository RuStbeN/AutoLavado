<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    // Método para registrar usuarios
    public function register(Request $request)
    {
        // Validar los datos del registro
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8',
        ]);

        // Crear el usuario
        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);

        // Iniciar sesión automáticamente después del registro
        Auth::login($user);

        // Devolver la respuesta de éxito
        return response()->json(['message' => 'Usuario registrado correctamente']);
    }

    // Método para iniciar sesión
    public function login(Request $request)
    {
        // Validar los datos de inicio de sesión
        $request->validate([
            'email' => 'required|string|email',
            'password' => 'required|string',
        ]);

        // Intentar iniciar sesión
        if (!Auth::attempt($request->only('email', 'password'))) {
            return response()->json(['message' => 'Invalid login details'], 401);
        }

        // Devolver la respuesta de éxito
        return response()->json(['message' => 'Logeado correctamente']);
    }

    // Método para cerrar sesión
    public function logout(Request $request)
    {
        // Cerrar la sesión del usuario
        Auth::logout();

        // Devolver la respuesta de éxito
        return response()->json(['message' => 'cerrar sesion con exito'], 200);
    }
}
