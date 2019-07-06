<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class ProveedoresController extends Controller
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
    
    public function createProveedores(Request $request){
        $accion = 'M01';
        $IdProvee = null; 
        $CodEmp = $request->get('CodEmp');    
        $TipoDoc = $request->get('TipoDoc'); 
        $NomTipDoc = $request->get('NomTipDoc');  
        $NumDoc = $request->get('NumDoc');  
        $Nombre = $request->get('Nombre'); 
        $NombComercial = $request->get('NombComercial'); 
        $idPais = $request->get('IdPais');     
        $idDepa = $request->get('IdDepartamento');
        $idProv = $request->get('IdProvincia');
        $idDist = $request->get('IdDistrito'); 
        $DirPer = $request->get('Direccion');  
        $Telefono = $request->get('Telefono');   
        $Email = $request->get('Email'); 
        $Activo = null; 

        $proveedores =  DB::select('call Man_zg_proveedores(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)'
        ,array(
              $accion,
              $IdProvee,
              $CodEmp,    
              $TipoDoc, 
              $NomTipDoc,  
              $NumDoc,  
              $Nombre, 
              $NombComercial, 
              $idPais,     
              $idDepa,
              $idProv,
              $idDist, 
              $DirPer,  
              $Telefono,   
              $Email, 
              $Activo
                        
        ));
        return response()->json($request, 201);
        // return response()->json(['proveedor creado'=>$request], 201);
      }
  
      public function updateProveedores(Request $request){
        $accion = 'M02';
        $IdProvee = $request->get('IdProveedor');
        $CodEmp = $request->get('CodEmp');    
        $TipoDoc = $request->get('TipoDoc'); 
        $NomTipDoc = $request->get('NomTipDoc');  
        $NumDoc = $request->get('NumDoc');  
        $Nombre = $request->get('Nombre'); 
        $NombComercial = $request->get('NombComercial'); 
        $idPais = $request->get('IdPais');     
        $idDepa = $request->get('IdDepartamento');
        $idProv = $request->get('IdProvincia');
        $idDist = $request->get('IdDistrito'); 
        $DirPer = $request->get('Direccion');  
        $Telefono = $request->get('Telefono');   
        $Email = $request->get('Email');  
        $Activo = $request->get('Activo');

        $proveedores =  DB::select('call Man_zg_proveedores(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)'
        ,array(
            $accion,
            $IdProvee,
            $CodEmp,    
            $TipoDoc, 
            $NomTipDoc,  
            $NumDoc,  
            $Nombre, 
            $NombComercial, 
            $idPais,     
            $idDepa,
            $idProv,
            $idDist, 
            $DirPer,  
            $Telefono,   
            $Email, 
            $Activo
                        
        ));
        return response()->json($request, 201);
        // return response()->json(['proveedor creada'=>$proveedores], 201);
      }
  
      public function deleteProveedores($CodPro,$Activo){
          $accion = 'M03';
          
          $proveedores = DB::select('call Man_zg_proveedores(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)'
          ,array(
              $accion,
              $CodPro,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              $Activo
          ));
          return response()->json($proveedores, 200);
      } 
     
    public function getProveedores($CodEmp){
        $accion = 'S01';
        
        $proveedores = DB::select('call Man_zg_proveedores(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)'
        ,
        array(
            $accion,
            null,
            $CodEmp,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null           
        ));
        return response()->json($proveedores, 200);
    } 

      
    public function getPaises(){
        $accion = 'S02';
        $proveedores = DB::select('call Man_zg_proveedores(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)'
        ,
        array(
            $accion,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null

        ));
        return response()->json($proveedores, 200);
    }


    public function getDepartamentos(){
        $accion = 'S03';
        $proveedores = DB::select('call Man_zg_proveedores(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)'
        ,
        array(
            $accion,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null

        ));
        return response()->json($proveedores, 200);
    }

    public function getProvincias($idDepa){
        $accion = 'S04';
        $proveedores = DB::select('call Man_zg_proveedores(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)'
        ,array(
            $accion,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            $idDepa,
            null,
            null,
            null,
            null,
            null,
            null            
        ));
        return response()->json($proveedores, 200);
    }

    public function getDistritos($idProv){
        $accion = 'S05';
        $proveedores = DB::select('call Man_zg_proveedores(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)'
        ,
        array(
            $accion,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,            
            $idProv,
            null,
            null,
            null,
            null,
            null           
        ));
        return response()->json($proveedores, 200);
    }
    
}
