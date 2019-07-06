<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class SubmenusController extends Controller
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
    
    
    public function createSubmenus(Request $request){
      $accion = 'M01';
      $SubmenuId = null;      
      $MenuId = $request->get('IdMenu');
      $Submenunombre = $request->get('Nombre');
      $Activo = null; 

      $Submenus =  DB::select('call Man_zg_Submenus(?,?,?,?,?)'
      ,array(
            $accion,
            null,
            $MenuId,
            $Submenunombre,
            null                     
      ));
      return response()->json(['Submenu creada'=>$Submenus], 201);
    }

    public function updateSubmenus(Request $request){
      $accion = 'M02';
      $SubmenuId = $request->get('IdSubmenu');   
      $MenuId = $request->get('IdMenu');
      $Submenunombre = $request->get('Nombre');   
      $Codigo = $request->get('Codigo'); ; 

      $Submenus =  DB::select('call Man_zg_Submenus(?,?,?,?,?)'
      ,array(
        $accion,
        $SubmenuId,
        $MenuId,
        $Submenunombre,
        $Codigo    
      ));
      return response()->json(['Submenu Actualizada'=>$Submenus], 200);
    }

    public function deleteSubmenus($SubmenuId){
      $accion = 'M03';
      $SubmenuId;
      
      $Submenus = DB::select('call Man_zg_Submenus(?,?,?,?,?)',
      array(
          $accion,
          $SubmenuId,
          null,
          null,
          null            
      ));
      return response()->json(['Submenu eliminada'=>$Submenus], 200);      
    }

    public function getSubmenus(){
        $accion = 'S01';
        $Submenus = DB::select('call Man_zg_Submenus(?,?,?,?,?)',
        array(
            $accion,
            null,
            null,
            null,
            null
        ));
        return response()->json($Submenus, 200);
    }
    public function getMenus(){
        $accion = 'S08';
        $Submenus = DB::select('call Man_zg_Submenuusuario(?, ?, ?, ?, ?, ?, ?, ?, ?)',
        array(
            $accion,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null
        ));
        return response()->json($Submenus, 200);
    }
    
       
}
