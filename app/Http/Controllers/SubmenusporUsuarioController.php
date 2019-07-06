<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class SubmenusporUsuarioController extends Controller
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
      $CodUsu = $request->get('CodUsu');     
      $Leer =  $request->get('Ver');;
      $Agregar = $request->get('Agregar');  
      $Editar = $request->get('Editar'); 
      $Eliminar = $request->get('Eliminar');
      $Imprimir = $request->get('Imprimir');  
      $MenuId = $request->get('IdMenu'); 
      

      $Submenu =  DB::select('call Man_zg_Submenuusuario(?, ?, ?, ?, ?, ?, ?, ?, ?)'
      ,array(
            $accion,
            null,  // idModulo
            $CodUsu ,
            $Leer,
            $Agregar,
            $Editar,
            $Eliminar,
            $Imprimir,
            $MenuId
                                 
      ));
      return response()->json(['Submenu creada'=>$Submenu], 201);
    }

    public function updateSubmenus(Request $request){
      $accion = 'M02';
      $CodUsu = $request->get('CodUsu');    
      $Ver = $request->get('Ver');
      $Agregar = $request->get('Agregar');  
      $Editar = $request->get('Editar'); 
      $Eliminar = $request->get('Eliminar'); 
      $Imprimir = $request->get('Imprimir');
      $MenuId = $request->get('IdMenu'); 
            

      $Submenu =  DB::select('call Man_zg_Submenuusuario(?,?,?,?,?,?,?,?,?)'
      ,array(
        $accion,
        null,  // idModulo
        $CodUsu,
        $Ver,
        $Agregar,
        $Editar,
        $Eliminar,
        $Imprimir,
        $MenuId
                   
      ));
      return response()->json(['Submenu Actualizada'=>$Submenu], 200);
    }
    
    public function permisosSubMenu($MenuId){
        $accion = 'S05';
        $MenuId;
        

        $Submenu = DB::select('call Man_zg_Submenuusuario(?,?,?,?,?,?,?,?)'
        ,
        array(
            $accion,
            null,
            null,
            null,
            null,
            null, 
            null,
            $MenuId
        ));
        return response()->json($Submenu, 200);
    }
    public function permisosSubMenux($MenuId){
        $accion = 'S06';
        $MenuId;       

        $Submenu = DB::select('call Man_zg_Submenuusuario(?,?,?,?,?,?,?,?)'
        ,
        array(
            $accion,
            null,
            null,
            null,
            null,
            null,
            null,
            $MenuId
        ));
        return response()->json($Submenu, 200);
    }


    public function permisos($CodUsu,$idModulo){
        
        $Submenu = DB::select('call Man_zg_Submenuusuario(?, ?, ?, ?, ?, ?, ?, ?, ?)'
        ,array(
            'S01',
            $idModulo,
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

    // public function getMenusporUsuario($CodUsu){
    //     $accion = 'S02';
    //     $SubmenuuserId = null;
    //     $SubmenuId = null;
    //     $CodUsu;

    //     $Submenu = DB::select('call Man_zg_Submenuusuario(?,?,?,?,?,?,?,?)'
    //     ,
    //     array(
    //         $accion,
    //         $CodUsu,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null,
    //         null
            
    //     ));
    //     return response()->json($Submenu, 200);
    // }
    
    public function permisossubmenus($CodUsu, $idModulo){
        $accion = 'S03';

        $Submenu = DB::select('call Man_zg_Submenuusuario(?,?,?,?,?,?,?,?,?)'
        ,
        array(
            'S03',
            $idModulo,
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
    

    public function getMenus(){
        $accion = 'S04';      

        $Submenu = DB::select('call Man_zg_Submenuusuario(?,?,?,?,?,?,?,?)'
        ,
        array(
            $accion,
            null,
            null,
            null,
            null,
            null,
            null,
            null           
        ));
        return response()->json($Submenu, 200);
    }
       
}
