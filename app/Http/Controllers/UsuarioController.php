<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;
use Illuminate\Support\Facades\File;


class UsuarioController extends Controller
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

    public function createUser(Request $request){
        //seguridad en header para ruta sin midleware
        if($request->isJson() && $request->header('SecretKey') === 'app_pedrorla'){

            $accion = 'M01';
            $idUsuario = null; //$request->json()->get('idUsuario');
            $idUsuarioAuth = $request->json()->get('idUsuarioAuth');
            $nombre = $request->json()->get('nombre');
            $logLogin = $request->json()->get('logLogin');
            $logClave = $request->json()->get('logClave'); //token
            $estado =  $request->json()->get('estado');
            $foto = $request->json()->get('foto');
            $usuKey = $request->json()->get('usuKey');
            $idUsuKey = $request->json()->get('idUsuKey');
            $fechaReg = $request->json()->get('fechaRegistro');
            $inicioFact =  $request->json()->get('periodoIniFac');
            $finFact = $request->json()->get('periodoFinFac');
            $telefo = $request->json()->get('telefo');
            $usuario =  DB::select('call Man_zg_usuarios(?,?,?,?,?,?,?,?,?,?,?,?,?,?, @)',
            array(
                $accion,
                $idUsuario,
                $idUsuarioAuth,
                $nombre,
                $logLogin,
                $logClave,
                $estado,
                $foto,
                $usuKey,
                $idUsuKey,
                $fechaReg,
                $inicioFact,
                $finFact,
                $telefo
            ));
          
            //si se creeo correctamente se consulta su id
             if(isset($usuario[0]->success_) && $usuario[0]->success_ == 'usuario creado'){
                $getIdUsuario = DB::select('call Man_zg_usuarios(?,?,?,?,?,?,?,?,?,?,?,?,?,?, @)', 
                array(
                    'S03', 
                    null,
                    null,
                    null,
                    $logLogin,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                ));
              
                //si se obtiene el id del usuario creado, insertar el plan que selecciono
                    if(isset($getIdUsuario[0]->IdUsuario)){
                        $idUsuarioExist = $getIdUsuario[0]->IdUsuario;
                        $idPlan = $request->json()->get('idPlan');
                        $fechaRegPlan = $request->json()->get('fechaRegistro');
                        $horaRegPlan= $request->json()->get('horaRegistro');
                        //crear el plan del usuario
                        return $this->createPlanUser($idUsuarioExist, $idPlan, $fechaRegPlan, $horaRegPlan);
                    }else{
                       response()->json(['No se puedo obtener el usuario'], 200);
                    }
            }else{
               response()->json(['No se puedo crear el usuario'], 200);
            }
        }else{
            return response()->json(['Unauthorized'=> $request->header('SecretKey')], 401);
        }
    }

    
    //CREAR PLAN DEL USUARIO SELECCIONADO
    public function createPlanUser($_idusuario, $_idPlan, $_fecha, $_hora){
        $accion = 'M01';
        $idUsuario = $_idusuario;
        $idPlan = $_idPlan;
        $fecha = $_fecha;
        $hora = $_hora;

        $planUser = DB::select('call Man_zg_usuarioplan(?,?,?,?,?, @)'
            ,array(
                $accion,
                $idUsuario,
                $idPlan,
                $fecha,
                $hora
            ));

        if(isset($planUser[0]->success_) && $planUser[0]->success_ == 'Plan del usuario creado'){
          return response()->json([$planUser[0]->success_], 201);
        }else{
          return response()->json(['No se pudo crear el plan del usuario'], 200);
        }
    }

    public function updateUser(Request $request){
        $accion = 'M02';
        $idUsuarioAuth = $request->json()->get('idUsuarioAuth');
        $nombre = $request->json()->get('nombre');
        //$foto = $request->json()->get('foto');
        $telefo = $request->json()->get('telefo');

        $usuario =  DB::select('call Man_zg_usuarios(?,?,?,?,?,?,?,?,?,?,?,?,?,?, @)'
        ,array(
            $accion,
            null,
            $idUsuarioAuth,
            $nombre,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            $telefo
        ));
        if(isset($usuario[0]->success_) && $usuario[0]->success_ == 'usuario actualizado'){
          return response()->json($usuario[0]->success_, 200);
        }else{
          return response()->json('No se pudo actualizar los datos del usuario', 200);
        }
    }

    public function deleteUser(){
        $accion = 'M03';
        $idUsuario = null;

        $usuario =  DB::select('call Man_zg_usuarios(?,?)'
        ,array(
            $accion,
            $idUsuario
        ));

        return response()->json(['success' => 'Usuario'. $idUsuario .'Eliminado'], 200);

    }

    //ACTUALIZAR TOKEN DEL USUARIO
    public function updateTokenUser(Request $request){
        $accion = 'M04';
        $idUsuarioAuth = $request->json()->get('idUsuarioAuth');
        $logClave = $request->json()->get('logClave'); //token

        if($request->isJson() && $request->header('SecretKey') === 'app_pedrorla' && $request->header('IdUserAuth') == $idUsuarioAuth){
            $tokenUsuario =  DB::select('call Man_zg_usuarios(?,?,?,?,?,?,?,?,?,?,?,?,?,?, @)',
            array(
                $accion,
                null,
                $idUsuarioAuth,
                null,
                null,
                $logClave,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null
            ));
            if(isset($tokenUsuario[0]->success_) && $tokenUsuario[0]->success_ == 'token de usuario actualizado'){
                return response()->json('token de usuario actualizado', 200);
            }
            return response()->json('no se pudo actualizar el token del usuario', 200);
        }else{
            return response()->json('Unauthorized', 401);
        }
    }

    public function createSubUser($accion, Request $request){
        // if($request->isJson() && $request->header('SecretKey') === 'app_pedrorla'){

            $idUsuario = $request->json()->get('IdUsuario');
            $idUsuarioAuth = $request->json()->get('IdUsuario');
            $nombre = $request->json()->get('Nombre');
            $logLogin = $request->json()->get('Email');
            $logClave = $request->json()->get('Password'); //token
            $estado =  $request->json()->get('Estado');
            $foto = $request->json()->get('Foto');
            $idUsuKey = $request->json()->get('idUsuarioAuthKey');
            $fechaReg = $request->json()->get('FechaRegistro');
            $inicioFact =  $request->json()->get('periodoIniFac');
            $finFact = $request->json()->get('periodoFinFac');
            $telefo = $request->json()->get('Telefono');
            $usuario =  DB::select('call Man_zg_usuarios(?,?,?,?,?,?,?,?,?,?,?,?,?,?, @)',
            array(
                $accion,
                $idUsuario,
                $idUsuarioAuth,
                $nombre,
                $logLogin,
                $logClave,
                $estado,
                $foto,
                $idUsuKey,
                $fechaReg,
                null,
                null,
                $telefo,
                null,
                null
            ));
          
            if(isset($usuario[0]->success_) && $usuario[0]->success_ == 'usuario creado'){
                return response()->json('usuario creado', 201);
            }
            return response()->json('no se pudo crear el usuario', 404);

        // }
    }

    public function CanbiarEstadoUsuario($idUsuario,$Activo){
        $usuario =  DB::select('call Man_zg_usuarios(?,?,?,?,?,?,?,?,?,?,?,?,?,?, @)'
        ,array(
            'M07',
            $idUsuario,
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
            $Activo,
            null
        ));

        if(isset($usuario[0]->success_) && $usuario[0]->success_ == 'Estado actualizado'){
            return response()->json('Estado actualizado', 201);
        }
        return response()->json('No se pudo actualizar el estado', 404);

    }
    public function getUsers($idUsuario){
        $accion = 'S01';

        $usuarios =  DB::select('call Man_zg_usuarios(?,?,?,?,?,?,?,?,?,?,?,?,?,?, @)'
        ,array(
            $accion,
            $idUsuario,
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

        return response()->json($usuarios, 200);
    }
    

    //LISTA DE PLANES Y MODULOS 
    public function planesList(){
        $accion = 'S02';
        $results = DB::select('SELECT * FROM zg_zplanes');
        // $results = DB::table('zg_zplanes')->get();
        // $planes =  DB::select('call Man_zg_usuarios(?,?,?,?,?,?,?,?,?,?,?,?,?,?, @)'
        // ,array(
        //     $accion,
        //     null,
        //     null,
        //     null,
        //     null,
        //     null,
        //     null,
        //     null,
        //     null,
        //     null,
        //     null,
        //     null,
        //     null,
        //     null,
        //     null
        // ));

        // if(sizeof($planes) > 0){
          return response()->json(['Planes' => $results], 200);
        // }



    }
    // S03 -> dentro de la accion M01 de Man_zg_usuarios...

    public function getUserPrimary($idUserAuth){
        $accion = 'S04';

        $userPrimary = DB::select('call Man_zg_usuarios(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, @success_)'
            ,array(
                $accion,
                null,
                $idUserAuth,
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

        if(sizeof($userPrimary) > 0){
            return response()->json($userPrimary, 200);
        }else{
            return response()->json('No se pudo obtener el usuario', 200);
        }
    }
    


    //UPLOAD IMAGE
    public function uploadUserProfile(Request $request, $idUserAuth, $nombreFoto){
        $this->validate($request, [
            'image' => 'image|mimes:jpeg,jpg'
        ]);

        $imageBeforeUser = DB::table('zg_zusuarios')
            ->select('Foto')
            ->where('IdUsuario', '=', $idUserAuth)
            ->get();
        if(isset($imageBeforeUser[0]->Foto)){
          $file_prev = $imageBeforeUser[0]->Foto;
        }

        $img_save = false;
        $path = $this->public_path('user_profile');

        //se trae la ruta del arch ant. y se elimina, luego se almacena uno nuevo...
        if(File::exists($path) && $file_prev)
        {
            File::Delete($file_prev);
        }
        if($request->hasFile('image'))
        {
            $file = $request->file('image'); 
            $imagen_titulo = $nombreFoto.'.'.$file->getClientOriginalExtension();
            $file->move('user_profile/'.$idUserAuth.'/', $imagen_titulo); 
            $img_save = true; 
        }
        if($img_save && $imagen_titulo)
        {
            $result = DB::table('zg_zusuarios')
                ->where('IdUsuario', $idUserAuth)
                ->update(['Foto' => $imagen_titulo]);
            return response()->json(['perfil de usuario actualizado'=>$result], 200);
        }
        
        return response()->json('No se pudo actualizar la foto del perfil', 200);
    }


    //Helper para path public para el directorio de imagenesn
    function public_path($path = null)
    {
        return rtrim(app()->basePath('public/' . $path), '/');
    }

}
