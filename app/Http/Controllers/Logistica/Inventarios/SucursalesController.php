<?php

namespace App\Http\Controllers\Logistica\Inventarios;

use Illuminate\Http\Request;
use DB;
use App\Http\Controllers\Controller;

class SucursalesController extends Controller
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
    
    
    public function createSucursales(Request $request, $IdUsuario){
      $accion = 'M01';
      $CodEmp = $request->get('CodEmp');  
      $CodSuc = null;      
      $Nombre = $request->get('Nombre');
      $Cuo = $request->get('CUO'); 
      $DirSuc = $request->get('Direccion');  
      $Telefo = $request->get('Telefono');
      $Email = $request->get('Email');
      $Ubigeo = $request->get('Ubigeo');
      $Principal = $request->get('Principal');   
      $Activo = $request->get('Activo');
      $Respon = $request->get('Responsable');   
      $CodZon = $request->get('IdZona'); 
      

      $Sucursales =  DB::select('call Man_zg_sucursales(?,?,?,?,?,?,?,?,?,?,?,?,?)'
      ,array(
            $accion,
            $IdUsuario, 
            $CodEmp,
            $CodSuc,
            $Nombre,
            $Cuo,
            $DirSuc,
            $Telefo,
            $Email,
            $Ubigeo,
            $Principal,
            $Activo,
            $Respon
            // $CodZon,            
                      
      ));
      return response()->json(['Sucursal creada'=>$Sucursales], 201);
    }

    //Actualizar Sucursales
    public function updateSucursales(Request $request, $IdUsuario){
      $accion = 'M02';
      $CodEmp = $request->get('CodEmp'); 
      $CodSuc = $request->get('IdSucursal');
      $Nombre = $request->get('Nombre');
      $Cuo = $request->get('CUO'); 
      $DirSuc = $request->get('Direccion');  
      $Telefo = $request->get('Telefono');
      $Email = $request->get('Email');
      $Ubigeo = $request->get('Ubigeo');
      $Principal = $request->get('Principal');   
      $Activo = $request->get('Activo');
      $Respon = $request->get('Responsable');   
      $CodZon = $request->get('IdZona');   
      

      $Sucursales =  DB::select('call Man_zg_sucursales(?,?,?,?,?,?,?,?,?,?,?,?,?)'
      ,array(
        $accion,
        $IdUsuario, 
        $CodEmp,
        $CodSuc,
        $Nombre,
        $Cuo,
        $DirSuc,
        $Telefo,
        $Email,
        $Ubigeo,
        $Principal,
        $Activo,
        $Respon
        // $CodZon    
      ));

      return response()->json(['Sucursal Actualizada'=>$Sucursales], 200);

    }

    public function deleteSucursales($CodSuc,$IdEmpresa){
     
      $Sucursales = DB::select('call Man_zg_sucursales(?,?,?,?,?,?,?,?,?,?,?,?,?)',
      array(
          'M03',
          null,
          $IdEmpresa,
          $CodSuc,
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
      return response()->json(['Sucursal eliminada'=>$Sucursales], 200);      
    }
 
    public function cambiarEstado(Request $request){
        
        $idEmpresa = $request->get('idEmpresa');
        $idSUcursal =$request->get('idSucursal');
        $Activo = $request->get('Activo');
        $sucursal = DB::select('call Man_zg_sucursales(?,?,?,?,?,?,?,?,?,?,?,?,?)',
        array(
            'M04',
            null,
            $idEmpresa,
            $idSUcursal,
            null,
            null,
            null,
            null,
            null, 
            null,
            null,
            $Activo,
            null
        ));

        return response()->json($request, 200);
    }
    
    //obtener Sucursales xempresa y (usuarios)???????
    public function getSucursales($CodEmp, $IdUsuario){
        $accion = 'S01';
        $Sucursales = DB::select('call Man_zg_sucursales(?,?,?,?,?,?,?,?,?,?,?,?,?)',
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
            null
        ));

        return response()->json($Sucursales, 200);
    }
    
    public function getComboEmpresas(){
        $accion = 'S03';
        $CodSuc= null;
        $NomSuc = null;
        $Serie = null;
        $DesCorSuc = null;
        $DirSuc = null;
        $Telefo = null;
        $Respon = null;
        $CodZon = null; 
        $CodEmp = null; 
        
        $Sucursales = DB::select('call Man_zg_sucursales(?,?,?,?,?,?,?,?,?,?,?,?,?)',
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
            null
        ));
        return response()->json($Sucursales, 200);
    }  
    public function getComboZonas($CodEmp){
        $accion = 'S04';
        $CodSuc= null;
        $NomSuc = null;
        $Serie = null;
        $DesCorSuc = null;
        $DirSuc = null;
        $Telefo = null;
        $Respon = null;
        $CodZon = null; 
        
        $Sucursales = DB::select('call Man_zg_sucursales(?,?,?,?,?,?,?,?,?,?,?,?,?)',
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
            null,
            null,
            null,
            null
        ));
        return response()->json($Sucursales, 200);
    }   
    public function getdepartamentos(){
        $departamentos = DB::select('call Man_zg_ubigeo(?, ?)',
        array(
            'S01',
            null
        ));
        return response()->json($departamentos,200);
    }
    public function getProvincias($idDepa){
        $provincias = DB::select('call Man_zg_ubigeo(?, ?)',
        array(
            'S02', 
            $idDepa
        ));
        return response()->json($provincias, 200);
    }

    public function getDistritos($idProv){
        $distritos = DB::select('call Man_zg_ubigeo(?, ?)',
        array(
            'S03', 
            $idProv
        ));

        return response()->json($distritos,200);
    }
       
}
