<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/


use Illuminate\Http\Request;

$router->get('/key', function (){
    return str_random(32);
});


//rutas usuarios
// LOGISTICA / INVENTARIOS
$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'users'], function () use ($router) {
    $router->put('updateUser', 'UsuarioController@updateUser');
    $router->delete('deleteUser', 'UsuarioController@deleteUser');
    $router->get('getUsers/{idUsuario}', 'UsuarioController@getUsers');
    $router->get('getUserPrimary/{ idUserAuth }', 'UsuarioController@getUserPrimary');  
    $router->post('registerUser/{accion}','UsuarioController@createSubUser');
    $router->get('CanbiarEstadoUsuario/{idUsuario}/{Activo}', 'UsuarioController@CanbiarEstadoUsuario');
    
    $router->get('test', function(Request $request){
        return 'test rutas con middleware trabajando';    
    });
});

$router->post('registerUser', 'UsuarioController@createuser');
$router->get('existUser/{tokenUser}', 'UsuarioController@existUser');
$router->post('updateTokenUser','UsuarioController@updateTokenUser');
$router->get('planesList', 'UsuarioController@planesList');
$router->post('uploadFilesUser/{ idUserAuth }/{ namePhoto }', 'UsuarioController@uploadUserProfile'); //'uploadFilesUser'

//rutas planes de usuarios
$router->group(['prefix' => 'plan-user'], function () use ($router) {
    $router->put('updatePlanUser', 'PlanController@updatePlanUser');
    $router->delete('deletePlanUser', 'PlanController@deletePlanUser');
    $router->get('getPlanUser', 'PlanController@getPlanUser'); 

});
$router->post('createPlanUser', 'PlanController@createPlanUser');

// LOGISTICA / INVENTARIOS
// TIPO_DOCUMENTOS
$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'Tipodocumentos'], 
function () use ($router) {
    $router->post('createTipodocumentos', 'Logistica\Inventarios\TipodocumentosController@createTipodocumentos');
    $router->put('updateTipodocumentos', 'Logistica\Inventarios\TipodocumentosController@updateTipodocumentos');
    $router->get('updateDocumento/{IdTipDoc}/{Activo}', 'Logistica\Inventarios\TipodocumentosController@updateDocumento');
    $router->delete('deleteTipodocumentos/{ CodTipDoc }', 'Logistica\Inventarios\TipodocumentosController@deleteTipodocumentos');
    $router->get('getTipodocumentos/{ CodEmp }', 'Logistica\Inventarios\TipodocumentosController@getTipodocumentos');
});
// PRODUCTOS
$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'Producto'],
function () use($router){
    $router->get('getListProductos/{ CodEmp }', 'Logistica\Inventarios\ProductosController@getListProductos');
    $router->get('getProducto/{ Id }', 'Logistica\Inventarios\ProductosController@getProducto');
    $router->post('createProducto/{ IdSucursal }', 'Logistica\Inventarios\ProductosController@createProducto'); 
    $router->post('updateProducto', 'Logistica\Inventarios\ProductosController@updateProducto');
    $router->delete('deleteProducto/{Id}/{Activo}', 'Logistica\Inventarios\ProductosController@deleteProducto');
    $router->get('getComboFamilias/{ CodEmp }', 'Logistica\Inventarios\ProductosController@getComboFamilias');   
    $router->get('getComboLineas/{ CodEmp }', 'Logistica\Inventarios\ProductosController@getComboLineas');
    $router->get('getComboMedidas/{ CodEmp }', 'Logistica\Inventarios\ProductosController@getComboMedidas'); 
    $router->get('getComboAlmacenes/{ CodEmp }', 'Logistica\Inventarios\ProductosController@getComboAlmacenes');
    $router->get('getListAfecIgv', 'Logistica\Inventarios\ProductosController@getListAfecIgv');
    
});
// ITEMS
$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'Items'], 
function () use ($router) {
    $router->post('createItems', 'Logistica\Inventarios\ItemsController@createItems');
    $router->put('updateItems', 'Logistica\Inventarios\ItemsController@updateItems');
    $router->get('deleteItems/{ CodIte }/{ Activo }', 'Logistica\Inventarios\ItemsController@deleteItems');       
    $router->get('getComboFamilias/{ CodEmp }', 'Logistica\Inventarios\ItemsController@getComboFamilias');   
    $router->get('getComboLineas/{ CodEmp }', 'Logistica\Inventarios\ItemsController@getComboLineas');
    $router->get('getComboMedidas/{ CodEmp }', 'Logistica\Inventarios\ItemsController@getComboMedidas'); 
    $router->get('getComboAlmacenes/{ CodEmp }', 'Logistica\Inventarios\ItemsController@getComboAlmacenes');     
    $router->get('getItems/{ CodEmp }', 'Logistica\Inventarios\ItemsController@getItems'); 
});
// SUCURSALES
$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'Sucursales'], 
function () use ($router) {
    $router->post('createSucursales/{ IdUsuario }', 'Logistica\Inventarios\SucursalesController@createSucursales');
    $router->put('updateSucursales/{ IdUsuario }', 'Logistica\Inventarios\SucursalesController@updateSucursales');
    $router->delete('deleteSucursales/{ CodEmp }/{ CodSuc }', 'Logistica\Inventarios\SucursalesController@deleteSucursales');
    $router->get('getSucursales/{ CodEmp }/{ IdUsuario }', 'Logistica\Inventarios\SucursalesController@getSucursales');   
    $router->get('getComboZonas/{ CodEmp }', 'Logistica\Inventarios\SucursalesController@getComboZonas');
    $router->get('getComboEmpresas', 'Logistica\Inventarios\SucursalesController@getComboEmpresas');
    $router->put('cambiarEstado', 'Logistica\Inventarios\SucursalesController@cambiarEstado'); 
    $router->get('getDepartamentos','Logistica\Inventarios\SucursalesController@getDepartamentos'); 
    $router->get('getProvincias/{IdDepa}','Logistica\Inventarios\SucursalesController@getProvincias'); 
    $router->get('getDistritos/{IdProv}','Logistica\Inventarios\SucursalesController@getDistritos');
    
});
// ALMACENES
$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'Almacenes'], 
function () use ($router) {
    $router->post('createupdateAlmacenes/{ Accion }', 'Logistica\Inventarios\AlmacenesController@createAlmacenes');
    $router->put('updateAlmacenes', 'Logistica\Inventarios\AlmacenesController@updateAlmacenes');
    $router->delete('deleteAlmacenes/{ CodEmp }/{ CodAlm }', 'Logistica\Inventarios\AlmacenesController@deleteAlmacenes');
    $router->get('updateEstatusAlmacen/{ IdEmpresa }/{ IdAlmacen }/{ Activo }','Logistica\Inventarios\AlmacenesController@updateEstatusAlmacen');
    $router->get('getAlmacenes/{ CodEmp }', 'Logistica\Inventarios\AlmacenesController@getAlmacenes');
    $router->get('getLastIdAlmacen/{ IdEmpresa }', 'Logistica\Inventarios\AlmacenesController@getLastIdAlmacen');    
});
// LINEAS
$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'Familias'], 
function () use ($router) {
    $router->post('createUpdateFamilias/{ Accion}', 'Logistica\Inventarios\LineasController@createUpdateFamilias');
    $router->delete('deleteFamilias/{ IdEmpresa }/{ IdAlmacen }/{ IdLinea }', 'Logistica\Inventarios\LineasController@deleteFamilias');
    $router->get('getFamilias/{ CodEmp }', 'Logistica\Inventarios\LineasController@getFamilias');   
    $router->get('getComboAlmacenes/{ CodEmp }', 'Logistica\Inventarios\LineasController@getComboAlmacenes');    
    $router->get('getComboPropiedades/{ CodEmp }', 'Logistica\Inventarios\LineasController@getComboPropiedades'); 
});
// SUBLINEAS
$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'Lineas'], 
function () use ($router) {

    $router->post('createUpdateLineas/{Accion}', 'Logistica\Inventarios\SubLineasController@createUpdateLineas');
    $router->post('createLineas', 'Logistica\Inventarios\SubLineasController@createSubLineas');
    $router->put('updateLineas', 'Logistica\Inventarios\SubLineasController@updateLineas');
    $router->delete('deleteLineas/{ CodLin }', 'Logistica\Inventarios\SubLineasController@deleteLineas');
    $router->get('cambiarEstadoLinea/{idLinea}/{Activo}', 'Logistica\Inventarios\SubLineasController@cambiaeEstadoLinea');
    $router->get('getLineas/{ CodEmp }', 'Logistica\Inventarios\SubLineasController@getLineas');    
    $router->get('getComboFamilias/{ CodEmp }', 'Logistica\Inventarios\SubLineasController@getComboFamilias');
    $router->get('getAlmacenes/{ CodEmp }', 'Logistica\Inventarios\SubLineasController@getAlmacenes');
});
// MEDIDAS
$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'Medidas'], 
function () use ($router) {
    $router->post('createMedidas', 'Logistica\Inventarios\MedidasController@createMedidas');
    $router->put('updateMedidas', 'Logistica\Inventarios\MedidasController@updateMedidas');
    $router->delete('DeleteMedida/{ CodUniMed }', 'Logistica\Inventarios\MedidasController@DeleteMedida');
    $router->get('getMedidas/{ CodEmp }', 'Logistica\Inventarios\MedidasController@getMedidas');
});
// ZONAS
$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'Zonas'], 
function () use ($router) {
    $router->post('createZonas', 'Logistica\Inventarios\ZonasController@createZonas');
    $router->put('updateZonas', 'Logistica\Inventarios\ZonasController@updateZonas');
    $router->delete('deleteZonas/{ CodZon }', 'Logistica\Inventarios\ZonasController@deleteZonas');
    $router->get('getZonas/{ CodEmp }', 'Logistica\Inventarios\ZonasController@getZonas');  
    $router->get('getComboEmpresas/{ CodEmp }', 'Logistica\Inventarios\ZonasController@getComboEmpresas');   
});

//thisis the first one that works
$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'enterprises'], 
function () use ($router) {
    
    $router->post('createEnterprise/{accion}', 'EmpresaController@createEnterprise');
    $router->get('estadoEnterprises/{idEmpresa}/{activo}','EmpresaController@CambiarEstadoEmpresa'); 
//     $router->put('updateEnterprise', 'EmpresaController@updateEnterprise');
//     $router->delete('deleteEnterprise/{ CodEmp }', 'EmpresaController@deleteEnterprise');
    $router->get('getEnterprises/{idUsuario}', 'EmpresaController@getEnterprises');

    
    $router->get('getDepartamentos','EmpresaController@getDepartamentos'); 
    $router->get('getProvincias/{idDepa}','EmpresaController@getProvincias'); 
    $router->get('getDistritos/{idProv}','EmpresaController@getDistritos');
    $router->get('getImagenes/{idEmpresa}', 'EmpresaController@getImagenes');  
});
//and this is the second one that doesnt work
//as you can see both look pretty similar



$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'Zmodulos'],
function () use ($router) {
$router->post('CreateUpdateZmodulos/{Accion}', 'ZmodulosController@CreateUpdateZmodulos');
$router->get('GetZmodulos/{IdEmpresa}', 'ZmodulosController@GetZmodulos');
$router->delete('DeleteZmodulos/{IdZmodulo}', 'ZmodulosController@DeleteZmodulos');
$router->get('UpdateEstadoZmodulos/{IdZmodulo}', 'ZmodulosController@UpdateEstadoZmodulos');
});

$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'Propiedades'],
function () use ($router) {
$router->post('CreateUpdatePropiedades/{Accion}', 'PropiedadesController@CreateUpdatePropiedades');
$router->get('GetPropiedades/{IdEmpresa}', 'PropiedadesController@GetPropiedades');
$router->delete('DeletePropiedades/{IdEmpresa}/{IdPropiedad}', 'PropiedadesController@DeletePropiedades');
$router->get('UpdateEstadoPropiedades/{IdEmpresa}/{IdPropiedad}/{Activo}', 'PropiedadesController@UpdateEstadoPropiedades');
});



$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'Correlativos'],
function () use ($router) {
$router->post('CreateUpdateCorrelativos/{Accion}', 'CorrelativosController@CreateUpdateCorrelativos');
$router->get('GetCorrelativos/{IdEmpresa}', 'CorrelativosController@GetCorrelativos');
$router->delete('DeleteCorrelativos/{IdEmpresa}/{IdSucursal}/{IdTipoDocumento}/{Serie}', 'CorrelativosController@DeleteCorrelativos');
$router->get('UpdateEstadoCorrelativos/{IdEmpresa}/{IdSucursal}/{IdTipoDocumento}/{Serie}/{Activo}', 'CorrelativosController@UpdateEstadoCorrelativos');
});



$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'Correlativos_'], 
function () use ($router) {
    $router->post('createCorrelativos', 'CorrelativosController@createCorrelativos');
    $router->put('updateCorrelativos', 'CorrelativosController@updateCorrelativos');
    $router->delete('deleteCorrelativos/{ CodSuc }', 'CorrelativosController@deleteCorrelativos');
    $router->get('getCorrelativos/{ CodEmp }', 'CorrelativosController@getCorrelativos');   
    $router->get('getRBCorrelativos/{ CodEmp }', 'CorrelativosController@getRBCorrelativos');
    $router->get('getSeries/{ CodEmp }/{ IdTipDoc }', 'CorrelativosController@getSeries'); 
    $router->get('getComboTipoDocumentos/{ CodEmp }', 'CorrelativosController@getComboTipoDocumentos');
    $router->get('getTipoDocumento/{ Id }', 'CorrelativosController@getTipoDocumento');
    $router->get('getComboSucursales/{ CodEmp }', 'CorrelativosController@getComboSucursales');  
    $router->get('getNumSerie/{ idCorrelativo }/{ serie }','CorrelativosController@getNumSerie'); 
});

$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'UsuariosEmpresas'], 
function () use ($router) {
    $router->post('createUsuariosEmpresas', 'UsuariosEmpresasController@createUsuariosEmpresas');    
    $router->delete('deleteUsuariosEmpresas/{ IdUsu }/{ IdEmpresa }', 'UsuariosEmpresasController@deleteUsuariosEmpresas');
    $router->get('getUsuariosEmpresas', 'UsuariosEmpresasController@getUsuariosEmpresas');  
    $router->get('getComboUsuarios/{idUsuario}', 'UsuariosEmpresasController@getComboUsuarios');
    $router->get('getEmpresasporUsuario/{ CodUsu }', 'UsuariosEmpresasController@getEmpresasporUsuario');    
});

$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'UsuariosSucursal'], 
function () use ($router) {
    $router->post('createUsuariosSucursal', 'UsuariosSucursalController@createUsuariosSucursal');    
    $router->post('deleteUsuariosSucursal', 'UsuariosSucursalController@deleteUsuariosSucursal');
    $router->get('getUsuariosSucursal/{ CodUsu }/{ CodEmp }', 'UsuariosSucursalController@getUsuariosSucursal');  
    $router->get('getComboUsuarios/{idUsuario}', 'UsuariosSucursalController@getComboUsuarios');
    $router->get('getComboEmpresas/{ CodUsu }', 'UsuariosSucursalController@getComboEmpresas');    
});

$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'Menus'], 
function () use ($router) {
    $router->post('createMenus', 'MenusController@createMenus');
    $router->put('updateMenus', 'MenusController@updateMenus');
    $router->delete('deleteMenus/{ MenuId }', 'MenusController@deleteMenus');
    $router->get('getMenus', 'MenusController@getMenus');  
});

$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'Submenus'], 
function () use ($router) {
    $router->post('createSubmenus', 'SubmenusController@createSubmenus');
    $router->put('updateSubmenus', 'SubmenusController@updateSubmenus');
    $router->delete('deleteSubmenus/{ SubmenuId }', 'SubmenusController@deleteSubmenus');
    $router->get('getSubmenus', 'SubmenusController@getSubmenus');  
    $router->get('getMenus', 'SubmenusController@getMenus');  
});

$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'menuperuser'], 
function () use ($router) {
    $router->post('createMenus', 'MenusporUsuarioController@createMenus');
    $router->put('updateMenus', 'MenusporUsuarioController@updateMenus');
    $router->get('getMenusporUsuario/{ CodUsu }', 'MenusporUsuarioController@getMenusporUsuario');  
    $router->get('permisos/{ CodUsu }', 'MenusporUsuarioController@permisos');  
    $router->get('permisosmenu/{ CodUsu }/{IdModulo}', 'MenusporUsuarioController@permisosmenu'); 
});

$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'submenuperuser'], 
function () use ($router) {
    $router->post('createSubmenus', 'SubmenusporUsuarioController@createSubmenus');
    $router->put('updateSubmenus', 'SubmenusporUsuarioController@updateSubmenus');
    $router->get('permisos/{ CodUsu }/{ IdModulo }', 'SubmenusporUsuarioController@permisos');  
    $router->get('permisossubmenus/{ CodUsu }/{IdModulo}', 'SubmenusporUsuarioController@permisossubmenus');
   
    $router->get('permisos/{ MenuId }', 'SubmenusporUsuarioController@permisosSubMenu');
    // $router->get('getMenusporUsuario/{ CodUsu }', 'SubmenusporUsuarioController@getMenusporUsuario'); 
    $router->get('getMenusporUsuario', 'SubmenusporUsuarioController@getMenus'); 
    // $router->get('permisossubmenusx/{ CodUsu }', 'SubmenusporUsuarioController@permisossubmenusx');
});

$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'EmpresaSucursal'], 
function () use ($router) {
    $router->get('getComboEmpresas/{ Accion }/{ IdUsuario }', 'Logistica\Seguridad\EmpresaSucursalController@getComboEmpresas');    
    $router->get('getComboSucursales/{ Accion }/{ CodEmp }/{ IdUsuario }', 'Logistica\Seguridad\EmpresaSucursalController@getComboSucursales');          
});


$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'Proveedores'], 
function () use ($router) {
    $router->post('createProveedores', 'ProveedoresController@createProveedores');
    $router->put('updateProveedores', 'ProveedoresController@updateProveedores');
    $router->get('deleteProveedores/{CodPro}/{Activo}', 'ProveedoresController@deleteProveedores');
    $router->get('getProveedores/{ CodEmp }', 'ProveedoresController@getProveedores');
    $router->get('getPaises', 'ProveedoresController@getPaises');   
    $router->get('getDepartamentos/{ idPais }', 'ProveedoresController@getDepartamentos'); 
    $router->get('getProvincias/{ idDepa }', 'ProveedoresController@getProvincias'); 
    $router->get('getDistritos/{ idProv }', 'ProveedoresController@getDistritos'); 
});
$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'Permisos'], 
function () use ($router) {
    $router->get('getPermisos/{ CodUsu }/{ Submenunombre }', 'PermisosController@getPermisos');
    $router->get('getPlanModuloUser/{ CodUsu }','PermisosController@getPlanModuloUser');
});

$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'OrdenCompra'], 
function () use ($router) {
    $router->post('createOrden', 'OrdenCompraController@createOrden'); 
    $router->post('insert', 'OrdenCompraController@insert');    
    $router->get('getComboAlmacenes/{ CodEmp }', 'OrdenCompraController@getComboAlmacenes'); 
    $router->get('getComboProveedores/{ CodEmp }', 'OrdenCompraController@getComboProveedores');
    $router->get('getItemList/{ CodEmp }', 'OrdenCompraController@getItemList');      
});


$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'Compras'], 
function () use ($router) {
    $router->get('ListaCompras/{ CodSuc }', 'ComprasController@ListaCompras');
    $router->get('DetalleCompras/{ OrdenCompraId }', 'ComprasController@DetalleCompras');  
});

$router->post('uploadFilesEnterprise/{ idEmpresa }/{ nombreFoto }', 'EmpresaController@uploadFilesEnterprise');

$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'FacturaVenta'], 
function () use ($router) {
    // $router->post('createOrden', 'OrdenCompraController@createOrden'); 
    // $router->post('insert', 'OrdenCompraController@insert');    
    // $router->get('getComboAlmacenes/{ CodEmp }', 'OrdenCompraController@getComboAlmacenes'); 
    $router->get('getComboMedidas/{ CodEmp }', 'FacturaVentaController@getComboMedidas');
    $router->get('getItemList/{ CodEmp }', 'FacturaVentaController@getItemList');      
});

// $router->group(['middleware' => 'headersAuthUser', 'prefix' => 'Venta']),
// function use ($router) {
//     $router->get('getListVenta/{ CodEmp }', 'VentaController@getListVenta'),
// });





$router->post('uploadFilesProduct/{ idProducto }/{ nombreFoto }', 'ImagenesController@uploadFilesProduct');
$router->put('removeFilesProduct/{ idProducto }/{ nombreFoto }', 'ImagenesController@removeFilesProduct');

// Cliente/CreateCliente
$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'Cliente'], 
function () use ($router) {
    $router->post('CreateCliente', 'ClienteController@CreateCliente'); 
    $router->post('InsertClienteDatos/{IdCliente}', 'ClienteController@InsertClienteDatos');
    $router->get('GetListClientes', 'ClienteController@GetListClientes'); 
    $router->get('getCliente/{ Id }', 'ClienteController@getCliente');  
    $router->get('GetClientes', 'ClienteController@GetClientes'); 
    $router->post('updateCliente', 'ClienteController@updateCliente'); 
    $router->post('updateDireccion','ClienteController@updateDireccion');
    $router->get('cambiarEstadoCliente/{IdCliente}/{Activo}','ClienteController@cambiarEstadoCliente');
    $router->get('deleteCliente/{ IdCliente }','ClienteController@deleteCliente');
    $router->get('deleteDatos/{IdDatos}','ClienteController@deleteDatos');
    $router->get('GetDatosCliente/{ idCliente }','ClienteController@GetDatosCliente');
    $router->get('getDocsEntidad', 'ClienteController@getDocsEntidad');   
    $router->get('getDepartamentos', 'ProveedoresController@getDepartamentos'); 
    $router->get('getProvincias/{ idDepa }', 'ProveedoresController@getProvincias'); 
    $router->get('getDistritos/{ idProv }', 'ProveedoresController@getDistritos'); 
    // $router->get('/services/dni/{80638967}', )
    
    Route::get('services/ruc/{number}', 'Api\ServiceController@ruc');
    Route::get('services/dni/{number}', 'Api\ServiceController@dni');
    
    // $router->get('getComboAlmacenes/{ CodEmp }', 'OrdenCompraController@getComboAlmacenes'); 
    // $router->get('getComboProveedores/{ CodEmp }', 'OrdenCompraController@getComboProveedores');
        
});

$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'Ventas'], 
function () use ($router) {
    $router->post('CreateVenta', 'VentasController@CreateVenta');
    $router->post('UpdateVenta','VentasController@UpdateVenta');
    $router->get('GetDataCliente/{IdCliente}','VentasController@GetDataCliente');
    $router->get('GetListVentas/{IdUsu}/{IdEmp}/{IdSuc}', 'VentasController@GetListVentas');
    $router->get('GetDetalleVenta/{IdVentaCab}', 'VentasController@GetDetalleVenta');
    $router->get('GetMedidasProducto/{Id}', 'VentasController@GetMedidasProducto');
    $router->get('GetEmpData/{CodEmp}', 'VentasController@GetEmpData');
    $router->get('GetVenta/{IdVentaCab}', 'VentasController@GetVenta');
    $router->get('GetPagosVenta/{ IdVentaCab }','VentasController@GetPagosVenta');
    $router->get('ListOpciones','VentasController@ListOpciones');

});

$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'Pagos'], 
function () use ($router) {
    $router->post('CreatePagos/{Id}', 'PagosController@CreatePagos');
    $router->post('UpdatePagos/{IdPagosVenta}','PagosController@UpdatePagos');
    $router->get('GetPagos/{IdVenta}', 'PagosController@GetPagos');
   

});

$router->group(['middleware' => 'headersAuthUser', 'prefix' => 'Notas'], 
function () use ($router) {
    // $router->post('CreatePagos/{Id}', 'PagosController@CreatePagos');
    // $router->post('UpdatePagos/{IdPagosVenta}','PagosController@UpdatePagos');
    $router->get('GetTiposNotasCredito', 'NotasController@GetTiposNotasCredito');
   

});



/**TESTING  */
$router->get('/', function () use ($router) {
    return $router->app->version();
    //return 'bienvenido  a Lumen';
});

$router->get('/test', function(Request $request){
    $existheader = $request->header('test');
    if($existheader){
      return response()->json(['Ok' => $existheader], 200);
    }else{
        return 
        response()->json(['error' => 'Unauthorized'], 401);
    }

});

$router->get('/test2', function(Request $request){
    /*$users = DB::table('zg_usuario')
    ->select('logClave')
    ->where('logClave', '=', 'AGdpqez8HGBK1kDJmBTmFqs7a5LY5aqF_plwitgOA5lB-nEtMR')
    ->get();*/

   // $users = DB::table('zg_usuario')->paginate(1);


   // return response()->json([$users, $users->total() ], 200);
});
