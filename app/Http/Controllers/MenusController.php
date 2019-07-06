<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class MenusController extends Controller
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
      $IdMenu = null; 
      $idModulo = null; // id del modulo selecionado     
      $NombreMenu = $request->get('Nombre');
      $Codigo = null;      

      $Menus = DB::select('call Man_zg_Menus(?,?,?,?,?)'
      ,array(
            $accion,
            $IdMenu,
            $idModulo,
            $NombreMenu,
            $Codigo
                      
      ));
      return response()->json(['Menu creada'=>$NombreMenu], 201);
    }

    public function updateMenus(Request $request){
      $accion = 'M02';
      $MenuId = $request->get('IdMenu');
      $IdModulo = $request->get('IdModulo');
      $NombreMenu = $request->get('Nombre');
      $Codigo = $request->get('Codigo');         

      $Menus =  DB::select('call Man_zg_Menus(?,?,?,?,?)'
      ,array(
        $accion,
        $MenuId,
        $IdModulo,
        $NombreMenu,
        $Codigo                 
      ));
      return response()->json(['Menu Actualizada'=>$Menus], 200);
    }

    public function deleteMenus($MenuId){
      $accion = 'M03';
      $MenuId;
     
      $Menus = DB::select('call Man_zg_Menus(?,?,?,?,?)',
      array(
          $accion,
          $MenuId,
          null,
          null,
          null               
      ));
      return response()->json(['Menu eliminada'=>$Menus], 200);      
    }

    public function getMenus(){
        $accion = 'S01';
        $Menus = DB::select('call Man_zg_Menus(?,?,?,?,?)',
        array(
            $accion,
            null,
            null,
            null,
            null
        ));
        return response()->json($Menus, 200);
    }
    
       
}
