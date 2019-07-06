<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class EmpresaController extends Controller
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
    //Crear, Actualizar y Eliminar empresa
    public function createEnterprise(Request $request, $accion){
     
      $CodEmp = $request->get('IdEmpresa');
      $IdUsuario = $request->get('IdUsuario');
      $nombreEmpresa = $request->get('Nombre');
      $nombreCortoEmpresa = $request->get('NombreCorto');
      $nombreComercial = $request->get('NombreComercial');
      $direccion = $request->get('Direccion');
      $ruc = $request->get('Ruc');
      $telefono = $request->get('Telefono');
      $email = $request->get('Email');
      $webPage = $request->get('WebPage');
      $activo = null;
      $imagen1 = null;
      $imagen2 = null;
      $imagen3 = null;
      $imagen4 = null;
      $ubigeo = $request->get('Ubigeo');

      $empresa =  DB::select('call Man_zg_empresas(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)'
      ,array(
            $accion,
            $IdUsuario,
            $CodEmp,
            $nombreEmpresa,
            $nombreComercial,
            $nombreCortoEmpresa,
            $direccion,
            $ruc,
            $telefono,
            $email,
            $webPage,
            $activo,
            $imagen1,
            $imagen2,
            $imagen3,
            $imagen4,
            $ubigeo            
      ));



    //   if($empresa){
        return response()->json($empresa, 201);
        // return response()->json(['status' => 'success', 'data' => $empresa]);
    //   }
    //   else{
    //     return response()->json(['Datos de la Empresa No Registrados correctamento'=> $empresa], 404);
    //   }
      
    }

    public function CambiarEstadoEmpresa($IdEmpresa, $Activo){
        $empresa = DB::select('call Man_zg_empresas(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        array(
            'M04',
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
            $Activo,
            null,
            null,
            null,
            null,
            null
        ));

        // if($empresa){
            return response()->json($empresa, 200);
        //   }
        //   else{
        //     return response()->json(['Datos de la Empresa No Registrados correctamento'=> $empresa], 404);
        //   }
    }

      
    //obtener empresas
    public function getEnterprises($IdUsuario){
        $accion = 'S01';
        $empresas = DB::select('call Man_zg_empresas(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        array(
            $accion,
            $IdUsuario,
            $IdUsuario,
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

        return response()->json($empresas, 200);
    }    

    public function getImagenes($idEmpresa){
        $imagenes = DB::select('call Man_zg_empresas(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        array(
            'S02',
            null,
            $idEmpresa,
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
        
        return response()->json($imagenes, 200);
    }

    // Procedimento de Ubigeo
    public function getdepartamentos(){
        $departamentos = DB::select('call Man_zg_ubigeo(?, ?)',
        array(
            'S01',
            null
        ));
        return response()->json($departamentos,200);
    }
    public function getProvincias($idDepa){
        $provincias = DB::select('call Man_zg_ubigeo(?, ?)',
        array(
            'S02', 
            $idDepa
        ));
        return response()->json($provincias, 200);
    }

    public function getDistritos($idProv){
        $distritos = DB::select('call Man_zg_ubigeo(?, ?)',
        array(
            'S03', 
            $idProv
        ));

        return response()->json($distritos,200);
    }


    //subir fotos de empresa
    public function uploadFilesEnterprise(Request $request, $idEmpresa, $nombreFoto){

        if( $request->header('Authorization') ){
            $this->validate($request, [
                'image' => 'image|mimes:jpeg,jpg'
            ]);
    
            if($request->hasFile('image'))
            {
                $img_save = false;
                $imageEnterprise = $request->file('image');
    
                $file = $imageEnterprise; 
                $imagen_titulo = $nombreFoto.'.'.$file->getClientOriginalExtension();
                $file->move('empresas/'.$idEmpresa.'/', $imagen_titulo); 
                $img_save = true; 

                if($img_save && $imagen_titulo)
                {
                    $result = DB::table('zg_empresas')
                        ->where('IdEmpresa', $idEmpresa)
                        ->update([$nombreFoto => $imagen_titulo]);
                    return response()->json(['imagen actualizada'=>$nombreFoto], 200);
                }
            }else{
                return response()->json(['algo ha ocurrido'=> $request->hasFile('image'), 'image'=>$request->file('image') ], 200);
            }


        }else{
            return response()->json('Unauthorized', 401);
        }
        
    }

   /* public function getEnterprise(){
        $accion = 'S01';

        $empresas =  DB::select('call Man_zg_empresa(?)'
        ,array(
              $accion,
              $idEmpresa
        ));

        return response()->json(['Empresas'=>$empresas], 200);
    }*/
}
