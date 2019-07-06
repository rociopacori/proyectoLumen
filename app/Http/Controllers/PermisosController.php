<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class PermisosController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }
    //its supposed redirects automatically here  
    // $NombreMenu,
    public function getPermisos( $CodUsu, $Submenunombre){
        $permisos = DB::select('call Man_zg_ver(?,?)'
        ,
        array(
            // $NombreMenu,
            $CodUsu,
            $Submenunombre
        ));
        return response()->json($permisos, 200);

    }
    public function getPlanModuloUser($idUsuario){
        $accion = 'S01';
        
        $planUser = DB::select('call Man_zg_usuarioplan(?,?,?,?,?,?)'
        ,array(
            $accion,
            $idUsuario,
            null,
            null,
            null,
            null
        ));

        return response()->json($planUser, 200);
    }   



}
