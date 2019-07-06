<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class UsuariosEmpresasController extends Controller
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


    public function createUsuariosEmpresas(Request $request){
        $accion = 'M01';
       // $IdUsuEmp = null;
        $CodUsu = $request->get('CodUsu');
        $CodEmp = $request->get('CodEmp');
        
  
        $UsuarioEmpresa =  DB::select('call Man_zg_usuariosempresas(?,?,?)'
        ,array(
              $accion,
         //     $IdUsuEmp,
              $CodUsu,
              $CodEmp           
        ));
        return response()->json(['Usuario creado'=>$UsuarioEmpresa], 201);
      }
      
      
    public function deleteUsuariosEmpresas($IdUsu,$IdEmp){
        $accion = 'M03';
        //$IdUsuEmp;
            
        $UsuariosEmpresas = DB::select('call Man_zg_usuariosempresas(?,?,?)',
        array(
            $accion,
            $CodUsu = $IdUsu,
            $CodEmp = $IdEmp               
        ));
        return response()->json(['Usuario eliminado'=>$UsuariosEmpresas], 200);      
      }
      
    public function getUsuariosEmpresas(){
        $accion = 'S01';
        $CodUsu = $request->get('CodUsu');
        $CodEmp = null;   
        $UsuariosEmpresas = DB::select('call Man_zg_usuariosempresas(?,?,?)',
        array(
            $accion,
            $CodUsu,
            null
        ));

        return response()->json($UsuariosEmpresas, 200);
    }

    //Arreglados
    public function getComboUsuarios($isUsuario){
               
        $UsuariosEmpresas = DB::select('call Man_zg_usuariosempresas(?,?,?)',
        array(
            'S03', //Accion
            $isUsuario,
            null
        ));
        return response()->json($UsuariosEmpresas, 200);
    }  

    public function getEmpresasporUsuario($CodUsu){
        
        $UsuariosEmpresas = DB::select('call Man_zg_usuariosempresas(?,?,?)',
        array(
            'S04',//Accion
            $CodUsu,
            null
        ));
        return response()->json($UsuariosEmpresas, 200);
    }  
    
}
