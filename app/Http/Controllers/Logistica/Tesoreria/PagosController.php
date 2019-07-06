<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class PagosController extends Controller
{

    public function CreatePagos(Request $request, $Id){
            $delete = DB::select('call Man_zg_pagosventas(?, ?, ?, ?, ?, ?)',
            array(
                'M02',
                $Id,
                null,
                null,
                null,
                null
            ));

        foreach($request->get('PagosList') as $item)
        {
            $data = [];
            $data['IdFormaPago'] = $item['IdFormaPago'];
            $data['Importe'] = $item['Importe']; 
            $data['Tarjeta'] = $item['Tarjeta'];

            $detalle = DB::select('call Man_zg_pagosventas(?, ?, ?, ?, ?, ?)',
            array(
                'M01',
                $Id,
                $data['IdFormaPago'],
                $data['Importe'],
                null,
                $data['Tarjeta']
            ));
        }
       
          return response()->json($detalle);

    }

    public function UpdatePagos(Request $request, $IdPagosVenta){
        foreach($request->get('PagosList') as $item)
        {
            $data = [];
            $data['IdFormaPago'] = $item['IdFormaPago'];
            $data['Importe'] = $item['Importe']; 
            $data['Tarjeta'] = $item['Tarjeta'];

            $detalle = DB::select('call Man_zg_pagosventas(?, ?, ?, ?, ?, ?, ?)',
            array(
                'M02',
                $IdPagosVenta,
                null,
                $data['IdFormaPago'],
                $data['Importe'],
                null,
                $data['Tarjeta']
            ));
        }
        return response()->json($detalle);
    }
    
    public function GetPagos($IdVentaCab){

        $result = DB::select('call Man_zg_pagosventas(?, ?, ?, ?, ?, ?)',
        array(
            'S01',
            $IdVentaCab,
            null,
            null,
            null,
            null
        ));
        return Response()->json($result);
    }


}
