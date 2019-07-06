<?php

namespace App\Http\Controllers\Logistica\Inventarios;

use Illuminate\Http\Request;
use DB;
use App\Http\Controllers\Controller;

class SubLineasController extends Controller
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
    
    
    public function createSubLineas(Request $request){
      $accion = 'M01';      
      $CodEmp = $request->get('CodEmp'); 
      $CodLin = $request->get('IdFamilia');     
      $CodSubLin = null; 
      $DesLin = $request->get('Descripcion'); 
    //   $CodFam = $request->get('CodFam');   
      $Activo = $request->get('Activo');
              

      $Linea =  DB::select('call Man_lo_sublineas(?,?,?,?,?,?)'
      ,array(
            $accion,
            $CodEmp,
            $CodLin,
            null,
            $DesLin,
            $Activo           
      ));
      return response()->json(['Linea creada'=>$Linea], 201);
    }

    //Actualizar Tipodocumentos
    public function updateLineas(Request $request){
      $accion = 'M02';      
      $CodEmp = $request->get('IdEmpresa'); 
      $CodLin = $request->get('IdFamilia');
      $CodSubLin = $request->get('IdLinea');
      $DesLin = $request->get('Descripcion');
    //   $CodFam = $request->get('CodFam');   
      $Activo = $request->get('Activo');
      
      
      $Linea =  DB::select('call Man_lo_sublineas(?,?,?,?,?,?)'
      ,array(
        $accion,
        $CodEmp,
        $CodLin,
        $CodSubLin,
        $DesLin,
        $Activo 

      ));

      return response()->json(['Linea Actualizada'=>$Linea], 200);

    }

    public function deleteLineas($CodLin){
      $accion = 'M03';
      $CodLin;
           

      $Linea = DB::select('call Man_lo_sublineas(?,?,?,?,?,?)',
      array(
          $accion,
          null,
          null,
          $CodLin,
          null,
          null      
      ));
      return response()->json(['Linea eliminada'=>$Linea], 200);      
    }  
    
    public function cambiaeEstadoLinea($idLinea, $Activo){
      $Linea = DB::select('call Man_lo_sublineas(?,?,?,?,?,?)',
      array(
        'M04',
        null,
        null,
        $idLinea,
        null,
        $Activo 

      )); 

      return response()->json($Linea, 200);
    }
    //obtener Tipodocumentos
    public function getLineas($CodEmp){
        $accion = 'S01';
        $Linea = DB::select('call Man_lo_sublineas(?,?,?,?,?,?)',
        array(
            $accion,
            $CodEmp,
            null,
            null,
            null,
            null            
        ));
        return response()->json($Linea, 200);
    }

    public function getComboFamilias($CodEmp){
        $accion = 'S03';
        $Linea = DB::select('call Man_lo_sublineas(?,?,?,?,?,?)',
        array(
            $accion,
            $CodEmp,
            null,
            null,
            null,
            null
        ));
        return response()->json($Linea, 200);
    }   
    public function getAlmacenes($CodEmp){
        $accion = 'S04';
        $Linea = DB::select('call Man_lo_sublineas(?,?,?,?,?,?)',
        array(
            $accion,
            $CodEmp,
            null,
            null,
            null,
            null
        ));
        return response()->json($Linea, 200);
    } 
}