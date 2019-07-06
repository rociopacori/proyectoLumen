<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use DB;
class ZmodulosController extends Controller
{
    public function __construct()
    {
    }
    public function CreateUpdateZmodulos(Request $request, $Accion){
    $IdZmodulo=$request->get('IdZmodulo');
    $Codigo=$request->get('Codigo');
    $Descripcion=$request->get('Descripcion');
    $Zmodulos = DB::select('call Lo_Man_zg_zmodulos(?,?,?,?)',
    array(
     $Accion,
     $IdZmodulo,
     $Codigo,
     $Descripcion
    ));
    return response()->json($Zmodulos, 201);
    }
    public function GetZmodulos($idEmpresa) {
    $Accion = 'S01';
     $Zmodulos = DB::select('call Lo_Man_zg_zmodulos(?,?,?,?)',
    array(
     $Accion,
     $idEmpresa,
     null,
     null
    ));
    return response()->json($Zmodulos, 200);
    }
    public function DeleteZmodulos($IdZmodulo){
    $Accion = 'M03';
     $Zmodulos = DB::select('call Lo_Man_zg_zmodulos(?,?,?,?)',
    array(
     $Accion,
     $IdZmodulo,
     null,
     null
    ));
    return response()->json($Zmodulos, 200);
    }
    public function UpdateEstadoZmodulos($IdZmodulo){
    $Accion = 'M04';
     $Zmodulos = DB::select('call Lo_Man_zg_zmodulos(?,?,?,?)',
    array(
     $Accion,
     $IdZmodulo,
     null,
     null
    ));
    return response()->json($Zmodulos, 200);
    }
}