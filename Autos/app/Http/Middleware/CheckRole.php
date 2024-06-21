<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class CheckRole
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @param  string|array  $roles
     * @return mixed
     */
    public function handle(Request $request, Closure $next, ...$roles)
    {
        // Verifica si el usuario está autenticado y tiene al menos uno de los roles especificados
        if (Auth::check() && Auth::user()->hasAnyRole($roles)) {
            return $next($request);
        }

        // Si el usuario no tiene los roles requeridos, devuelve una respuesta de acceso no autorizado
        abort(403, 'No tienes permitido acceder a esta página.');
    }
}