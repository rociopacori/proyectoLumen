<?php

namespace App\Http\Controllers\Logistica\Inventarios;
use Illuminate\Http\Request;
use DB;
use App\Http\Controllers\Controller;

class ZonasController extends Controller
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
    
    
    public function createZonas(Request $request){
      $accion = 'M01';
      $CodZon = null;      
      $DesZon = $request->get('DesZon');
      $Detall = $request->get('Detall');   
      $CodEmp = $request->get('CodEmp'); 
      

      $Zonas =  DB::select('call Man_zg_zonas(?,?,?,?,?)'
      ,array(
            $accion,
            $CodEmp,
            $CodZon,
            $DesZon,
            $Detall
                      
      ));
      return response()->json(['Zona creada'=>$Zonas], 201);
    }

    //Actualizar Tipodocumentos
    public function updateZonas(Request $request){
      $accion = 'M02';
      $CodZon = $request->get('IdZona');
      $DesZon = $request->get('DesZon');
      $Detall = $request->get('Detall');   
      $CodEmp = $request->get('CodEmp');  
      

      $Zonas =  DB::select('call Man_zg_zonas(?,?,?,?,?)'
      ,array(
        $accion,
        $CodEmp,
        $CodZon,
        $DesZon,
        $Detall           
      ));

      return response()->json(['Zona Actualizada'=>$Zonas], 200);

    }

    public function deleteZonas($CodZon){
      $accion = 'M03';
      $CodZon;
      $DesZon = null;
      $Detall = null;
      $CodEmp = null;
          

      $Zonas = DB::select('call Man_zg_zonas(?,?,?,?,?)',
      array(
          $accion,
          null,
          $CodZon,
          null,
          null                
      ));

      return response()->json(['Zona eliminada'=>$Zonas], 200);
      
    }

    
    //obtener Tipodocumentos
    public function getZonas($CodEmp){
        $accion = 'S01';
        $Zonas = DB::select('call Man_zg_zonas(?,?,?,?,?)',
        array(
            $accion,
            $CodEmp,
            null,
            null,
            null
        ));

        return response()->json($Zonas, 200);
    }
    public function getComboEmpresas($CodEmp){
        $accion = 'S03';
        $Zonas = DB::select('call Man_zg_zonas(?,?,?,?,?)',
        array(
            $accion,
            $CodEmp,
            null,
            null,
            null
        ));

        return response()->json($Zonas, 200);
    }
       
}
