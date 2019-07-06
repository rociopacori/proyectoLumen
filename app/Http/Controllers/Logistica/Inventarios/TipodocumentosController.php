<?php

namespace App\Http\Controllers\Logistica\Inventarios;

use Illuminate\Http\Request;
use DB;
use App\Http\Controllers\Controller;

class TipodocumentosController extends Controller
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

    public function createTipodocumentos(Request $request){
      $accion = 'M01';
      $CodEmp = $request->get('IdEmpresa'); 
      $CodTipDoc = null;
      $DesTipDoc = $request->get('Descripcion');
      $DesCorDoc = $request->get('DescripcionCorta');
      $CodSun = $request->get('CodigoSunat'); 
      $Configuracion = $request->get('Configuracion');
      $Activo = null;
    //   $Ventan = $request->get('Ventan');  
    //   $Config = $request->get('Config');    

      $Tipodocumentos =  DB::select('call Man_lo_tipodocumentos(?,?,?,?,?,?,?)'
      ,array(
            $accion,
            $CodEmp,
            $CodTipDoc,
            $DesTipDoc,
            $CodSun,
            $Configuracion,
            $Activo             
      ));
      return response()->json(['Tipodocumentos creada'=>$Tipodocumentos], 201);
    }

    //Actualizar Tipodocumentos
    public function updateTipodocumentos(Request $request){
      $accion = 'M02';
      $CodEmp = $request->get('IdEmpresa');
      $CodTipDoc = $request->get('IdTipoDocumento');
      $DesTipDoc = $request->get('Descripcion');
      $OrdSun = $request->get('CodigoSunat');
      $Configuracion = $request->get('Configuracion');
      $Activo = $request->get('Activo');     
          

      $Tipodocumentos =  DB::select('call Man_lo_tipodocumentos(?,?,?,?,?,?,?)'
      ,array(
            $accion,
            $CodEmp, 
            $CodTipDoc,
            $DesTipDoc,
            $OrdSun,
            $Configuracion,
            $Activo           
      ));

      return response()->json(['Tipodocumentos Actualizada'=>$Tipodocumentos], 200);

    }

    public function deleteTipodocumentos($CodTipDoc){
      $accion = 'M03';
      $Tipodocumentos = DB::select('call Man_lo_tipodocumentos(?, ?, ?, ?, ?, ?, ?)',
      array(
          $accion,
          null,
          $CodTipDoc,
          null,
          null,
          null,
          null
          
      ));

      return response()->json(['Tipodocumentos eliminada'=>$Tipodocumentos], 200);
      
    }

    function updateDocumento($IdTipDoc, $Activo){
        $accion='M04';

        $Tipodocumento  = DB::select('call Man_lo_tipodocumentos(?, ?, ?, ?, ?, ?, ?)',
        array(
            $accion, 
            null,
            $IdTipDoc,
            null,
            null,
            null, 
            $Activo
        ));
        return response()->json(['Tipodocumento Actualizada'=>$Tipodocumento], 200);

    }

    
    //obtener Tipodocumentos
    public function getTipodocumentos($CodEmp){
        $accion = 'S01';
        $Tipodocumentos = DB::select('call Man_lo_tipodocumentos(?, ?, ?, ?, ?, ?, ?)',
        array(
            $accion,
            $CodEmp,
            null,
            null,
            null,
            null,
            null
            
        ));

        return response()->json($Tipodocumentos, 200);
    }


    
}
