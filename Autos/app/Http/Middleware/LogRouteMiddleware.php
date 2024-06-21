<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Log;

class LogRouteMiddleware
{
    public function handle($request, Closure $next)
    {
        $route = $request->route()->uri();
        Log::channel('pruebas')->info('Acceso a la ruta: ' . $route);
        
        return $next($request);
    }
}
