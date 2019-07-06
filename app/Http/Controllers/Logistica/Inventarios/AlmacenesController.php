<?php

namespace App\Http\Controllers\Logistica\Inventarios;

use Illuminate\Http\Request;
use DB;
use App\Http\Controllers\Controller;

class AlmacenesController extends Controller
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

    // Crear y Actualizar Almacen
    public function createAlmacenes(Request $request, $Accion){
      $accion = 'M01';
      $IdAlmacen = $request->get('IdAlmacen');
      $DesAlm = $request->get('Descripcion');
      $DesCorAlm = $request->get('DescripcionCorta');
      $Respon = $request->get('Responsable');   
      $CodEmp = $request->get('IdEmpresa'); 
      $Activo = $request->get('Activo');   

      $Almacenes =  DB::select('call Man_lo_almacenes(?,?,?,?,?,?,?)'
      ,array(
            $Accion,
            $CodEmp,
            $IdAlmacen,
            $DesAlm,
            $DesCorAlm,
            $Respon,
            $Activo                        
      ));
      return response()->json(['Almacenes creada'=>$Almacenes], 201);
    }

    //Actualizar Almacenes
    public function updateAlmacenes(Request $request){
      $accion = 'M02'; 
      $IdEmpresa = $request->get('IdEmpresa'); 
      $IdAlmacen = $request->get('IdAlmacen');
      $DesAlm = $request->get('Descripcion');
      $DesCorAlm = $request->get('DescripcionCorta');
      $Respon = $request->get('Responsable');  
      $Activo = $request->get('Activo');

      $Almacenes =  DB::select('call Man_lo_almacenes(?,?,?,?,?,?,?)'
      ,array(
        $accion,
        $IdEmpresa,
        $IdAlmacen,
        $DesAlm,
        $DesCorAlm,
        $Respon,
        $Activo             
      ));

      return response()->json($Almacenes, 200);
    //   if( $Almacenes ){
    //     return response()->json('Datos actualizados!, codigo:'.$CodAlm, 200);
    //  }else{
    //     return response()->json('No se detectaron cambios o no se pudo actualizar el impuesto', 200);
    //  }

    }

    public function deleteAlmacenes($IdEmpresa,$IdAlmacen){
      $accion = 'M03'; 
      $Almacenes = DB::select('call Man_lo_almacenes(?,?,?,?,?,?,?)',
      array(
          $accion,
          $IdEmpresa,
          $IdAlmacen,
          null,
          null,
          null,
          null        
      ));

      return response()->json(['Almacen eliminada'=>$Almacenes], 200);
      
    }

    public function updateEstatusAlmacen($IdEmpresa, $IdAlmacen, $Activo){
      $Accion='M04';
      $Almacen = DB::select('call Man_lo_almacenes(?,?,?,?,?,?,?)',
      array(
        $Accion,
        $IdEmpresa,
        $IdAlmacen,
        null,
        null,
        null,
        $Activo
      ));

      return Response()->json($Almacen, 200);
    }
    
    //obtener Almacenes
    public function getAlmacenes($IdEmpresa){
        $accion = 'S01';
        $Almacenes = DB::select('call Man_lo_almacenes(?,?,?,?,?,?,?)',
        array(
            $accion,
            $IdEmpresa,
            null,
            null,
            null,
            null,
            null
        ));

        return response()->json($Almacenes, 200);
    }
    public function getLastIdAlmacen($IdEmpresa){
      $Accion= 'S02';
      $IdAlmacen = DB::select('call Man_lo_almacenes(?,?,?,?,?,?,?)',
      array(
        $Accion,
        $IdEmpresa,
        null,
        null,
        null,
        null,
        null
      ));
      return Response()->json($IdAlmacen, 200);
    }


    
}
