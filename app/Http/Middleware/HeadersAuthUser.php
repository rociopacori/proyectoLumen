<?php

namespace App\Http\Middleware;

use Closure;


class HeadersAuthUser
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
       if(!$request->isJson() && !$request->header('Authorization') || $request->header('Content-Type') == 'multipart/form-data' && !$request->header('Authorization' ) ){
           return response()->json('Unauthorized', 401);
        }

       // validar token del usuario existentes
       if( $request->isJson()  && $request->header('Authorization') || $request->header('Content-Type') == 'multipart/form-data'){
            $token =  substr($request->header('Authorization'),7);
            $users = \DB::table('zg_zusuarios')
            ->select('logClave')
            ->where('logClave', '=', $token)
            ->get();

           return sizeof($users) > 0 ? $next($request) : response()->json('Unauthorized', 401);
        }

      // return $next($request);
    }
}
