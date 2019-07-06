<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use DB;
class PropiedadesController extends Controller
{
    public function __construct()
    {
    }
    public function CreateUpdatePropiedades(Request $request, $Accion){
    $IdEmpresa=$request->get('IdEmpresa');
    $IdPropiedad=$request->get('IdPropiedad');
    $Descripcion=$request->get('Descripcion');
    $Activo=$request->get('Activo');
    $Propiedades = DB::select('call Lo_Man_lo_propiedades(?,?,?,?,?)',
    array(
     $Accion,
     $IdEmpresa,
     $IdPropiedad,
     $Descripcion,
     $Activo
    ));
    return response()->json($Propiedades, 201);
    }
    public function GetPropiedades($idEmpresa) {
    $Accion = 'S01';
     $Propiedades = DB::select('call Lo_Man_lo_propiedades(?,?,?,?,?)',
    array(
     $Accion,
     $idEmpresa,
     null,
     null,
     null
    ));
    return response()->json($Propiedades, 200);
    }
    public function DeletePropiedades($IdEmpresa,$IdPropiedad){
    $Accion = 'M03';
     $Propiedades = DB::select('call Lo_Man_lo_propiedades(?,?,?,?,?)',
    array(
     $Accion,
     $IdEmpresa,$IdPropiedad,
     null,
     null
    ));
    return response()->json($Propiedades, 200);
    }
    public function UpdateEstadoPropiedades($IdEmpresa,$IdPropiedad,$Activo){
    $Accion = 'M04';
     $Propiedades = DB::select('call Lo_Man_lo_propiedades(?,?,?,?,?)',
    array(
     $Accion,
     $IdEmpresa,$IdPropiedad,
     null,
     $Activo
    ));
    return response()->json($Propiedades, 200);
    }
}