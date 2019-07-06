<?php

namespace App\Http\Controllers\Logistica\Inventarios;

use Illuminate\Http\Request;
use DB;
use App\Http\Controllers\Controller;

class MedidasController extends Controller
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


    public function createMedidas(Request $request){
        $accion = 'M01';
        $CodUniMed = null;
        $DesUniMed = $request->get('DesUniMed');
        $IdSun = $request->get('IdSun');
        $OrdSun = $request->get('OrdSun');
        $CanUniMed = $request->get('CanUniMed');
        $Medida1 = $request->get('Medida1'); 
        $Medida2 = $request->get('Medida2');
        $Multip = $request->get('Multip');
        $Activo = $request->get('Activo');
        $CodEmp = $request->get('CodEmp');  
  
        $Medidas =  DB::select('call Man_zg_medidas(?,?,?,?,?,?,?,?,?,?,?)'
        ,array(
              $accion,
              $CodUniMed,
              $CodEmp,
              $DesUniMed,
              $IdSun,
              $OrdSun,
              $CanUniMed,
              $Medida1,
              $Medida2,
              $Multip,
              $Activo
                        
        ));
        return response()->json(['Medida creada'=>$Medidas], 201);
      }
      
      public function updateMedidas(Request $request){
        $accion = 'M02';
        $CodUniMed = $request->get('IdUniMed');
        $DesUniMed = $request->get('DesUniMed');
        $IdSun = $request->get('IdSun');
        $OrdSun = $request->get('OrdSun');
        $CanUniMed = $request->get('CanUniMed');
        $Medida1 = $request->get('Medida1'); 
        $Medida2 = $request->get('Medida2');
        $Multip = $request->get('Multip');
        $Activo = $request->get('Activo');
        $CodEmp = $request->get('CodEmp');  
        
  
        $Medidas =  DB::select('call Man_zg_medidas(?,?,?,?,?,?,?,?,?,?,?)'
        ,array(
            $accion,
            $CodUniMed,
            $CodEmp,  
            $DesUniMed,
            $IdSun,
            $OrdSun,
            $CanUniMed,
            $Medida1,
            $Medida2,
            $Multip,
            $Activo
                      
        ));
  
        return response()->json(['Familia Actualizada'=>$CodUniMed], 200);
  
      }

      public function DeleteMedida($IdUniMed){
          $accion ='M03';
          $Medida = DB::select('call Man_zg_medidas(?,?,?,?,?,?,?,?,?,?,?)',
          array(
              $accion,
              $IdUniMed,
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
          return response()->json(['Familia eliminada'=>$Medida],202);
  
      }
      
    public function getMedidas($CodEmp){
        $accion = 'S01';
        $Medidas = DB::select('call Man_zg_medidas(?,?,?,?,?,?,?,?,?,?,?)',
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
            null           
        ));

        return response()->json($Medidas, 200);
    }


    
}
