<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class LoginController extends Controller
{
    public function Login(Request $req){

        if (Auth::attempt(['email' => $req->email, 'password' => $req->password]))
        {
            $user = Auth::user();
            $token = $user->createToken('app')->plainTextToken;
            $arr = array('acceso' => 'OK', 'token' => $token, 'nombre' => $user->name, 'id_usuario'=> $user->id, 'error' => '');
            return json_encode($arr);


        }
        else 
        {
            $arr = array('acceso' => '', 'token' => '', 'error' => 'No existe usuario o contrasena');
            return  json_encode($arr);
        }
    } 
}
