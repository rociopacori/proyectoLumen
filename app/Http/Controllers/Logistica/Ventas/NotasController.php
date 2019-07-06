<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class NotasController extends Controller
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

    public function GetTiposNotasCredito(){
        $result = DB::select('call Man_zg_notas(?, ?, ?, ?)',
        array(
            'M01',
            null,
            null,
            null
        ));

        return Response()->json($result);
    }
}