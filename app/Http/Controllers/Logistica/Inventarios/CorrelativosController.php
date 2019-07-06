<?php

namespace App\Http\Controllers\Logistica\Inventarios;

use Illuminate\Http\Request;
use DB;
use App\Http\Controllers\Controller;

class CorrelativosController extends Controller
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
    
    
    public function createCorrelativos(Request $request){
      $accion = 'M01';
      $CodCor = null;      
      $CodTipDoc = $request->get('IdTipoDocumento');
      $Serie = $request->get('Serie');   
      $DocNro = $request->get('DocNro'); 
      $TkNroAutSun = $request->get('TkNroAutSun');  
      $CodSuc = $request->get('IdSucursal'); 
      $CodEmp = $request->get('CodEmp');  
      
      $Correlativos =  DB::select('call Man_zg_correlativos(?,?,?,?,?,?,?,?)'
      ,array(
            $accion,
            $CodCor,
            $CodEmp,
            $CodTipDoc,
            $Serie,
            $DocNro,
            $TkNroAutSun,
            $CodSuc
                      
      ));
      return response()->json(['Correlativo creado'=>$Correlativos], 201);
    }

    //Actualizar Sucursales
    public function updateCorrelativos(Request $request){
      $accion = 'M02';
      $CodCor = $request->get('IdCorrelativo');
      $CodTipDoc = $request->get('IdTipoDocumento');
      $Serie = $request->get('Serie');   
      $DocNro = $request->get('DocNro'); 
      $TkNroAutSun = $request->get('TkNroAutSun');  
      $CodSuc = $request->get('IdSucursal'); 
      $CodEmp = $request->get('CodEmp');     
      

      $Correlativos =  DB::select('call Man_zg_correlativos(?,?,?,?,?,?,?,?)'
      ,array(
        $accion,
        $CodCor,
        $CodEmp, 
        $CodTipDoc,
        $Serie,
        $DocNro,
        $TkNroAutSun,
        $CodSuc
             
      ));

      return response()->json(['Correlativo Actualizado'=>$Correlativos], 200);

    }

    public function deleteCorrelativos($CodCor){
      $accion = 'M03';
      $CodCor;
      $CodTipDoc = null;
      $Serie = null;
      $DocNro = null;
      $TkNroAutSun = null;
      $CodSuc = null;
      $CodEmp = null;
          

      $Correlativos = DB::select('call Man_zg_correlativos(?,?,?,?,?,?,?,?)',
      array(
          $accion,
          $CodCor,
          null,
          null,
          null,
          null,
          null,
          null             
      ));
      return response()->json(['Correlativo eliminado'=>$Correlativos], 200);      
    }

    
    //obtener Sucursales
    public function getCorrelativos($CodEmp){
        $accion = 'S01';
        $Correlativos = DB::select('call Man_zg_correlativos(?,?,?,?,?,?,?,?)',
        array(
            $accion,
            null,
            $CodEmp,
            null,
            null,
            null,
            null,
            null
        ));

        return response()->json($Correlativos, 200);
    }

    public function getComboTipoDocumentos($CodEmp){
        $accion = 'S03';
        $CodCor= null;
        $CodTipDoc = null;
        $Serie = null;
        $DocNro = null;
        $TkNroAutSun = null;
        $CodSuc = null;
        $CodEmp; 
        
        $Correlativos = DB::select('call Man_zg_correlativos(?,?,?,?,?,?,?,?)',
        array(
            $accion,
            null,            
            $CodEmp,
            null,
            null,
            null,
            null,
            null
        ));
        return response()->json($Correlativos, 200);
    }   
    public function getComboSucursales($CodEmp){
        $accion = 'S04';
        $CodCor= null;
        $CodTipDoc = null;
        $Serie = null;
        $DocNro = null;
        $TkNroAutSun = null;
        $CodSuc = null;
        $CodEmp; 
        
        $Correlativos = DB::select('call Man_zg_correlativos(?,?,?,?,?,?,?,?)',
        array(
            $accion,
            null,
            $CodEmp,
            null,
            null,
            null,
            null,
            null            
        ));
        return response()->json($Correlativos, 200);
    } 
    
    public function getTipoDocumento($Id){
        $accion = 'S05';
        $CodCor= null;
        $CodTipDoc = null;
        $Serie = null;
        $DocNro = null;
        $TkNroAutSun = null;
        $CodSuc = null;
        $CodEmp; 
        
        $Correlativos = DB::select('call Man_zg_correlativos(?,?,?,?,?,?,?,?)',
        array(
            $accion,
            null,            
            null,
            $Id,
            null,
            null,
            null,
            null
        ));
        return response()->json($Correlativos, 200);
    }
    public function getRBCorrelativos($CodEmp){
        $accion = 'S06';
        $Correlativos = DB::select('call Man_zg_correlativos(?,?,?,?,?,?,?,?)',
        array(
            $accion,
            null,
            $CodEmp,
            null,
            null,
            null,
            null,
            null
        ));

        return response()->json($Correlativos, 200);
    }
    public function getSeries($CodEmp, $IdTipDoc){
        $accion = 'S07';
        $Series = DB::select('call Man_zg_correlativos(?,?,?,?,?,?,?,?)',
        array(
            $accion,
            null,
            $CodEmp,
            $IdTipDoc,
            null,
            null,
            null,
            null
        ));
        return response()->json($Series, 200);
    }

    public function getNumSerie($idCorrelativo, $Serie){
        $accion = 'S08';
        $NumSerie = DB::select('call Man_zg_correlativos(?,?,?,?,?,?,?,?)',
        array(
            $accion,
            $idCorrelativo,
            null,
            null,
            $Serie,
            null,
            null,
            null
        ));
        return response()->json($NumSerie, 200);
    }
       
}
