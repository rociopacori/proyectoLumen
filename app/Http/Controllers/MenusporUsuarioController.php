<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class MenusporUsuarioController extends Controller
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
    
    
    public function createMenus(Request $request){
      $accion = 'M01';     
      $MenuId = $request->get('IdMenu');
      $CodUsu = $request->get('IdUsuario');   
      $Activo = null;       

      $Menus =  DB::select('call Man_zg_Menuusuario(?,?,?,?)'
      ,array(
            $accion,
            $MenuId,
            $CodUsu,
            $Activo                      
      ));
      return response()->json(['Menu creada'=>$Menus], 201);
    }

    public function updateMenus(Request $request){
      $accion = 'M02';
      $MenuId = $request->get('IdMenu');
      $CodUsu = $request->get('IdUsuario');   
      $Activo = $request->get('Activo');     

      $Menus =  DB::select('call Man_zg_Menuusuario(?,?,?,?)'
      ,array(
        $accion,
        $MenuId,
        $CodUsu,
        $Activo           
      ));
      return response()->json(['Menu Actualizada'=>$Menus], 200);
    }
    
    public function getMenusporUsuario($CodUsu){
        $accion = 'S06';

        $Submenu = DB::select('call Man_zg_Submenuusuario(?,?,?,?,?,?,?,?)'
        ,
        array(
            $accion,
            $CodUsu,
            null,
            null,
            null,
            null,
            null,
            null
            
        ));
        return response()->json($Submenu, 200);
    }
    public function permisos($CodUsu){
        $accion = 'S02';
    //    $MenuuserId = null;
    //    $MenuId = null;
        $CodUsu;
    //   $Activo = null;

        $Menus = DB::select('call Man_zg_Submenuusuario(?,?,?,?,?,?,?,?,?)',
        array(
            $accion,
            null,
            $CodUsu,
            null,
            null,
            null,
            null,
            null,
            null
        ));
        return response()->json($Menus, 200);
    }
    public function permisosmenu($CodUsu,$idModulo){
        
        $Menus = DB::select('call Man_zg_Menuusuario(?,?,?,?,?)',
        array(
            'S02',
            $idModulo,
            $CodUsu,
            null,
            null
        ));
        return response()->json($Menus, 200);
    }
           
}
