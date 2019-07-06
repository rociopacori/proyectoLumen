<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class VentasController extends Controller
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

    public function CreateVenta(Request $request){
 
            //this are the first insert columns until total
            $result = [];
               $input = [];
               $IdEmpresa  = $request->get('IdEmpresa');
               $CodAlm  = $request->get('IdAlmacen');
               $IdCliente = $request->get('IdClient');
               $Direccion = $request->get('Direccion');
               $IdTipDoc = $request->get('IdTipDoc');
               $IdUsuario = $request->get('IdUsuario');
               $idCorrelativo = $request->get('IdCorrelativo');
               $serie = $request->get('serie');
               $NumSerie = $request->get('NumSerie');
               $Moneda = $request->get('Moneda');
               $Total = $request->get('Total');
            //    $TipVent  = $request->get('TipVent');
               $CodSuc  = $request->get('IdSuc');
               $DocAfectado = $request->get('DocAfectado');
              $Descripcion = $request->get('Descripcion');
              $TipoNota = $request->get('TipoNota');
                                   
                $insertar =  DB::select('call Man_zg_ventas(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)'
                ,array(
                    'M01',
                    $IdEmpresa,
                    null,
                    $IdCliente,
                    $Direccion,
                    $IdTipDoc,
                    $idCorrelativo,
                    $serie,
                    $NumSerie,
                    $Moneda,
                    $Total,
                    null,
                    $CodSuc,
                    $IdUsuario,
                    $DocAfectado,
                    $Descripcion,
                    $TipoNota, 
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

                $insertGetId = DB::select('call Man_zg_ventas(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
                array(
                    'M02',
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
                    null
                ));
                //$array = array_values($insertGetId);
                $term_id = $insertGetId[0]->IdVentaCab; 

                foreach($request->get('VentaItems') as $item)
                {
                    $data = [];
                    $data['IdVentaCab'] = $term_id;
                    $data['IdItem'] = $item['IdItem'];
                    $data['DesItem'] = $item['ItemName'];
                    $data['IdUniMed'] = $item['IdMedProduct'];
                    $data['Price'] = $item['precio'];
                    $data['Quantity'] = $item['cantidad'];
                    $data['AfeIgv'] = $item['AfeIgv'];
                 
                 $detalle = DB::select('call Man_zg_ventas(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
                 array(
                     'M03',
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
                     null,
                     null,
                     null,
                     null,
                     null,
                     null,
                     $data['IdVentaCab'],
                     $data['IdItem'],
                     $data['DesItem'],
                     $data['IdUniMed'],
                     $data['Price'],
                     $data['Quantity'],
                     $data['AfeIgv']
                 ));
                     
 
                    //DB::table('zg_ordencompradet')->insert($data);
                }
                //DB::commit();
                $result = ['message'=>'Successfully added data','status'=> 'success'];
                return response()->json($term_id);
          } 

          public function UpdateVenta(Request $request){
            $IdVentaCab = $request->get('IdVentaCab');
            $IdEmpresa  = $request->get('IdEmpresa');
            $CodAlm  = $request->get('IdAlmacen');
            $IdCliente = $request->get('IdClient');
            $Direccion = $request->get('Direccion');
            $IdTipDoc = $request->get('IdTipDoc');
            $IdUsuario = $request->get('IdUsuario');
            // $IdItemVenta = $request->get('IdItemVenta');
            $idCorrelativo = $request->get('IdCorrelativo');
            $serie = $request->get('serie');
            $NumSerie = $request->get('NumSerie');
            $Moneda = $request->get('Moneda');
            $Total = $request->get('Total');
            $CodSuc  = $request->get('IdSuc');
                                
             $insertar =  DB::select('call Man_zg_ventas(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)'
             ,array(
                 'M04',
                 $IdEmpresa,
                 null,
                 $IdCliente,
                 $Direccion,
                 $IdTipDoc,
                 $idCorrelativo,
                 $serie,
                 null,
                 $Moneda,
                 $Total,
                 null,
                 $CodSuc,
                 $IdUsuario,
                 null,
                 null,
                 null,
                 null,
                 null,
                 $IdVentaCab,
                 null,
                 null,
                 null,
                 null,
                 null,
                 null
             ));

            //  $term_id = $insertGetId[0]->IdVentaCab; 

                foreach($request->get('VentaItems') as $item)
                {
                    $data = [];
                    $data['IdItemVenta'] = $item['IdItemVenta'];
                    $data['IdItem'] = $item['IdItem'];
                    $data['DesItem'] = $item['ItemName'];
                    $data['IdUniMed'] = $item['IdMedProduct'];
                    $data['Price'] = $item['precio'];
                    $data['Quantity'] = $item['cantidad'];
                    $data['AfeIgv'] = $item['AfeIgv'];
                  
                   
                      $detalle = DB::select('call Man_zg_ventas(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
                      array(
                          'M03',
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
                          null,
                          null,
                          null,
                          null,
                          null,
                          $data['IdItemVenta'],
                          $IdVentaCab,
                          $data['IdItem'],
                          $data['DesItem'],
                          $data['IdUniMed'],
                          $data['Price'],
                          $data['Quantity'],
                          $data['AfeIgv']
                      ));
                      // $result = $data;
                    
                }
                // $result = ['message'=>'Successfully added data','status'=> 'success'];
                return response()->json($detalle);

          }

          public function GetListVentas( $IdUsu,$IdEmp,$IdSuc){
            $ListVentas = DB::select('call Man_zg_ventas(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
            array(
                'S01',
                $IdEmp,
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
                $IdSuc,
                $IdUsu,
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
            
            return Response()->json($ListVentas);
          }

          public function GetDetalleVenta($IdVentaCab){
            $DetVenta = DB::select('call Man_zg_ventas(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
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
                $IdVentaCab,
                null,
                null,
                null,
                null,
                null,
                null
            ));

            return Response()->json($DetVenta);
          }

          public function GetMedidasProducto($IdProducto){
            $Medidas = DB::select('call Man_zg_ventas(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
            array(
                'S03',
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
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                $IdProducto,
                null,
                null,
                null,
                null,
                null
            ));

            return Response()->json($Medidas);
          }

          public function GetEmpData($CodEmp){
            $EmpData = DB::select('call Man_zg_ventas(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
            array(
                'S04',
                $CodEmp,
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

            return Response()->json($EmpData);
          }
          
          public function GetVenta($IdVentaCab){
            $Venta = DB::select('call Man_zg_ventas(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
            array(
                'S05',
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
                null,
                null,
                null,
                null,
                null,
                null,
                $IdVentaCab,
                null,
                null,
                null,
                null,
                null,
                null
            ));

            return Response()->json($Venta);
          }

          public function ListOpciones(){
            $result = DB::select('call Man_zg_ventas(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
            array(
              'S08',
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
                null
            ));

            return Response()->json($result, 201);
          }

          public function GetDataCliente($IdCliente){
            $result = DB::select('call Man_zg_ventas(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
            array(
              'S09',
                null,
                null,
                $IdCliente,
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

            return Response()->json($result, 201);
          }

          public function GetPagosVenta($IdVentaCab){
            $result = DB::select('call Man_zg_ventas(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
            array(
              'S10',
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
                null,
                null,
                null,
                null,
                null,
                null,
                $IdVentaCab,
                null,
                null,
                null,
                null,
                null,
                null
            ));

            return Response()->json($result, 201);
          }
    }


