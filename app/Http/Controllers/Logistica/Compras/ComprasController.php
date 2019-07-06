<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class ComprasController extends Controller
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
    public function ListaCompras($CodSuc){
        $accion = 'M01';
        $compras = DB::select('call Man_zg_Compras(?,?,?)'
        ,
        array(
            $accion,
            $CodSuc,
            null
        ));
        return response()->json($compras, 200);

    } 
    public function DetalleCompras($OrdenCompraId){
        $accion = 'M02';
        $compras = DB::select('call Man_zg_Compras(?,?,?)'
        ,
        array(
            $accion,
            null,
            $OrdenCompraId
        ));
        return response()->json($compras, 200);

    }
}
