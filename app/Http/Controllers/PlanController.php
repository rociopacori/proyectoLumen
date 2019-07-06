<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;


class PlanController extends Controller
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

    public function createPlanUser(Request $request){
        $accion = 'M01';
        $idUsuario = $request->json()->get('idUsuario');
        $idPlan = $request->json()->get('idPlan');
        $fecha = $request->json()->get('fecha');
        $hora = $request->json()->get('hora');

            $planUser = DB::select('call Man_zg_usuarioplan(?,?,?,?,?)'
            ,array(
                $accion,
                $idUsuario,
                $idPlan,
                $fecha,
                $hora
            ));

            return response()->json(['Plan de usuario creado'], 201);
    }

    public function updatePlanUser(){
        $accion = 'M02';
        $idUsuario = null;
        $idPlan = null;

        $planUser = DB::select('call Man_zg_usuarioplan(?,?,?)'
        ,array(
            $accion,
            $idUsuario,
            $idPlan,
        ));

        return response()->json(['Plan de usuario actualizado' => $planUser], 200);
    }

    public function deletePlanUser(){
        $accion = 'M03';
        $idUsuario = null;

        $planUser = DB::select('call Man_zg_usuarioplan(?,?)'
        ,array(
            $accion,
            $idUsuario
        ));

        return response()->json(['Plan de usuario'.$idUsuario.'eliminado'], 200);
    }

    public function getPlanUser(){
        $accion = 'S01';
        $idUsuario = null;

        $planUser = DB::select('call Man_zg_usuarioplan(?,?)'
        ,array(
            $accion,
            $idUsuario
        ));

        return response()->json(['Plan del usuario'.$idUsuario=>$planUser], 200);
    }   

}
