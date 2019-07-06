<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class UsuariosSucursalController extends Controller
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


    public function createUsuariosSucursal(Request $request){
        $accion = 'M01';
        $CodUsu = $request->get('CodUsu');
        $CodSuc = $request->get('CodSuc');
        $CodEmp = $request->get('CodEmp');
  
        $UsuarioSucursal =  DB::select('call Man_zg_usuariossucursales(?,?,?,?)'
        ,array(
              $accion,
              $CodUsu,
              $CodSuc,
              $CodEmp            
        ));
        return response()->json(['Usuario creado'=>$UsuarioSucursal], 201);
      }
      
      
    public function deleteUsuariosSucursal(Request $request){
        $accion = 'M03';
        $CodUsu = $request->get('CodUsu');
        $CodSuc = $request->get('CodSuc');
        $CodEmp = $request->get('CodEmp');     
            
  
        $UsuarioSucursal = DB::select('call Man_zg_usuariossucursales(?,?,?,?)',
        array(
            $accion,
            $CodUsu,
            $CodSuc,
            $CodEmp             
        ));
        return response()->json(['Usuario eliminado'=>$UsuarioSucursal], 200);      
      }
      
    public function getComboUsuarios($idUsuario){
        $accion = 'S02';        
        $UsuarioSucursal = DB::select('call Man_zg_usuariossucursales(?,?,?,?)',
        array(
            $accion,
            $idUsuario,
            null,
            null
        ));
        return response()->json($UsuarioSucursal, 200);
    }  

    public function getComboEmpresas($CodUsu){
        $accion = 'S03';
        $CodUsu;
        $CodSuc = null; 
        $CodEmp = null;

        $UsuarioSucursal = DB::select('call Man_zg_usuariossucursales(?,?,?,?)',
        array(
            $accion,
            $CodUsu,
            null,
            null            
        ));

        return response()->json($UsuarioSucursal, 200);
    }



    public function getUsuariosSucursal($CodUsu,$CodEmp){
        $accion = 'S04';
        $CodUsu;
        $CodSuc = null; 
        $CodEmp;
        
        $UsuarioSucursal = DB::select('call Man_zg_usuariossucursales(?,?,?,?)',
        array(
            $accion,
            $CodUsu,
            null,
            $CodEmp
        ));
        return response()->json($UsuarioSucursal, 200);
    }  
    
}
