<?php

namespace App\Http\Controllers\Logistica\Inventarios;

use Illuminate\Http\Request;
use DB;
use App\Http\Controllers\Controller;

class LineasController extends Controller
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
    

    // Crear y Actualizar Lineas
    public function createUpdateFamilias(Request $request, $Accion){
      $accion = 'M01';
      $CodEmp = $request->get('IdEmpresa');
      $CodAlm = $request->get('IdAlmacen'); 
      $IdLinea = $request->get('IdLinea');
      $IdPropiedad1 = $request->get('IdPropiedad1'); 
      $IdPropiedad2 = $request->get('IdPropiedad2'); 
      $Codigo = $request->get('Codigo');
      $Descripcion = $request->get('Descripcion');
      $Seccion = $request->get('Seccion');
      $Activo = $request->get('Activo');   

      $Linea =  DB::select('call Man_lo_lineas(?,?,?,?,?,?,?,?,?,?)'
      ,array(
            $Accion,
            $CodEmp,
            $CodAlm,
            $IdLinea,
            $IdPropiedad1,
            $IdPropiedad2,
            $Codigo,
            $Descripcion,
            $Seccion,
            $Activo                        
      ));

      if($Linea){
        if($Accion =='M01'){
          return response()->json(['Linea creada'=>$Linea], 201); 
        }else{
          return response()->json(['Datos de Linea actualizada'=>$Linea,200]); 
        }
      }  

    }

    
    public function updateFamilias(Request $request){
      $accion = 'M02';
      $IdLinea = $request->get('IdLinea');
      $DesFam = $request->get('Descripcion');
      $CodAlm = $request->get('IdAlmacen'); 
      $CodEmp = $request->get('IdEmpresa');  
      
      $Familias =  DB::select('call Man_lo_lineas(?,?,?,?,?,?,?,?,?,?)'
      ,array(
        $accion,
        $CodEmp,
        $CodAlm,
        $IdLinea,
        $DesFam,
        null                    
      ));
      return response()->json(['Familia Actualizada'=>$Familias], 200);
    }

    public function updateActivo($IdEmpresa,$IdAlmacen,$IdLinea, $Activo){
      $Lineas = DB::select('call Man_lo_lineas(?, ?, ?, ? ,?, ?, ?, ?, ?, ?)',
      array(
          'M03',
          $IdEmpresa,
          $IdAlmacen,
          $IdLinea,
          null,
          null,
          null,
          null,
          null,
          $Activo
      ));
      return Response()->json($IdLinea, 201);
    }

    public function deleteFamilias($IdEmpresa,$IdAlmacen,$IdLinea){
      $accion = 'M04';     

      $Familias = DB::select('call Man_lo_lineas(?,?,?,?,?,?,?,?,?,?)',
      array(
          $accion,
          $IdEmpresa,
          $IdAlmacen,
          $IdLinea,
          null,
          null,
          null,
          null,
          null,
          null      
      ));
      return response()->json(['Familia eliminada'=>$Familias], 200);      
    }

    
    //obtener Tipodocumentos
    public function getFamilias($CodEmp){
        $accion = 'S01';
        $Familias = DB::select('call Man_lo_lineas(?,?,?,?,?,?,?,?,?,?)',
        array(
            $accion,
            $CodEmp,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null
        ));
        return response()->json($Familias, 200);
    }

    public function getComboAlmacenes($CodEmp){
        $accion = 'S02';
        $Almacenes = DB::select('call Man_lo_lineas(?,?,?,?,?,?,?,?,?,?)',
        array(
            $accion,
            $CodEmp,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null
        ));
        return response()->json($Almacenes, 200);
    }    
    public function getComboPropiedades($CodEmp){
      $accion = 'S03';
      $Propiedades = DB::select('call Man_lo_lineas(?,?,?,?,?,?,?,?,?,?)',
      array(
          $accion,
          $CodEmp,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null
      ));
      return response()->json($Propiedades, 200);
  }    
}
