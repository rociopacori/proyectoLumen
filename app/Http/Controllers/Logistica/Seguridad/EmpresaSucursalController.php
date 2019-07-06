<?php

namespace App\Http\Controllers\Logistica\Seguridad;

use Illuminate\Http\Request;
use DB;
use App\Http\Controllers\Controller;

class EmpresaSucursalController extends Controller
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
      
    public function getComboEmpresas($Accion,$IdUsuario){
        // $accion = 'S01';        
        $EmpresaSucursal = DB::select('call Man_zg_empresasucursal(?, ?, ?)',
        array(
            $Accion, // S01 y S03
            $IdUsuario,
            null
        ));
        return response()->json($EmpresaSucursal, 200);
    }  

    public function getComboSucursales($Accion,$CodEmp, $IdUsuario){
        
        $EmpresaSucursal = DB::select('call Man_zg_empresasucursal(?, ?, ?)',
        array(
            $Accion, // S02 y S04
            $IdUsuario,
            $CodEmp         
        ));

        return response()->json($EmpresaSucursal, 200);
    }


    
    
}
