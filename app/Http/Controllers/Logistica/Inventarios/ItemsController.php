<?php

namespace App\Http\Controllers\Logistica\Inventarios;

use Illuminate\Http\Request;
use DB;
use App\Http\Controllers\Controller;

class ItemsController extends Controller
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
    
    
    public function createItems(Request $request){
      $accion = 'M01';
      $CodIte = null; 
      $CodEmp = $request->get('IdEmpresa');      
      $CodAlm = $request->get('IdAlmacen');
      $CodFam = $request->get('IdFamilia');
      $CodLin = $request->get('IdLinea');   
      $CodUniMed = $request->get('IdUniMed'); 
      $CodCom = $request->get('CodCom');  
      $DesIte = $request->get('DesIte');  
      $AfePer = $request->get('AfePer');   
      $AfeDet = $request->get('AfeDet');   
      $Presen = $request->get('Presen');  
      $Afecto = $request->get('Afecto');  
      $Exoner = $request->get('Exoner'); 
      $Activo = null;  

      $Items =  DB::select('call Man_zg_items(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)'
      ,array(
            $accion,
            $CodIte,
            $CodEmp,
            $CodAlm,
            $CodFam,
            $CodLin,
            $CodUniMed,
            $CodCom,
            $DesIte,
            $AfePer,
            $AfeDet,
            $Presen,
            $Afecto,
            $Exoner,
            null
            
                      
      ));
      return response()->json(['Item creada'=>$Items], 201);
    }

    
    
    //obtener Sucursales
    public function getComboFamilias($IdEmpresa){
        $accion = 'S01';
        $Items = DB::select('call Man_zg_items(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)'
        ,array(
            $accion,
            null,
            $IdEmpresa,
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

        return response()->json($Items, 200);
    }
    
    public function getComboLineas($IdEmpresa){
        $accion = 'S02';
        
        $Items = DB::select('call Man_zg_items(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)',
        array(
            $accion,
            null,
            $IdEmpresa,
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
        return response()->json($Items, 200);
    }  
    public function getComboMedidas($IdEmpresa){
        $accion = 'S03';
        
        $Items = DB::select('call Man_zg_items(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)',
        array(
            $accion,
            null,
            $IdEmpresa,
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
        return response()->json($Items, 200);
    }   
    public function getComboAlmacenes($IdEmpresa){
        $accion = 'S04';
        
        $Items = DB::select('call Man_zg_items(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)',
        array(
            $accion,
            null,
            $IdEmpresa,
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
        return response()->json($Items, 200);
    } 
    public function getItems($IdEmpresa){
        $accion = 'S05';
        
        $Items = DB::select('call Man_zg_items(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)',
        array(
            $accion,
            null,
            $IdEmpresa,
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
        return response()->json($Items, 200);
    } 
    
    public function updateItems(Request $request){
        $accion = 'M02';
        $CodIte = $request->get('IdItem'); 
        $CodEmp = $request->get('IdEmpresa');       
        $CodAlm = $request->get('IdAlmacen');
        $CodFam = $request->get('IdFamilia');
        $CodLin = $request->get('IdLinea');   
        $CodUniMed = $request->get('IdUniMed'); 
        $CodCom = $request->get('CodCom');  
        $DesIte = $request->get('DesIte');  
        $AfePer = $request->get('AfePer');   
        $AfeDet = $request->get('AfeDet');   
        $Presen = $request->get('Presen');  
        $Afecto = $request->get('Afecto');  
        $Exoner = $request->get('Exoner'); 
        $Activo = $request->get('Activo'); 
  
        $Items =  DB::select('call Man_zg_items(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)'
        ,array(
              $accion,
              $CodIte,
              $CodEmp,
              $CodAlm,
              $CodFam,
              $CodLin,
              $CodUniMed,
              $CodCom,
              $DesIte,
              $AfePer,
              $AfeDet,
              $Presen,
              $Afecto,
              $Exoner,
              $Activo                        
        ));
  
        return response()->json(['Item Actualizada'=>$Items], 200);
  
      }
      public function deleteItems($CodIte,$Activo){
          $accion = 'M03';
          
          $Items = DB::select('call Man_zg_items(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)',
          array(
              $accion,
              $CodIte,
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
              null,
              $Activo
          ));
          return response()->json($Items, 200);
      } 
       
}
