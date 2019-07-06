<?php

namespace App\Http\Controllers\Logistica\Inventarios;

use Illuminate\Http\Request;
use DB;
use App\Http\Controllers\Controller;

class ClienteController extends Controller
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

        public function CreateCliente(Request $request){
            $Accion = 'M01';
            $IdCliente= null;
            $IdEmpresa = $request->get('CodEmp');
            $TipoDocumento = $request->get('TipoDocumento');
            $NumDocumento = $request->get('NumDocumento');
            $Nombres = $request->get('RazonSocial');
            $NombComer = $request->get('NombComercial'); 
            $idDatos = $request->get('IdDatos');
            $idDepa = $request->get('IdDepartamento');
            $idProv = $request->get('IdProvincia');
            $idDist = $request->get('IdDistrito');
            $Direccion = $request->get('Direccion');
            $Principal = $request->get('Principal');
            $Telefono = $request->get('Telefono');
            $Email = $request->get('Email');
            $Encargado = $request->get('Encargado');

            $Cliente = DB::Select('call Man_zg_clientes(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
            array(
                $Accion,
                $IdCliente,
                $IdEmpresa,
                $TipoDocumento,
                $NumDocumento,
                $Nombres,
                $NombComer,                 
                $idDatos, 
                $idDepa,
                $idProv,
                $idDist,
                $Direccion,
                $Principal,
                $Telefono,
                $Email,
                $Encargado,
                null
            ));
            
                return response()->json(['Cliente Creado'=>$Cliente], 201);        
        }

        public function InsertClienteDatos(Request $request, $IdCliente){
            $Accion = 'M02';
            $idDatos = $request->get('IdDatos');
            $idDepa = $request->get('IdDepartamento');
            $idProv = $request->get('IdProvincia');
            $idDist = $request->get('IdDistrito');
            $Direccion = $request->get('Direccion');
            $Principal = $request->get('Principal');
            $Telefono = $request->get('Telefono');
            $Email = $request->get('Email');
            $Encargado = $request->get('Encargado');

            $Cliente = DB::Select('call Man_zg_clientes(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
            array(
                $Accion, 
                $IdCliente,
                null,
                null,
                null,
                null,
                null,                               
                $idDatos, 
                $idDepa,
                $idProv,
                $idDist,
                $Direccion,
                $Principal,
                $Telefono,
                $Email,
                $Encargado,
                null
            ));
            
                return response()->json(['Cliente Creado'=>$Cliente], 201);
        }

        public function updateCliente(Request $request){
            $Accion = 'M04';
            $IdCliente = $request->get('IdCliente');
            $IdEmpresa = $request->get('CodEmp');
            $TipoDocumento = $request->get('TipoDocumento');
            $NumDocumento = $request->get('NumDocumento');
            $Nombres = $request->get('RazonSocial');
            $NombComer = $request->get('NombComercial');            
            $idDatos = $request->get('IdDatos');
            $idDepa = $request->get('IdDepartamento');
            $idProv = $request->get('IdProvincia');
            $idDist = $request->get('IdDistrito');
            $Direccion = $request->get('Direccion');
            $Principal = $request->get('Principal');
            $Telefono = $request->get('Telefono');
            $Email = $request->get('Email');
            $Encargado = $request->get('Encargado');

            $Cliente = DB::select('call Man_zg_clientes(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
            array(
                $Accion,
                $IdCliente,
                $IdEmpresa,
                $TipoDocumento,
                $NumDocumento,
                $Nombres,
                $NombComer,
                $idDatos,   
                $idDepa,
                $idProv,
                $idDist,
                $Direccion,
                $Principal,
                $Telefono,
                $Email,
                $Encargado,
                null
            ));
            return response()->json(['Registro Actualizado'=>$Cliente], 201);
        }

        public function updateDireccion(Request $request){
            $Accion = 'M05';                       
            $idDatos = $request->get('IdDatos');
            $idDepa = $request->get('IdDepartamento');
            $idProv = $request->get('IdProvincia');
            $idDist = $request->get('IdDistrito');
            $Direccion = $request->get('Direccion');
            $Principal = $request->get('Principal');
            $Telefono = $request->get('Telefono');
            $Email = $request->get('Email');
            $Encargado = $request->get('Encargado');

            $Direccion = DB::select('call Man_zg_clientes(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
            array(
                $Accion,
                null,
                null,
                null,
                null,
                null,
                null,
                $idDatos,   
                $idDepa,
                $idProv,
                $idDist,
                $Direccion,
                $Principal,
                $Telefono,
                $Email,
                $Encargado,
                null
            ));
            return response()->json(['Registro Actualizado'=>$Direccion], 201);
        }




        public function cambiarEstadoCliente($IdCliente, $Activo){
            $Accion = 'M06';
            $Cliente = DB::select('call Man_zg_clientes(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
            array(
                $Accion,
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
                $Activo
            ));
            return response()->json($Cliente, 200);
        }

        public function deleteCliente($IdCliente){
            $Accion = 'M07';
            
            $Cliente = DB::select('call Man_zg_clientes(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
            array(
                $Accion,
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
                null
            ));
            return response()->json(['Cliente Eliminado del Registro'=>$Cliente], 200);
        }

        public function deleteDatos($idDatos){
            $Accion = 'M08';
            
            $Cliente = DB::select('call Man_zg_clientes(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
            array(
                $Accion,
                null,
                null,
                null,
                null,
                null,
                null,
                $idDatos,
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
            return response()->json(['Datos Eliminado del Registro'=>$Cliente], 200);
        }

        public function GetListClientes(){
            $Accion = 'S01';

            $Clientes = DB::select('call Man_zg_clientes(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
            array(
                $Accion,
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
                return response()->json($Clientes, 200);
        }

            public function getCliente($Id){
                $Accion = 'S02';
                $Cliente = DB::select('call Man_zg_clientes(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
                array(
                    $Accion,
                    $Id,
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
                return response()->json($Cliente, 200);
            }

            public function GetClientes(){
                $Accion = 'S03';

                $Clientes = DB::select('call Man_zg_clientes(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
                array(
                    $Accion,
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
                return response()->json($Clientes, 200);
            }

            public function GetDatosCliente($IdCliente){
                $Accion = 'S04';
                $Cliente = DB::select('call Man_zg_clientes(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
                array(
                    $Accion,
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
                    null
                ));
                return response()->json($Cliente, 200);
            }

            public function getDistritos($idProv){
                $accion = 'S05';
                $Clientes = DB::select('call Man_zg_clientes(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)'
                ,
                array(
                    $accion,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,  
                    null,          
                    $idProv,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null           
                ));
                return response()->json($Clientes, 200);
            }

            public function getDocsEntidad(){
                $accion = 'S06';
                $Clientes = DB::select('call Man_zg_clientes(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)'
                ,
                array(
                    $accion,
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
                return response()->json($Clientes, 200);
            }

            public function getPaises(){
                $accion = 'S02';
                $Clientes = DB::select('call Man_zg_proveedores(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)'
                ,
                array(
                    $accion,
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
                return response()->json($Clientes, 200);
            }
        
        
            public function getDepartamentos(){
                $accion = 'S03';
                $Clientes = DB::select('call Man_zg_proveedores(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)'
                ,
                array(
                    $accion,
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
                return response()->json($Clientes, 200);
            }
        
            public function getProvincias($idDepa){
                $accion = 'S04';
                $Clientes = DB::select('call Man_zg_proveedores(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)'
                ,array(
                    $accion,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    $idDepa,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null            
                ));
                return response()->json($Clientes, 200);
            }
        
           

}