<?php

namespace App\Http\Controllers\Logistica\Inventarios;
use Illuminate\Http\Request;
use DB;
use App\Http\Controllers\Controller;


class ProductosController extends Controller
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
   

    public function createProducto(Request $request){
        $Accion = 'M01';
        $IdProducto = null;
        $IdEmpresa = $request->get('IdEmpresa');
        $IdAlmacen = $request->get('IdAlmacen');
        $IdFamilia = $request->get('IdFamilia');
        $IdLinea = $request->get('IdLinea');
        $Codigo = '';
        $Nombre = $request->get('Nombre');
        $descripcion = $request->get('Descripcion');
        $IdUniMed = $request->get('IdUniMed');
        $PrecioUnit = $request->get('PrecioVent');
        $PrecioDoc = $request->get('PrecioComp');
        $AfeIgv = $request->get('AfeIgv');
        $AfePer = $request->get('AfePer');
        $AfeDet = $request->get('AfeDet');
        $Exoner = $request->get('Exoner');
        $Existencia = $request->get('Existencia');
        $Minimo = $request->get('Minimo');

        $Producto = DB::select('call Man_zg_productos(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        array(
            $Accion,
            $IdProducto,
            $IdEmpresa,
            $IdAlmacen,
            $IdFamilia,
            $IdLinea,
            $Codigo,
            $Nombre,
            $descripcion,
            $IdUniMed,
            $PrecioUnit,
            $PrecioDoc,
            $AfeIgv,
            $AfePer,
            $AfeDet,
            $Exoner,
            $Existencia,
            $Minimo,
            null,
            null
        ));
        return Response()->json($Producto, 201);
    }

    public function updateProducto(Request $request){
        $Accion = 'M02';
        $IdProducto = $request->get('IdProducto');
        $IdEmpresa = $request->get('IdEmpresa');
        $IdAlmacen = $request->get('IdAlmacen');
        $IdFamilia = $request->get('IdFamilia');
        $IdLinea = $request->get('IdLinea');
        $Codigo = '';
        $Nombre = $request->get('Nombre');
        $descripcion = $request->get('Descripcion');
        $IdUniMed = $request->get('IdUniMed');
        $PrecioUnit = $request->get('PrecioVent');
        $PrecioDoc = $request->get('PrecioComp');
        $AfeIgv = $request->get('AfeIgv');
        $AfePer = $request->get('AfePer');
        $AfeDet = $request->get('AfeDet');
        $Exoner = $request->get('Exoner');
        $Existencia = $request->get('Existencia');
        $Minimo = $request->get('Minimo');
        $Activo = $request->get('Activo');

        $Producto = DB::select('call Man_zg_productos(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        array(
            $Accion,
            $IdProducto,
            $IdEmpresa,
            $IdAlmacen,
            $IdFamilia,
            $IdLinea,
            $Codigo,
            $Nombre,
            $descripcion,
            $IdUniMed,
            $PrecioUnit,
            $PrecioDoc,
            $AfeIgv,
            $AfePer,
            $AfeDet,
            $Exoner,
            $Existencia,
            $Minimo,
            null,
            $Activo
        ));
        return Response()->json($Producto, 201);
    }

    public function deleteProducto($Id, $Activo){
        $Accion = 'M03';

        $Producto = DB::select('call Man_zg_productos(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
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
            null,
            null,
            null,
            $Activo
            
        ));
        
        return Response()->json($Producto, 200);
    }

    public function getListProductos($CodEmp){ //$IdSucursal
        $Accion= 'S01';
        $Productos = DB::select('call Man_zg_productos(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        array(
            $Accion,
            null,
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
            null
            
        ));

        return Response()->json($Productos,200);

    }
    public function getProducto($IdProducto){
        $Accion = 'S02';

        $Producto = DB::select('call Man_zg_productos(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
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
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null
        ));
        return Response()->json($Producto, 200);
    }

    public function getComboFamilias($IdEmpresa){
        $accion = 'S03';
        $Items = DB::select('call Man_zg_productos(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)'
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
        $accion = 'S04';
        
        $Items = DB::select('call Man_zg_productos(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
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
        $accion = 'S05';
        
        $Items = DB::select('call Man_zg_productos(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
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
        $accion = 'S06';
        
        $Items = DB::select('call Man_zg_productos(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
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
            null,
            null,
            null,
            null,
            null,
            null
            
        ));
        return response()->json($Items, 200);
    } 

    public function getListAfecIgv(){
        $accion = 'S07';
        
        $AfecIgvList = DB::select('call Man_zg_productos(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
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
            null,
            null,
            null,
            null
            
        ));
        return response()->json($AfecIgvList, 200);
    }

    // public function uploadFilesProduct(Request $request, $idProducto, $nombreFoto){

    //     if( $request->header('Authorization') ){
    //         $this->validate($request, [
    //             'image' => 'image|mimes:jpeg,jpg'
    //         ]);
    
    //         if($request->hasFile('image'))
    //         {
    //             $img_save = false;
    //             $imageEnterprise = $request->file('image');
    
    //             $file = $imageEnterprise; 
    //             $imagen_titulo = $nombreFoto.'.'.$file->getClientOriginalExtension();
    //             $file->move('productos/'.$idProducto.'/', $imagen_titulo); 
    //             $img_save = true; 

    //             if($img_save && $imagen_titulo)
    //             {
    //                 $result = DB::table('zg_productos')
    //                     ->where('IdProducto', $idProducto)
    //                     ->update([$nombreFoto => $imagen_titulo]);
    //                 return response()->json(['imagen actualizada'=>$result], 200);
    //             }
    //         }else{
    //             return response()->json(['algo ha ocurrido'=> $request->hasFile('image'), 'image'=>$request->file('image') ], 200);
    //         }


    //     }else{
    //         return response()->json('Unauthorized', 401);
    //     }
        
    // }

}
