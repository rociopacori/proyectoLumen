<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class OrdenCompraController extends Controller
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
    
          //this is my controller to insert but i dont know how to get 
          public function createOrden(Request $request){
 
            //this are the first insert columns until total
            $result = [];
               $input = [];
               $input['CodAlm'] = $request->get('CodAlm');
               $input['CodPro'] = $request->get('CodPro');
               $input['TipAdq'] = $request->get('TipAdq');
               $input['Total'] = $request->get('Total');
               $input['CodSuc'] = $request->get('CodSuc');

               $CodAlmx = $input['CodAlm']; 
               $CodProx = $input['CodPro']; 
               $TipAdqx = $input['TipAdq']; 
               $Totalx = $input['Total']; 
               $CodSucx = $input['CodSuc']; 
                    
                $insertar =  DB::select('call Man_zg_cabeceradetalle(?,?,?,?,?,?,?,?,?,?)'
                ,array(
                    'S01',
                    $CodAlmx,
                    $CodProx,
                    $TipAdqx,
                    $Totalx,
                    $CodSucx,
                    null,
                    null,
                    null,
                    null
                ));

                $insertGetId = DB::select('call Man_zg_cabeceradetalle(?,?,?,?,?,?,?,?,?,?)',
                array(
                    'S02',
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
                //$array = array_values($insertGetId);
                $term_id = $insertGetId[0]->IdOrdenCompra; 

                foreach($request->get('OrderItems') as $item)
                {
                    $data = [];
                    $data['IdOrdenCompra'] = $term_id;
                    $data['CodIte'] = $item['CodIte'];
                    $data['Price'] = $item['Price'];
                    $data['Quantity'] = $item['Quantity'];
                
 
                 $detalle = DB::select('call Man_zg_cabeceradetalle(?,?,?,?,?,?,?,?,?,?)',
                 array(
                     'S03',
                     null,
                     null,
                     null,
                     null,
                     null,
                     $data['IdOrdenCompra'],
                     $data['CodIte'],
                     $data['Price'],
                     $data['Quantity']
                 ));
                     
 
                    //DB::table('zg_ordencompradet')->insert($data);
                }
                //DB::commit();
                $result = ['message'=>'Successfully added data','status'=> 'success'];
                return response()->json($term_id);
          } 
          
    
    public function insert(Request $request){
        $accion = 'M01';
        $CodEmp = null; 
        $OrdenCompraId = null;
        $CodAlm = $request->get('CodAlm');
        $CodPro = $request->get('CodPro');
        $TipAdq = $request->get('TipAdq');
        $Total = $request->get('Total');
        $ItemCompraID = null;
        $ItemID = null;
        $Price = null;
        $Quantity = null;
        
      $Items =  DB::select('call Man_zg_ordencompra(?,?,?,?,?,?,?,?,?,?,?)'
      ,array(
            $accion,
            null,
            null,
            $CodAlm,
            $CodPro,
            $TipAdq,
            $Total,
            null,
            null,
            null,
            null                      
      ));
      return response()->json(['Item creada'=>$Items], 201);
    }

    public function getComboAlmacenes($CodEmp){
      $accion = 'S01';
        
      $CodEmp;     

      $OrdenCompra =  DB::select('call Man_zg_ordencompra(?,?,?,?,?,?,?,?,?,?,?)'
      ,array(
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
            null           
                      
      ));
      return response()->json($OrdenCompra, 200);
    }

    public function getComboProveedores($CodEmp){
        $accion = 'S02';
          
        $CodEmp;     
  
        $OrdenCompra =  DB::select('call Man_zg_ordencompra(?,?,?,?,?,?,?,?,?,?,?)'
        ,array(
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
              null         
                        
        ));
        return response()->json($OrdenCompra, 200);
      }  

      public function getItemList($CodEmp){
            $accion = 'S03';
              
            $CodEmp;     
      
            $OrdenCompra =  DB::select('call Man_zg_ordencompra(?,?,?,?,?,?,?,?,?,?,?)'
            ,array(
                  $accion,
                  $CodEmp ,
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
            return response()->json($OrdenCompra, 200);
          } 
       
}
