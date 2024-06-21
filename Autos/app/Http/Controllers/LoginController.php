<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class LoginController extends Controller
{
    public function login(Request $req)
    {
        if (Auth::attempt(['email' => $req->email, 'password' => $req->password])) {
            $user = Auth::user();
            $token = $user->createToken('app')->plainTextToken;
            $arr = array(
                'acceso' => 'OK',
                'error' => '',
                'token' => $token,
                'idUsuario' => $user->id,
                'nombreUsuario' => $user->name
                
                
            );
            return json_encode($arr);
        } else {
            $arr = array(
                'acceso' => '',
                'error' => 'No existe usuario o contraseña',
                'token' => '',
                'idUsuario' => 0,
                'nombreUsuario' => ''
            

            );
            return json_encode($arr);
        }
    }
}
