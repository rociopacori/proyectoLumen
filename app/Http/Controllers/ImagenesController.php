<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class ImagenesController extends Controller
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
    
      //subir fotos de empresa
      public function uploadFilesProduct(Request $request, $idProducto, $nombreFoto){

        if( $request->header('Authorization') ){
            $this->validate($request, [
                'image' => 'image|mimes:jpeg,jpg'
            ]);
    
            if($request->hasFile('image'))
            {
                $img_save = false;
                $imageProduct = $request->file('image');
    
                $file = $imageProduct; 
                $imagen_titulo = $nombreFoto.'.'.$file->getClientOriginalExtension();
                $file->move('productos/'.$idProducto.'/', $imagen_titulo); 
                $img_save = true; 

                if($img_save && $imagen_titulo)
                {
                    $result = DB::table('zg_productos')
                        ->where('IdProducto', $idProducto)
                        ->update([$nombreFoto => $imagen_titulo]);
                    return response()->json(['imagen actualizada'=>$result], 200);
                }
            }else{
                return response()->json(['algo ha ocurrido'=> $request->hasFile('image'), 'image'=>$request->file('image') ], 200);
            }


        }else{
            return response()->json('Unauthorized', 401);
        }
        
    }

    public function removeFilesProduct($idProducto, $nombreFoto){
        $Accion = 'M04';

        $imagen = DB::select('call Man_zg_productos(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        array(
            $Accion,
            $IdProducto,
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
        return Response()->json($imagen, 202);
    }
}