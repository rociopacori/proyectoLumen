-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-07-2019 a las 16:26:58
-- Versión del servidor: 10.1.37-MariaDB
-- Versión de PHP: 7.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `angular2019`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Lo_Man_lo_propiedades` (IN `_Accion` VARCHAR(4), IN `_IdEmpresa` VARCHAR(100), IN `_IdPropiedad` VARCHAR(6), IN `_Descripcion` VARCHAR(300), IN `_Activo` TINYINT)  Begin
Case _Accion
    When 'M01' Then
        Insert into lo_propiedades(IdEmpresa,IdPropiedad,Descripcion,Activo)
        Values(_IdEmpresa,_IdPropiedad,_Descripcion,_Activo);
    When 'M02' Then
        Update lo_propiedades Set
            Descripcion=_Descripcion,
            Activo=_Activo
        Where IdEmpresa=_IdEmpresa AND IdPropiedad=_IdPropiedad ;
    When 'M03' Then
        Delete From lo_propiedades 
        Where IdEmpresa=_IdEmpresa AND IdPropiedad=_IdPropiedad ;
    When 'M04' Then
        Update lo_propiedades Set
            Activo=_Activo
        Where IdEmpresa=_IdEmpresa AND IdPropiedad=_IdPropiedad ;
    When 'S01' Then
        Select *
        From lo_propiedades
        Where IdEmpresa=_IdEmpresa
        Order By 2;
End Case;
End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Lo_Man_zg_correlativos` (IN `_Accion` VARCHAR(4), IN `_IdEmpresa` VARCHAR(100), IN `_IdSucursal` VARCHAR(6), IN `_IdTipoDocumento` VARCHAR(6), IN `_Serie` VARCHAR(4), IN `_DocNro` INT(11), IN `_Defecto` TINYINT(4), IN `_ImprimirEn` VARCHAR(200))  Begin
Case _Accion
    When 'M01' Then
        Insert into zg_correlativos(IdEmpresa,IdSucursal,IdTipoDocumento,Serie,DocNro,Defecto,ImprimirEn)
        Values(_IdEmpresa,_IdSucursal,_IdTipoDocumento,_Serie,_DocNro,_Defecto,_ImprimirEn);
    When 'M02' Then
        Update zg_correlativos Set
            DocNro=_DocNro,
            Defecto=_Defecto,
            ImprimirEn=_ImprimirEn
        Where IdEmpresa=_IdEmpresa AND IdSucursal=_IdSucursal AND IdTipoDocumento=_IdTipoDocumento AND Serie=_Serie ;
    When 'M03' Then
        Delete From zg_correlativos 
        Where IdEmpresa=_IdEmpresa AND IdSucursal=_IdSucursal AND IdTipoDocumento=_IdTipoDocumento AND Serie=_Serie ;
    When 'M04' Then
        Update zg_correlativos Set
            Activo=_Activo
        Where IdEmpresa=_IdEmpresa AND IdSucursal=_IdSucursal AND IdTipoDocumento=_IdTipoDocumento AND Serie=_Serie ;
    When 'S01' Then
        Select *
        From zg_correlativos
        Where IdEmpresa=_IdEmpresa
        Order By 2;
End Case;
End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Lo_Man_zg_zmodulos` (IN `_Accion` VARCHAR(4), IN `_IdZmodulo` INT(11), IN `_Codigo` VARCHAR(2), IN `_Descripcion` VARCHAR(50))  Begin
Case _Accion
    When 'M01' Then
        Insert into zg_zmodulos(IdZmodulo,Codigo,Descripcion)
        Values(_IdZmodulo,_Codigo,_Descripcion);
    When 'M02' Then
        Update zg_zmodulos Set
            Codigo=_Codigo,
            Descripcion=_Descripcion
        Where IdZmodulo=_IdZmodulo ;
    When 'M03' Then
        Delete From zg_zmodulos 
        Where IdZmodulo=_IdZmodulo ;
    When 'M04' Then
        Update zg_zmodulos Set
            Activo=_Activo
        Where IdZmodulo=_IdZmodulo ;
    When 'S01' Then
        Select *
        From zg_zmodulos
        Order By 2;
End Case;
End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Man_lo_lineas` (IN `_Accion` VARCHAR(4), IN `_IdEmpresa` VARCHAR(100), IN `_IdAlmacen` VARCHAR(6), IN `_IdLinea` VARCHAR(6), IN `_Descripcion` VARCHAR(50), IN `_Activo` TINYINT)  BEGIN
 declare vIdLinea int; 
 
	Case _Accion

		When 'M01' Then
			set vIdLinea=0;
			IF EXISTS (Select IdLinea from lo_lineas) THEN
			   set vIdLinea=(Select Max(IdLinea) + 1 from lo_lineas);		
			ELSE
			   set vIdLinea = 1;
	    	END IF;
	    	
			Insert Into lo_lineas (IdEmpresa,IdAlmacen,IdLinea,Descripcion,Activo)
		Values (_IdEmpresa,_IdAlmacen,vIdLinea,_Descripcion,1);
		
		When 'M02' Then
			Update lo_lineas Set
				Descripcion=_Descripcion,
				IdAlmacen=_IdAlmacen                
			Where IdEmpresa= _IdEmpresa and IdLinea= _IdLinea;
			
		When 'M03' Then
			Update lo_lineas Set
				Activo = _Activo               
			Where IdEmpresa= _IdEmpresa and IdAlmacen=_IdAlmacen and IdLinea=_IdLinea;
			
		When 'M04' Then
			Delete From lo_lineas 
			Where IdEmpresa= _IdEmpresa and IdAlmacen=_IdAlmacen and IdLinea=_IdLinea;
			
		When 'S01' Then
				Select L.IdLinea,L.Descripcion,L.IdAlmacen,A.Descripcion as DesAlmacen, L.IdPropiedad1, PR1.Descripcion as DesPropiead1 ,PR2.IdPropiedad, PR2.Descripcion as DesPropiead2, L.Activo
        		From lo_lineas L 
            INNER JOIN lo_almacenes A ON L.IdAlmacen=A.IdAlmacen and L.IdEmpresa = A.IdEmpresa
            inner join lo_propiedades PR1 ON L.IdPropiedad1= PR1.IdPropiedad
            left join lo_propiedades PR2 on L.IdPropiedad2 = PR2.IdPropiedad
            WHERE L.IdEmpresa= _IdEmpresa 
				ORDER BY L.IdLinea DESC; 	
            
		When 'S02' Then
			Select IdAlmacen AS Id, Descripcion AS itemName FROM lo_almacenes
            WHERE IdEmpresa= _IdEmpresa;
            
		When 'S03' Then
			Select IdPropiedad AS Id, Descripcion AS itemName FROM lo_propiedades
            WHERE IdEmpresa= _IdEmpresa;
	End Case;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Man_lo_sublineas` (IN `_Accion` VARCHAR(4), IN `_IdEmpresa` VARCHAR(100), IN `_IdLinea` VARCHAR(6), IN `_IdSubLinea` VARCHAR(6), IN `_Descripcion` VARCHAR(50), IN `_Activo` TINYINT)  BEGIN
declare vIdSubLinea int;
 	If _IdEmpresa = null or 
		_IdLinea = null  or 
	 	_IdSubLinea = null or 
		_Descripcion = null  or 
		_Activo = null 
	THEN
		SET _IdEmpresa = null; 
	 	SET _IdLinea = null;
		SET _IdSubLinea = null; 
		SET _Descripcion = null; 
		SET _Activo = null;
	ELSE
		Case _Accion
			When 'M01' Then
					set vIdSubLinea =0;
					IF EXISTS (SELECT IdSubLinea from lo_sublineas) then
						set vIdSubLinea = (select max(IdSubLinea) + 1 from lo_sublineas);
					ELSE
						set vIdSubLinea = 1;
					END IF;
				Insert Into lo_sublineas (IdEmpresa,IdLinea,IdSubLinea,Descripcion,Activo)
				Values (_IdEmpresa,_IdLinea,vIdSubLinea,_Descripcion,1);
				
			When 'M02' Then
				Update lo_sublineas Set
					IdLinea=_IdLinea,
					Descripcion=_Descripcion,
					Activo=_Activo
				Where IdSubLinea=_IdSubLinea;
			When 'M03' Then
				Delete From lo_sublineas Where IdLinea=_IdLinea;
			When 'S01' Then
				Select L.IdSubLinea,L.IdEmpresa,L.IdLinea, F.Descripcion as Familia,L.Descripcion,L.Activo
				From lo_sublineas L 
				inner join lo_lineas F  
				where L.IdLinea = F.IdLinea and L.IdEmpresa = _IdEmpresa;
				
			When 'S03' Then
				Select IdLinea AS Id, Descripcion AS itemName
				From lo_lineas 
            WHERE  IdEmpresa= _IdEmpresa;
            -- IdAlmacen=_IdAlmacen  AND
            
		--	When 'S04' Then
			--	Select IdAlmacen AS Id,Descripcion AS Name
			--	From zg_almacenes where IdEmpresa = _IdEmpresa;            
		End Case;
	End If;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Man_lo_tipodocumentos` (IN `_Accion` VARCHAR(4), IN `_IdEmpresa` VARCHAR(100), IN `_IdTipoDocumento` VARCHAR(6), IN `_Descripcion` VARCHAR(50), IN `_CodigoSunat` VARCHAR(2), IN `_Configuracion` VARCHAR(20), IN `_Activo` TINYINT)  BEGIN
Declare vIdTipoDocumento int; 

 	If _IdEmpresa = null or 
	 	_IdTipoDocumento = null or 
		_Descripcion = null or 
		_Configuracion = null or 
		_CodigoSunat = null or 
		_Activo = null  
	THEN
		SET _IdEmpresa = null;
 		SET _IdTipoDocumento = null; 
		SET _Descripcion = null; 
		SET _Configuracion = null; 
		SET _CodigoSunat = null; 
		SET _Activo = null; 
	ELSE
		Case _Accion
			When 'M01' Then
			set vIdTipoDocumento=0;
			IF EXISTS (Select IdTipoDocumento from lo_tipodocumentos) THEN
			   set vIdTipoDocumento=(Select Max(IdTipoDocumento) + 1 from lo_tipodocumentos);		
			ELSE
			   set vIdTipoDocumento = 1;
	    	END IF;
			
			Insert Into lo_tipodocumentos (IdEmpresa,IdTipoDocumento,Descripcion,CodigoSunat,Configuracion,Activo)
					Values (_IdEmpresa,vIdTipoDocumento,_Descripcion,_CodigoSunat,_Configuracion,1);
						
			When 'M02' Then
				Update lo_tipodocumentos Set
					IdEmpresa=_IdEmpresa,
					Descripcion=_Descripcion,
					CodigoSunat=_CodigoSunat,
					Configuracion =_Configuracion,
					Activo=_Activo
				Where IdTipoDocumento=_IdTipoDocumento;
			When 'M03' Then
				Delete From lo_tipodocumentos 
				Where IdTipoDocumento=_IdTipoDocumento;
			
			When 'M04' Then
				Update lo_tipodocumentos Set
						Activo=_Activo
				Where IdTipoDocumento=_IdTipoDocumento;	
				
			When 'S01' Then
				Select IdEmpresa,IdTipoDocumento,Descripcion,CodigoSunat,Configuracion,Activo
				From lo_tipodocumentos 
				where IdEmpresa = _IdEmpresa;            
		End Case;
	End If;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Man_zg_almacenes` (IN `_Accion` VARCHAR(4), IN `_IdEmpresa` VARCHAR(100), IN `_IdAlmacen` VARCHAR(6), IN `_Descripcion` VARCHAR(50), IN `_DescripcionCorta` VARCHAR(20), IN `_Responsable` VARCHAR(20), IN `_Activo` TINYINT)  BEGIN
declare vIdAlmacen int;

 	If _IdEmpresa = null or 
	 	_IdAlmacen = null or 
		_Descripcion = null  or 
		_DescripcionCorta = null Or
		_Responsable=Null Or
		_Activo=Null
	THEN
		SET _IdEmpresa = null;
	 	SET _IdAlmacen = null;
		SET _Descripcion = null;
		SET _DescripcionCorta = null;
		SET _Responsable=Null;
		SET _Activo=Null;
	ELSE
		Case _Accion
			When 'M01' Then
			set vIdAlmacen =0;
			
				IF EXISTS (Select IdAlmacen from lo_almacenes where IdEmpresa=_IdEmpresa) THEN
			   set vIdAlmacen=(Select Max(IdAlmacen) + 1 from lo_almacenes where IdEmpresa=_IdEmpresa);		
			ELSE
			   set vIdAlmacen = 1;
	    	END IF;
	    	
				Insert Into lo_almacenes (IdEmpresa,IdAlmacen,Descripcion,DescripcionCorta,Responsable,Activo)
			Values (_IdEmpresa,vIdAlmacen,_Descripcion,_DescripcionCorta,_Responsable,_Activo);
			
			When 'M02' Then
				Update lo_almacenes Set
					IdAlmacen=_IdAlmacen,
					Descripcion=_Descripcion,
					DescripcionCorta=_DescripcionCorta,
					Responsable=_Responsable,
					Activo=_Activo
				Where IdEmpresa=_IdEmpresa And IdAlmacen=_IdAlmacen;
				
			When 'M03' Then
				Delete From lo_almacenes 
				Where  IdEmpresa=_IdEmpresa And IdAlmacen=_IdAlmacen; 
			
			When 'M04' Then
				Update lo_almacenes set
					Activo= _Activo 
				Where  IdEmpresa=_IdEmpresa And IdAlmacen=_IdAlmacen; 
				
			When 'S01' Then			
				Select IdEmpresa,IdAlmacen,TRIM(Descripcion) AS Descripcion,DescripcionCorta,Responsable, Activo    				
				From lo_almacenes where IdEmpresa = _IdEmpresa ORDER BY IdAlmacen DESC;
				
			when 'S02' Then
			select (Max(IdAlmacen) +1) as Id  from lo_almacenes Where IdEmpresa=_IdEmpresa;
					
		--	When 'S03' Then
			--	Select IdEmpresa,IdAlmacen,Descripcion,DescripcionCorta,Responsable,Activo
			--	From lo_almacenes ORDER BY IdAlmacen DESC;
			
		End Case;
	End If;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Man_zg_empresas` (IN `_Accion` VARCHAR(6), IN `_IdUsuario` VARCHAR(100), IN `_IdEmpresa` VARCHAR(100), IN `_Nombre` VARCHAR(150), IN `_NombreComercial` VARCHAR(150), IN `_NombreCorto` VARCHAR(6), IN `_Direccion` VARCHAR(100), IN `_Ruc` VARCHAR(20), IN `_Telefono` VARCHAR(20), IN `_Email` VARCHAR(50), IN `_WebPage` VARCHAR(100), IN `_Activo` TINYINT, IN `_Imagen01` VARCHAR(500), IN `_Imagen02` VARCHAR(500), IN `_Imagen03` VARCHAR(500), IN `_Imagen04` VARCHAR(500), IN `_Ubigeo` VARCHAR(6))  BEGIN

declare maxId int;
declare vIdEmpresa varchar(100);
declare vIdUsuario varchar(100);

 
	Case _Accion
			WHEN 'M01' Then
				SET maxId =0;
				SET vIdUsuario ='';
				IF EXISTS (SELECT IdEmpresa from zg_empresas) THEN
				   SET maxId = (SELECT CAST((SELECT SUBSTRING( Max(IdEmpresa) , 2, 2) AS ExtractString FROM zg_empresas) AS SIGNED) +1 );
				ELSE
				   SET maxId = 1;
		    	END IF;
		    	
		    		IF(maxId < 20)THEN
		    			SET vIdEmpresa = CONCAT(_IdUsuario,'-',_Ruc);
		    		ELSE
					   SET vIdEmpresa = CONCAT('E',maxId );
		    		END IF;
		    			
					Insert Into zg_empresas (IdEmpresa,Nombre,NombreComercial,NombreCorto,Direccion,Ruc,Telefono,Email,WebPage,Activo,Imagen01,Imagen02,Imagen03,Imagen04,Ubigeo)
					Values (_IdEmpresa,_Nombre,_NombreComercial,_NombreCorto,_Direccion,_Ruc,_Telefono,_Email,_WebPage,1,_Imagen01,_Imagen02,_Imagen03,_Imagen04,_Ubigeo);
					
					IF( SELECT LENGTH(_IdEmpresa) - LENGTH(REPLACE(_IdEmpresa, '-', '')) = 1) THEN					
						SET vIdUsuario = (SELECT SUBSTRING_INDEX(_IdEmpresa, '-', 1));					
					ELSE 
						SET vIdUsuario = (SELECT SUBSTRING_INDEX(_IdEmpresa, '-', 2));	
					END IF;
					
					-- Registra Usuario-Empresas
					Insert Into zg_usuariosempresas(IdUsuario,IdEmpresa)
					Values(vIdUsuario,_IdEmpresa);
					
				-- Registra Sucursales...		
					Insert Into zg_sucursales(IdEmpresa,IdSucursal,Descripcion,CUO,Direccion,Telefono,Email,Ubigeo,Principal, Activo,Responsable)
					Values(_IdEmpresa,'001','PRINCIPAL','PRI','','...','','000000',1,1,'ALMACENERO');
					
					-- Registra Usuario-Sucursaless
					Insert Into zg_usuariossucursales(IdEmpresa,IdUsuario,IdSucursal)
					Values(_IdEmpresa,vIdUsuario,'001');
			
			
			WHEN 'M02' Then
				Update zg_empresas Set
					Nombre=_Nombre,
					NombreComercial=_NombreComercial,
					NombreCorto=_NombreCorto,
					Direccion=_Direccion,
					Ruc=_Ruc,
					Telefono=_Telefono,
					Email=_Email,
					WebPage=_WebPage,
					Activo=_Activo,
					Imagen01=_Imagen01,
					Imagen02=_Imagen02,
					Imagen03=_Imagen03,
					Imagen04=_Imagen04,
					Ubigeo=_Ubigeo
				Where IdEmpresa=_IdEmpresa;
			WHEN 'M03' Then
				Delete From zg_empresas Where IdEmpresa=_IdEmpresa;
				
			WHEN 'M04' Then
				update zg_empresas Set 
					Activo = _Activo
				Where IdEmpresa=_IdEmpresa;
				
			WHEN 'S01' Then
				Select IdEmpresa,Nombre,NombreComercial,NombreCorto,Direccion,Ruc,Telefono,Email,WebPage,Activo,Imagen01,Imagen02,Imagen03,Imagen04,Ubigeo
				From zg_empresas 
				where substring(IdEmpresa,1,28) = substring(_IdEmpresa,1,28);
				
			WHEN 'S02' THEN
				select Imagen01,Imagen02,Imagen03,Imagen04 
					from zg_empresas 
					WHERE IdEmpresa = _IdEmpresa;
			WHEN 'M05' Then
				SELECT COUNT(*) From zg_empresas;
		End Case;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Man_zg_empresasucursal` (IN `_Accion` VARCHAR(6), IN `_IdUsuario` VARCHAR(100), IN `_IdEmpresa` VARCHAR(100))  BEGIN
 	If _IdUsuario = null or 
	 	_IdEmpresa = null 
	THEN
		SET _IdUsuario = null;
 		SET _IdEmpresa = null;       
  	ELSE
  	
	Case _Accion			
			
		When 'S01' Then
		-- S01 y S02 Lista para otorgar permisos de empresas y sucursales 
			Select Z.IdEmpresa AS Id,E.Nombre AS Name, E.NombreComercial as NomComercial , E.Ruc           
				From zg_usuariosempresas Z 
				INNER JOIN zg_empresas E ON Z.IdEmpresa=E.IdEmpresa
            WHERE Z.IdUsuario = Substring(_IdUsuario,1,28);            
		
		When 'S02' Then
			Select Z.IdSucursal AS Id,E.Descripcion AS Name                     
				From zg_usuariossucursales Z 
				INNER JOIN zg_sucursales E ON Z.IdSucursal=E.IdSucursal and Z.IdEmpresa =E.IdEmpresa
            WHERE Z.IdUsuario=Substring(_IdUsuario,1,28) 
            AND Z.IdEmpresa=_IdEmpresa;
		-- S03 y S04  Para lista de empresas y sucursales con permisos para el usuario
		When 'S03' Then
			Select Z.IdEmpresa AS Id,E.Nombre AS Name, E.NombreComercial as NomComercial , E.Ruc           
				From zg_usuariosempresas Z 
				INNER JOIN zg_empresas E ON Z.IdEmpresa=E.IdEmpresa and Z.IdUsuario =_IdUsuario;            
		
		When 'S04' Then
			Select Z.IdSucursal AS Id,E.Descripcion AS Name                     
				From zg_usuariossucursales Z 
				INNER JOIN zg_sucursales E ON Z.IdSucursal=E.IdSucursal and Z.IdEmpresa =E.IdEmpresa
            WHERE Z.IdUsuario=_IdUsuario 
            AND Z.IdEmpresa=_IdEmpresa;
            
End Case;
	End If;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Man_zg_Menuusuario` (IN `_Accion` VARCHAR(4), IN `_IdModulo` INT, IN `_IdUsuario` VARCHAR(100), IN `_IdMenu` VARCHAR(4), IN `_Activo` INT)  BEGIN
DECLARE TEMPx INT;
DECLARE TEMPxx INT;
 	
				Case _Accion
			When 'S02' Then
SELECT M.IdMenu, M.Nombre AS NombreMenu,0 as Habilitado 
	FROM zg_zmenus M 
	WHERE M.SubMenu = 0 AND IdModulo = _IdModulo
	AND M.IdMenu NOT IN ( select (Substring(IdMenu,1,2)) from zg_usuariosmenus where IdUsuario = _IdUsuario group by (Substring(IdMenu,1,2))) -- and (LENGTH(IdMenu)=2))
      UNION ALL
SELECT M.IdMenu, M.Nombre AS NombreMenu , UM.Activo AS Habilitado
	      FROM zg_zmenus M 
			INNER JOIN zg_usuariosmenus UM ON M.IdMenu = (Substring(UM.IdMenu,1,2)) and M.IdModulo = _IdModulo
	      WHERE UM.IdUsuario = _IdUsuario group by (Substring(UM.IdMenu,1,2))
			order by IdMenu asc;
	
End Case;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Man_zg_Submenuusuario` (IN `_Accion` VARCHAR(4), IN `_IdModulo` INT, IN `_IdUsuario` VARCHAR(100), IN `_Leer` TINYINT, IN `_Agregar` TINYINT, IN `_Editar` TINYINT, IN `_Eliminar` TINYINT, IN `_Imprimir` TINYINT, IN `_IdMenu` VARCHAR(4))  BEGIN
	DECLARE TEMPx INT;
	Declare vIdSubmenu int; 
 
		Case _Accion
		
			When 'M01' Then	    	
				Insert Into zg_usuariosmenus (IdUsuario,Idmenu,Accion,Activo)
				Values (_IdUsuario,_IdMenu,concat(_Agregar,_Editar,_Eliminar,_Imprimir),1);             
				
			When 'M02' Then
	        	IF (_Agregar = 0 and _Editar =0 and _Eliminar=0 and _Imprimir=0 ) THEN
					Update zg_usuariosmenus Set
						Accion = '0000',
						Activo = 0   
					Where IdMenu=_IdMenu And IdUsuario=_IdUsuario;
		      ELSE
					Update zg_usuariosmenus Set
						-- Leer=_Leer,
						Accion = concat(_Agregar,_Editar,_Eliminar,_Imprimir),
						Activo =1
					Where IdMenu=_IdMenu And IdUsuario=_IdUsuario;
	         END IF;
			When 'S01' Then
			-- Lista para configurar Permisos a los Usuarios	
			SELECT UM.IdMenu as IdMenuUser, UM.IdMenu, M.Nombre As NombreSubMenu, 
					 -- (select CONVERT(SUBSTRING( UM.Accion, 1, 1),UNSIGNED INTEGER)) as Ver, 
					(select CONVERT(SUBSTRING( UM.Accion, 1, 1),UNSIGNED INTEGER)) as Agregar, 
					(select CONVERT(SUBSTRING( UM.Accion, 2, 1),UNSIGNED INTEGER)) as Editar, 
					(select CONVERT(SUBSTRING( UM.Accion, 3, 1),UNSIGNED INTEGER)) as Eliminar, 
					(select CONVERT(SUBSTRING( UM.Accion, 4, 1),UNSIGNED INTEGER)) as Imprimir
				FROM zg_usuariosmenus UM 
				Inner Join zg_zMenus M On M.IdMenu = UM.IdMenu 
				WHERE UM.IdUsuario = _IdUsuario AND M.IdModulo = _IdModulo
			UNION ALL
				SELECT 0 as IdMenuUser, M.IdMenu, M.Nombre As NombreSubMenu, 0 as Agregar,0 AS Editar, -- 0 as Ver,
						0 AS Eliminar, 0 AS Imprimir
					FROM zg_zMenus M 
					WHERE M.IdModulo = _IdModulo  
					AND M.IdMenu NOT IN (SELECT IdMenu FROM zg_usuariosmenus WHERE IdUsuario =_IdUsuario)
					ORDER BY IdMenu ASC ;	
				
			When 'S02' Then
				SELECT SM.IdMenu AS Id, M.Nombre AS Name
	            FROM zg_submenus SM 
	            INNER JOIN zg_submenususuarios SU On SU.IdSubMenu=SM.IdSubMenu
					INNER JOIN zg_menus M ON SM.IdMenu=M.IdMenu
	            					     
	            WHERE SU.IdUsuario=_IdUsuario Group by Id;	
			When 'S03' Then
			 SELECT M.IdMenu, M.Nombre AS Nombre ,0 as Habilitado 
					FROM zg_zmenus M 
					WHERE M.SubMenu = 1 AND IdModulo = _IdModulo 
					AND M.IdMenu NOT IN ( select IdMenu from zg_usuariosmenus where IdUsuario = _IdUsuario)
			UNION ALl
			SELECT M.IdMenu, M.Nombre AS Nombre , UM.Activo AS Habilitado
		      FROM zg_zmenus M 
				INNER JOIN zg_usuariosmenus UM ON M.IdMenu = UM.IdMenu
		      WHERE M.IdModulo = _IdModulo and UM.IdUsuario = _IdUsuario and M.SubMenu = 1
				order by IdMenu asc;
				
			When 'S04' Then
				Select IdMenu As Id,Concat(Codigo,' - ',Nombre) As Name From zg_menus;
				
			When 'S05' Then
				SELECT M.Codigo As CodigoMenu,M.Nombre As NombreMenu,S.Codigo As CodigoSubMenu,S.Nombre As NombreSubMenu
				FROM  zg_submenus S Inner Join zg_Menus M On M.IdMenu=S.IdMenu
				WHERE  S.IdMenu= _IdMenu And M.IdModulo=2;
				
			when 'S06' then
				SELECT S.IdSubMenu, M.IdMenu, M.Nombre, SU.Leer AS Ver 
				FROM zg_submenus S 
				INNER JOIN zg_submenususuarios SU 
				INNER JOIN zg_menus M
				ON S.IdSubMenu=SU.IdSubMenu WHERE SU.IdUsuario = _IdUsuario and  M.IdMenu= S.IdMenu GROUP BY M.IdMenu 
			UNION ALL SELECT 0 AS IdSubMenu ,M.IdMenu, M.Nombre, 0 AS Leer 
				FROM zg_menus M WHERE M.IdMenu NOT IN (SELECT S.IdMenu FROM zg_submenususuarios SU 
				INNER JOIN  zg_submenus S ON SU.IdSubMenu=S.IdSubMenu WHERE SU.IdUsuario=_IdUsuario) 
				; 
			
		--	when 'S07' then
		--	SELECT M.IdMenu, M.Nombre AS NombreMenu , UM.Activo AS Habilitado
	     --       FROM zg_zmenus M 
		--			INNER JOIN zg_usuariosmenus UM ON UM.IdMenu = M.IdMenu
	     --       WHERE UM.IdUsuario = _IdUsuario and M.SubMenu = 0 ; 
			
		End Case;
		
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Man_zg_sucursales` (IN `_Accion` VARCHAR(4), IN `_IdUsuario` VARCHAR(100), IN `_IdEmpresa` VARCHAR(100), IN `_IdSucursal` VARCHAR(3), IN `_Descripcion` VARCHAR(50), IN `_CUO` VARCHAR(3), IN `_Direccion` VARCHAR(60), IN `_Telefono` VARCHAR(20), IN `_Email` VARCHAR(50), IN `_Ubigeo` VARCHAR(6), IN `_Principal` TINYINT, IN `_Activo` TINYINT, IN `_Responsable` VARCHAR(50))  BEGIN
declare NroSuc int;
declare vIdSucursal varchar(3);

 
		Case _Accion
			When 'M01' Then
			set NroSuc =0;
			
			IF EXISTS (Select IdSucursal from zg_sucursales) THEN
			   set NroSuc=(Select Max(IdSucursal) + 1 from zg_sucursales where IdEmpresa = _IdEmpresa);		
			ELSE
			   set NroSuc = 1;
	    	END IF;
	    	
	    	if NroSuc <10 then
	    		set vIdSucursal = concat('00',NroSuc);
	    	else
	    		if(NroSuc<100) then
	    			set vIdSucursal = concat('0',NroSuc);
				else
					set vIdSucursal = NroSuc;
				end if;
			end if;
			
				Insert Into zg_sucursales (IdEmpresa,IdSucursal,Descripcion,CUO,Direccion,Telefono,Email,Ubigeo,Principal,Activo,Responsable)
				Values (_IdEmpresa,vIdSucursal,_Descripcion,_CUO,_Direccion,_Telefono,_Email,_Ubigeo,_Principal,1,_Responsable);
			--	Set vIdSucursal=LAST_INSERT_ID();
				Insert Into zg_usuariossucursales (IdUsuario,IdSucursal,IdEmpresa)
				Values (_IdUsuario,vIdSucursal,_IdEmpresa);
			
			When 'M02' Then
				Update zg_sucursales Set
					 	IdEmpresa=_IdEmpresa,
						Descripcion=_Descripcion,
						CUO=_CUO,
						Direccion=_Direccion, 
						Telefono=_Telefono,
						Email=_Email,
						Ubigeo=_Ubigeo,
						Principal =_Principal,
						Activo=_Activo,
						Responsable=_Responsable
				Where IdSucursal=_IdSucursal And IdEmpresa=_IdEmpresa; 
				
			When 'M03' Then
				Delete From zg_sucursales 
				Where IdEmpresa =_IdEmpresa and IdSucursal=_IdSucursal; 
				
			When 'S01' Then
				-- Lista de Sucursales por empresa
					Select S.IdEmpresa,S.IdSucursal,S.Descripcion,S.CUO,S.Direccion,S.Telefono,S.Email,S.Ubigeo,S.Principal,S.Activo,S.Responsable            
						From zg_sucursales S
					--	INNER JOIN zg_usuariossucursales UZ ON S.IdSucursal = UZ.IdSucursal and S.IdEmpresa = UZ.IdEmpresa
						-- INNER JOIN zg_zonas Z ON S.IdZona = Z.IdZona
           		 WHERE S.IdEmpresa = _IdEmpresa AND S.Activo = 1; -- AND UZ.IdUsuario=_IdUsuario ;
	            
			When 'S02' Then
					Select IdEmpresa,IdSucursal,Descripcion,CUO,Direccion,Telefono,Email,Ubigeo,Principal,Activo,Responsable
					From zg_sucursales 
					ORDER BY IdSucursal DESC;
			When 'S03' Then
					Select IdEmpresa AS Id,Nombre AS Name
					From zg_empresas;
		--	When 'S04' Then
				--	Select IdZona AS Id, Descripcion AS Name
				--	From zg_zonas where IdEmpresa = _IdEmpresa;
		End Case;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Man_zg_ubigeo` (IN `_Accion` VARCHAR(4), IN `_IdUbigeo` VARCHAR(6))  BEGIN

	CASE _Accion
		WHEN 'S01' THEN
				SELECT (substring(IdUbigeo,1,2)) as Id, Departamento AS itemName
					FROM zg_ubigeo  
					GROUP by Departamento;
		
		WHEN 'S02' THEN
			
				SELECT (substring(IdUbigeo,1,4)) as Id, Provincia AS itemName
					FROM zg_ubigeo  
					WHERE  (substring(IdUbigeo,1,2)) = _IdUbigeo
					GROUP BY Provincia;
						
		WHEN 'S03' THEN
				SELECT IdUbigeo as Id , Distrito AS itemName
					FROM zg_ubigeo  
					WHERE  (substring(IdUbigeo,1,4)) = _IdUbigeo;

	END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Man_zg_usuarioplan` (IN `_Accion` VARCHAR(4), IN `_IdUsuario` VARCHAR(100), IN `_IdPlan` INT, IN `_Fecha` DATE, IN `_Hora` DATETIME, IN `success_` VARCHAR(50))  BEGIN
	IF _IdUsuario = null or 	
	 	_IdPlan = null or 
	 	_Fecha = null or 
		_Hora = null 
	THEN
		SET _IdUsuario = null; 	
	 	SET _IdPlan = null; 
	 	SET _Fecha = null; 
		SET _Hora = null ;
	ELSE
	Case _Accion
		When 'M01' Then
			INSERT INTO zg_usuariosplanes(IdUsuario,IdPlan,Fecha,Hora)
			VALUES(_IdUsuario,_IdPlan, DATE_FORMAT(_Fecha, '%Y-%m-%d'), DATE_FORMAT(_Hora, '%H:%i:%s'));
            
			SET success_ = 'Plan del usuario creado';
		When 'M02' Then
			Update zg_usuariosplanes Set
				IdPlan=_IdPlan
			Where Idusuario = _IdUsuario;
			
		When 'M03' Then
			Delete From zg_usuariosplanes Where IdUsuario=_IdUsuario;
			
		When 'S01' Then 
			Select Up.IdUsuario, U.Nombre, P.IdPlan, P.IdModulo, P.Descripcion, P.NroEmpresas, P.NroUsuarios 
				From zg_usuariosplanes Up 	
				Inner Join zg_zplanes P On Up.IdPlan=P.IdPlan
				Inner Join zg_zusuarios U On Up.IdUsuario=U.IdUsuario
				Where Up.IdUsuario=Substring(_IdUsuario,1,28);
		
	End Case;	
    
    Select success_;
	
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Man_zg_usuarios` (IN `_Accion` VARCHAR(4), IN `_IdUsuario` VARCHAR(100), IN `_IdUsuarioAuth` VARCHAR(50), IN `_Nombre` VARCHAR(30), IN `_LogLogin` VARCHAR(50), IN `_LogClave` VARCHAR(400), IN `_Estado` INT, IN `_Foto` VARCHAR(1000), IN `_IdUsuarioAuthKey` VARCHAR(50), IN `_FechaRegistro` DATE, IN `_PeriodoIniFac` INT, IN `_PeriodoFinFac` INT, IN `_Telefono` VARCHAR(20), IN `_Activo` TINYINT, IN `success_` VARCHAR(50))  Begin	
-- Variables..
Declare NroUsuarios int; 
Declare vIdUsuario varchar(100); 
Declare vIdEmpresa varchar(120);
Declare vIdZona int;
Declare vIdSucursal int;

If _IdUsuario = null or 
	   _IdUsuarioAuth = null or
	 	_Nombre = null or 
	 	_LogLogin = null or 
		_LogClave = null or 
		_Estado = null or
		_Foto = null or
		_IdUsuarioAuthKey = null or
		_FechaRegistro = null or
		_PeriodoIniFac = null or
		_PeriodoFinFac = null or
		_Telefono = null 
	THEN
		SET _IdUsuario = null; 	
      SET _IdUsuarioAuth = null;
	 	SET _Nombre = null;
	 	SET _LogLogin = null; 
		SET _LogClave = null;
		SET _Estado = null;
		SET _Foto = null;
		SET _IdUsuarioAuthKey = null;
		SET _FechaRegistro = null;
		SET _PeriodoIniFac = null;
		SET _PeriodoFinFac = null;
		SET _Telefono = null;
ELSE	
	Case _Accion
		When 'M01' Then
			-- REGISTRO DE USUARIO...
			-- Limpia la variable			
	    	set vIdEmpresa= (concat(_IdUsuarioAuth,'-','12345678911'));
	    	
			Insert Into zg_zusuarios(IdUsuario,IdUsuarioAuth, Nombre,LogLogin,LogClave,Estado,Foto,IdUsuarioAuthKey,FechaRegistro,PeriodoIniFac,PeriodoFinFac,Telefono,Activo)
			Values(_IdUsuarioAuth,_IdUsuarioAuth, _Nombre,_LogLogin,_LogClave,_Estado,_Foto,_IdUsuarioAuthKey,DATE_FORMAT(_FechaRegistro, '%Y-%m-%d %H:%i:%s'),_PeriodoIniFac,_PeriodoFinFac,_Telefono,1);
			
			
			
			-- Regsitra Empresas 
			Insert Into zg_empresas(IdEmpresa,Nombre,NombreComercial,NombreCorto,Direccion,Ruc,Telefono,Email,WebPage,Activo,Imagen01,Imagen02,Imagen03,Imagen04,Ubigeo) 
			Values(vIdEmpresa,'Empresa BASE','Empresa BASE','EB','direccion 169','12345678911','123445','empresa@email.com','www.empresa.com',1,null,null,null,null,'');
				
			-- Registra Usuario-Empresas
			Insert Into zg_usuariosempresas(IdUsuario,IdEmpresa)
			Values(_IdUsuarioAuth,vIdEmpresa);
			
			-- Registra Zonas
		--	Set vIdZona=0;
		--	If Exists (Select IdZona From zg_zonas) Then
		--		set vIdZona=(Select Max(IdZona) From zg_zonas);
		--	Else
		--		Set vIdZona=1;
		--	End If;
			
		--	Insert Into zg_zonas(IdEmpresa,IdZona,Descripcion,Detalle)
		--	Values(vIdEmpresa,vIdZona,'Zona','');
		--	Set vIdZona=LAST_INSERT_ID();
			
			-- Registra Sucursales...		
			Insert Into zg_sucursales(IdEmpresa,IdSucursal,Descripcion,CUO,Direccion,Telefono,Email,Ubigeo,Principal, Activo,Responsable)
			Values(vIdEmpresa,'001','PRINCIPAL','PRI','','...','','000000',1,1,'ALMACENERO');
			
			-- Registra Usuario-Sucursaless
			Insert Into zg_usuariossucursales(IdEmpresa,IdUsuario,IdSucursal)
			Values(vIdEmpresa,_IdUsuarioAuth,'001');
			
			
			insert into zg_usuariosmenus(IdUsuario,IdMenu,Accion,Activo)
			values (_IdUsuarioAuth,'0101','1111',1),
			(_IdUsuarioAuth,'0102','1111',1),
			(_IdUsuarioAuth,'0103','1111',1),
			(_IdUsuarioAuth,'0104','1111',1),
			(_IdUsuarioAuth,'0201','1111',1),
			(_IdUsuarioAuth,'0202','1111',1),			
			(_IdUsuarioAuth,'0203','1111',1),
			(_IdUsuarioAuth,'0204','1111',1),
			(_IdUsuarioAuth,'0105','1111',1),
			(_IdUsuarioAuth,'0206','1111',1),
			(_IdUsuarioAuth,'0207','1111',1),			
			(_IdUsuarioAuth,'0208','1111',1),			
			(_IdUsuarioAuth,'0301','1111',1),
			(_IdUsuarioAuth,'0302','1111',1),
			(_IdUsuarioAuth,'0303','1111',1),
			(_IdUsuarioAuth,'0401','1111',1),			
			(_IdUsuarioAuth,'0402','1111',1),
			(_IdUsuarioAuth,'0403','1111',1),
			(_IdUsuarioAuth,'0404','1111',1),
			(_IdUsuarioAuth,'0405','1111',1),			
			(_IdUsuarioAuth,'0501','1111',1);				
						
			
			SET success_ = 'usuario creado';
		When 'M02' Then
			Update zg_zusuarios Set
				Nombre=_Nombre,
				Telefo=_Telefo
			Where IdUsuarioAuth =_IdUsuarioAuth;
	      SET success_ = 'usuario actualizado';
		When 'M03' Then
			Delete From zg_zusuarios Where IdUsuario=_IdUsuario;  
		When 'M04' Then 
			Update zg_zusuarios Set
				LogClave =_LogClave
			Where IdUsuarioAuth = _IdUsuarioAuth;
	      SET success_ = 'token de usuario actualizado';
	   when 'M05' Then
	   	set vIdUsuario = '';
	   	set vIdUsuario = '';
	   	
	    	if exists(select IdUsuarioAuthKey from zg_zusuarios where IdUsuarioAuthKey =(Substring(_IdUsuario,1,28))) then
	   		set NroUsuarios = (SELECT CAST((SELECT SUBSTRING( Max(IdUsuario) , 30, 2) AS ExtractString FROM zg_zusuarios where IdUsuarioAuthKey =(Substring(_IdUsuario,1,28)) ) AS SIGNED) +1 );	   		
	   	else
	   		set NroUsuarios = 1;
	    	end if;
	    	
	    	set vIdUsuario = concat((Substring(_IdUsuario,1,28)),'-',NroUsuarios);
	   	
			Insert Into zg_zusuarios(IdUsuario,IdUsuarioAuth, Nombre,LogLogin,LogClave,Estado,Foto,IdUsuarioAuthKey,FechaRegistro,PeriodoIniFac,PeriodoFinFac,Telefono,Activo)
			Values(vIdUsuario,'', _Nombre,_LogLogin,_LogClave,_Estado,_Foto,(Substring(_IdUsuario,1,28)),DATE_FORMAT(_FechaRegistro, '%Y-%m-%d %H:%i:%s'),_PeriodoIniFac,_PeriodoFinFac,_Telefono,1);
			SET success_ = 'usuario creado';
		when 'M06' Then
				update zg_zusuarios set
					Nombre = _Nombre,
					Telefono = _Telefono,
					LogLogin = _LogLogin,
					LogClave = _LogClave
				where IdUsuario = _IdUsuario;
	      
		When 'S01' Then			
			-- listar subUsuarios
			Select IdUsuario, Nombre,LogLogin as Email,LogClave,Estado,Foto,IdUsuarioAuthKey,FechaRegistro,PeriodoIniFac,Telefono, Activo 
			From zg_zusuarios 
			where (Substring(IdUsuario,1,28)) =(Substring(_IdUsuario,1,28)) ;	
				
		When 'S02' Then
			Select p.IdPlan,p.IdModulo, m.Descripcion as modulo, p.Descripcion,p.Precio,p.ImgagenPlan,p.DiasDemo,p.NroEmpresas,p.NroUsuarios 
	        From zg_zplanes p 
			  Inner Join zg_zmodulos m ON p.IdModulo = m.IdModulo;
			  
		When 'S03' Then
			Select IdUsuario From zg_zusuarios where LogLogin=_LogLogin;
	        SET success_ = 'usuario existente';
	        
		When 'S04' Then
		-- getUserPrimary
			Select IdUsuario,IdUsuarioAuth, Nombre, LogLogin,Estado,Foto,FechaRegistro,PeriodoIniFac,Telefono 
				From zg_zusuarios
	      	where IdUsuarioAuth=_IdUsuarioAuth;
	        
		When 'S05' Then
			Select IdUsuario,LogLogin,Activo 
			From zg_zusuarios;
			
		End Case;
	    Select success_;
	    
	END IF;
End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Man_zg_usuariossucursales` (IN `_Accion` VARCHAR(4), IN `_IdUsuario` VARCHAR(100), IN `_IdSucursal` VARCHAR(3), IN `_IdEmpresa` VARCHAR(100))  BEGIN

		Case _Accion
			When 'M01' Then
				Insert Into zg_usuariosempresas(IdEmpresa, IdUsuario)
				values(_IdEmpresa,_IdUsuario);
				
				Insert Into zg_usuariossucursales (IdUsuario,IdSucursal,IdEmpresa)
				Values (_IdUsuario,_IdSucursal,_IdEmpresa);
				
			When 'M03' Then
				Delete From zg_usuariossucursales 
				Where IdUsuario=_IdUsuario And IdSucursal=_IdSucursal And IdEmpresa=_IdEmpresa;
				Delete From zg_usuariosempresas
				where IdEmpresa = _IdEmpresa and  IdUsuario=_IdUsuario;
								
			When 'S01' Then
				Select IdUsuario,IdEmpresa
				From zg_usuariosempresas;            
			When 'S02' Then
				Select IdUsuario as Id,LogLogin AS Name
				From zg_usuario;
			When 'S03' Then
				Select E.IdEmpresa as Id,E.Nombre AS Name
				From zg_usuariosempresas Z INNER JOIN zg_empresas E ON Z.IdEmpresa=E.IdEmpresa
	         where Z.IdUsuario=_IdUsuario;
			When 'S04' Then
	        Select US.IdSucursal, S.Descripcion, 1 AS Checked 
				From zg_usuariossucursales US 
				INNER JOIN zg_sucursales S ON US.IdSucursal = S.IdSucursal and US.IdEmpresa = S.IdEmpresa
				WHERE US.IdUsuario=_IdUsuario and US.IdEmpresa = _IdEmpresa
			UNION ALL 
				Select S.IdSucursal, S.Descripcion, 0 AS Checked 
					FROM zg_sucursales S 
					WHERE S.IdEmpresa=_IdEmpresa and S.IdSucursal 
					not in (select IdSucursal 
					FROM zg_usuariossucursales WHERE IdUsuario=_IdUsuario and IdEmpresa=_IdEmpresa ) ;	
		End Case;
		

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Man_zg_ver` (IN `_IdUsuario` VARCHAR(100), IN `_NombreSubmenu` VARCHAR(50))  BEGIN

	SELECT Accion AS Permisos
		FROM zg_usuariosmenus 
		where IdMenu=  (SELECT IdMenu FROM zg_zmenus WHERE Nombre = _NombreSubmenu)
		AND IdUsuario= _IdUsuario;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gen_monedas`
--

CREATE TABLE `gen_monedas` (
  `IdEmpresa` varchar(100) NOT NULL,
  `IdMoneda` varchar(3) NOT NULL,
  `Orden` int(11) NOT NULL,
  `Activo` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gen_tipoproducto`
--

CREATE TABLE `gen_tipoproducto` (
  `IdTipoProducto` varchar(3) NOT NULL,
  `Descripcion` varchar(100) NOT NULL,
  `Activo` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lo_almacenes`
--

CREATE TABLE `lo_almacenes` (
  `IdEmpresa` varchar(100) NOT NULL,
  `IdAlmacen` varchar(6) NOT NULL,
  `Descripcion` varchar(50) NOT NULL,
  `DescripcionCorta` varchar(50) NOT NULL,
  `Responsable` varchar(20) NOT NULL,
  `Activo` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `lo_almacenes`
--

INSERT INTO `lo_almacenes` (`IdEmpresa`, `IdAlmacen`, `Descripcion`, `DescripcionCorta`, `Responsable`, `Activo`) VALUES
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '1', 'almacen1', 'alm_1', 'almacenero0000', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '2', 'almecen 2', 'alm_2', 'betoss', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '3', 'almacen3', 'alm3', '', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '4', 'almacen4', '', '', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-20555555555', '1', 'almacen _1', 'alm_1', '', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lo_empresasmonedas`
--

CREATE TABLE `lo_empresasmonedas` (
  `IdEmpresa` varchar(100) NOT NULL,
  `IdMoneda` varchar(3) NOT NULL,
  `Orden` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lo_impuestos`
--

CREATE TABLE `lo_impuestos` (
  `IdEmpresa` varchar(100) NOT NULL,
  `IdImpuesto` varchar(6) NOT NULL,
  `Descripcion` varchar(50) DEFAULT NULL,
  `DescripcionCorta` varchar(6) DEFAULT NULL,
  `Porcentaje` decimal(18,2) NOT NULL,
  `Defecto` tinyint(4) DEFAULT NULL,
  `Diferido` tinyint(4) DEFAULT NULL,
  `Activo` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lo_lineas`
--

CREATE TABLE `lo_lineas` (
  `IdEmpresa` varchar(100) NOT NULL,
  `IdAlmacen` varchar(6) NOT NULL,
  `IdLinea` varchar(6) NOT NULL,
  `IdPropiedad1` varchar(6) NOT NULL,
  `IdPropiedad2` varchar(6) NOT NULL,
  `Seccion` varchar(6) NOT NULL,
  `Descripcion` varchar(50) NOT NULL,
  `Activo` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `lo_lineas`
--

INSERT INTO `lo_lineas` (`IdEmpresa`, `IdAlmacen`, `IdLinea`, `IdPropiedad1`, `IdPropiedad2`, `Seccion`, `Descripcion`, `Activo`) VALUES
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '3', '1', '000001', '', 'A0001', 'linea1', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lo_listapreciosdet`
--

CREATE TABLE `lo_listapreciosdet` (
  `IdEmpresa` varchar(100) NOT NULL,
  `IdListaPrecio` varchar(6) NOT NULL,
  `IdProducto` varchar(6) NOT NULL,
  `IdPropiedad1` varchar(6) NOT NULL,
  `Codigo` varchar(10) NOT NULL,
  `IdPropiedad2` varchar(6) DEFAULT NULL,
  `Precio` decimal(18,4) NOT NULL,
  `IdMoneda` varchar(3) NOT NULL,
  `Margen` decimal(18,4) NOT NULL,
  `CantidadMinimaVenta` decimal(18,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `lo_listapreciosdet`
--

INSERT INTO `lo_listapreciosdet` (`IdEmpresa`, `IdListaPrecio`, `IdProducto`, `IdPropiedad1`, `Codigo`, `IdPropiedad2`, `Precio`, `IdMoneda`, `Margen`, `CantidadMinimaVenta`) VALUES
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', 'L01', 'P001', '000001', 'PR0001', '000003', '2.5500', '1', '0.0000', '3.00'),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', 'L01', 'P001', '000001', 'PR0002', '000003', '2.8900', '1', '0.0000', '2.00'),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', 'L01', 'P001', '000001', 'PR0003', '000003', '2.2500', '1', '0.0000', '2.00'),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', 'L02', 'P001', '000001', 'C2001', NULL, '2.0000', '1', '0.0000', '3.00'),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', 'L01', 'P002', '000002', 'C1003', NULL, '12.0000', '1', '0.0000', '2.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lo_listapreciosenc`
--

CREATE TABLE `lo_listapreciosenc` (
  `IdEmpresa` varchar(100) NOT NULL,
  `IdListaPrecio` varchar(6) NOT NULL,
  `Descripcion` varchar(50) DEFAULT NULL,
  `Activo` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `lo_listapreciosenc`
--

INSERT INTO `lo_listapreciosenc` (`IdEmpresa`, `IdListaPrecio`, `Descripcion`, `Activo`) VALUES
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', 'L01', 'lista 1', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', 'L02', 'Lista 2', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lo_origenes`
--

CREATE TABLE `lo_origenes` (
  `IdEmpresa` varchar(100) NOT NULL,
  `IdOrigen` varchar(6) NOT NULL,
  `Descripcion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lo_productos`
--

CREATE TABLE `lo_productos` (
  `IdEmpresa` varchar(100) NOT NULL,
  `IdAlmacen` varchar(6) NOT NULL,
  `IdSubLinea` varchar(6) NOT NULL,
  `IdProducto` varchar(6) NOT NULL,
  `IdTipoProducto` varchar(6) NOT NULL,
  `IdImpuesto` varchar(6) NOT NULL,
  `Descripcion` varchar(300) DEFAULT NULL,
  `InfoAdicinal01` longtext,
  `InfoAdicinal02` longtext,
  `InfoAdicinal03` longtext,
  `isc` decimal(18,2) NOT NULL,
  `Percepcion` decimal(18,2) NOT NULL,
  `CodigoProveedor` varchar(50) NOT NULL,
  `Activo` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `lo_productos`
--

INSERT INTO `lo_productos` (`IdEmpresa`, `IdAlmacen`, `IdSubLinea`, `IdProducto`, `IdTipoProducto`, `IdImpuesto`, `Descripcion`, `InfoAdicinal01`, `InfoAdicinal02`, `InfoAdicinal03`, `isc`, `Percepcion`, `CodigoProveedor`, `Activo`) VALUES
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '1', '1', 'P001', '1', '1', 'GLOVES', NULL, NULL, NULL, '0.00', '0.00', '001', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '2', '1', 'P002', '1', '1', 'PELOTA', NULL, NULL, NULL, '0.00', '0.00', '002', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '3', '2', 'P003', '4', '3', 'COMBO MAX', 'COMBO PARA 2 PERSONAS', NULL, NULL, '0.00', '0.00', '003', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '3', '2', 'P004', '1', '1', 'GASEOSA MEDIANA', NULL, NULL, NULL, '0.00', '0.00', '', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '3', '2', 'P005', '1', '1', 'PIZZA MEDIANA', NULL, NULL, NULL, '0.00', '0.00', '', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lo_productosdetalles`
--

CREATE TABLE `lo_productosdetalles` (
  `IdEmpresa` varchar(100) NOT NULL,
  `IdProducto` varchar(6) NOT NULL,
  `IdProductoDet` varchar(6) NOT NULL,
  `IdPropiedad` varchar(6) NOT NULL,
  `Cantidad` decimal(18,2) NOT NULL,
  `Precio` decimal(18,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `lo_productosdetalles`
--

INSERT INTO `lo_productosdetalles` (`IdEmpresa`, `IdProducto`, `IdProductoDet`, `IdPropiedad`, `Cantidad`, `Precio`) VALUES
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', 'P004', '0001', '000002', '1.00', '2.50'),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', 'P005', '0002', '000002', '1.00', '8.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lo_propiedades`
--

CREATE TABLE `lo_propiedades` (
  `IdEmpresa` varchar(100) NOT NULL,
  `IdPropiedad` varchar(6) NOT NULL,
  `Descripcion` varchar(300) NOT NULL,
  `Activo` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `lo_propiedades`
--

INSERT INTO `lo_propiedades` (`IdEmpresa`, `IdPropiedad`, `Descripcion`, `Activo`) VALUES
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '000001', 'TALLA', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '000002', 'UNIDAD', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '000003', 'COLOR', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lo_propiedadesdetalles`
--

CREATE TABLE `lo_propiedadesdetalles` (
  `IdEmpresa` varchar(100) NOT NULL,
  `IdPropiedad` varchar(6) NOT NULL,
  `Codigo` varchar(10) NOT NULL,
  `Orden` int(11) NOT NULL,
  `Descripcion` varchar(100) NOT NULL,
  `CodigoBarra` varchar(50) NOT NULL,
  `Imagen` varchar(300) NOT NULL,
  `Equivalencia` int(11) NOT NULL,
  `IdSunat` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `lo_propiedadesdetalles`
--

INSERT INTO `lo_propiedadesdetalles` (`IdEmpresa`, `IdPropiedad`, `Codigo`, `Orden`, `Descripcion`, `CodigoBarra`, `Imagen`, `Equivalencia`, `IdSunat`) VALUES
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '000001', 'PR0001', 1, 'SMALL', '0001', '', 0, ''),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '000001', 'PR0002', 2, 'MEDIUM', '0002', '', 0, ''),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '000001', 'PR0003', 3, 'LARGE', '0003', '', 0, ''),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '000003', 'PR0004', 1, 'BLANCO', '0004', '', 0, ''),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '000003', 'PR0005', 2, 'ROJO', '0005', '', 0, '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lo_sublineas`
--

CREATE TABLE `lo_sublineas` (
  `IdEmpresa` varchar(100) NOT NULL,
  `IdLinea` varchar(6) NOT NULL,
  `IdSubLinea` varchar(6) NOT NULL,
  `Descripcion` varchar(50) NOT NULL,
  `Activo` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `lo_sublineas`
--

INSERT INTO `lo_sublineas` (`IdEmpresa`, `IdLinea`, `IdSubLinea`, `Descripcion`, `Activo`) VALUES
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '4', '1', 'sublinea01', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lo_sucursaleslistaprecios`
--

CREATE TABLE `lo_sucursaleslistaprecios` (
  `IdEmpresa` varchar(100) NOT NULL,
  `IdSucursal` varchar(6) NOT NULL,
  `IdListaPrecio` varchar(6) NOT NULL,
  `Defecto` tinyint(4) DEFAULT NULL,
  `Activo` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `lo_sucursaleslistaprecios`
--

INSERT INTO `lo_sucursaleslistaprecios` (`IdEmpresa`, `IdSucursal`, `IdListaPrecio`, `Defecto`, `Activo`) VALUES
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '001', 'L01', 1, 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '002', 'L01', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lo_tipodocumentos`
--

CREATE TABLE `lo_tipodocumentos` (
  `IdEmpresa` varchar(100) NOT NULL,
  `IdTipoDocumento` varchar(6) NOT NULL,
  `Descripcion` varchar(50) NOT NULL,
  `CodigoSunat` varchar(2) NOT NULL,
  `Configuracion` varchar(20) NOT NULL,
  `Activo` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `lo_tipodocumentos`
--

INSERT INTO `lo_tipodocumentos` (`IdEmpresa`, `IdTipoDocumento`, `Descripcion`, `CodigoSunat`, `Configuracion`, `Activo`) VALUES
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '1', 'Boleta Electronica', 'BE', '11111', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '10', 'prueba9', 'BN', '00000', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '3', 'factura', 'TK', '1111111', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '4', 'pruebaa', 'sd', '1100', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '5', 'prueba4', 'FR', '00', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '6', 'prueba2', 'TG', '10101', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '7', 'prueba3', 'GY', '11000', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '8', 'rpueba6', 'HI', '0011', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '9', 'prueb8', 'DD', '111111000', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2-12345678911', '2', 'Boleta Elect', 'BE', '11110111', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `stipodatosmysql`
--

CREATE TABLE `stipodatosmysql` (
  `IdTipDat` int(11) NOT NULL,
  `TipDatSqlMysql` varchar(50) DEFAULT NULL,
  `TipoDatAngular` varchar(50) DEFAULT NULL,
  `SqlVersion` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `stipodatosmysql`
--

INSERT INTO `stipodatosmysql` (`IdTipDat`, `TipDatSqlMysql`, `TipoDatAngular`, `SqlVersion`) VALUES
(1, 'TINYINT', 'Number', NULL),
(2, 'INT', 'Number', NULL),
(3, 'MEDIUMINT', 'Number', NULL),
(4, 'SMALLINT', 'Number', NULL),
(5, 'BigInt', 'Number', NULL),
(6, 'Decimal', 'Decimal', NULL),
(7, 'VarChar', 'String', NULL),
(8, 'Char', 'String', NULL),
(9, 'Date', 'Date', NULL),
(10, 'DateTime', 'Date', NULL),
(11, 'Time', 'Date', NULL),
(12, 'Bit', 'Boolean', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zg_correlativos`
--

CREATE TABLE `zg_correlativos` (
  `IdEmpresa` varchar(100) NOT NULL,
  `IdSucursal` varchar(6) NOT NULL,
  `IdTipoDocumento` varchar(6) NOT NULL,
  `Serie` varchar(4) NOT NULL,
  `DocNro` int(11) NOT NULL,
  `Defecto` tinyint(4) DEFAULT NULL,
  `ImprimirEn` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `zg_correlativos`
--

INSERT INTO `zg_correlativos` (`IdEmpresa`, `IdSucursal`, `IdTipoDocumento`, `Serie`, `DocNro`, `Defecto`, `ImprimirEn`) VALUES
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '001', '1', 'B001', 1, 1, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zg_empresas`
--

CREATE TABLE `zg_empresas` (
  `IdEmpresa` varchar(100) NOT NULL,
  `Nombre` varchar(150) DEFAULT NULL,
  `NombreComercial` varchar(150) DEFAULT NULL,
  `NombreCorto` varchar(6) DEFAULT NULL,
  `Direccion` varchar(100) DEFAULT NULL,
  `Ruc` varchar(20) DEFAULT NULL,
  `Telefono` varchar(50) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `WebPage` varchar(100) DEFAULT NULL,
  `Activo` tinyint(4) DEFAULT NULL,
  `Imagen01` varchar(500) DEFAULT NULL,
  `Imagen02` varchar(500) DEFAULT NULL,
  `Imagen03` varchar(500) DEFAULT NULL,
  `Imagen04` varchar(500) DEFAULT NULL,
  `Ubigeo` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `zg_empresas`
--

INSERT INTO `zg_empresas` (`IdEmpresa`, `Nombre`, `NombreComercial`, `NombreCorto`, `Direccion`, `Ruc`, `Telefono`, `Email`, `WebPage`, `Activo`, `Imagen01`, `Imagen02`, `Imagen03`, `Imagen04`, `Ubigeo`) VALUES
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', 'Empresa BASE', 'Empresa BASE', 'EB', 'direccion 169', '12345678911', '123445', 'empresa@email.com', 'www.empresa.com', 1, NULL, NULL, NULL, NULL, '030303'),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-20555555555', 'empresa test', 'Comercial test', 'test', 'av. ssin nombre urb. industrial 1020', '20555555555', '', 'emp_test@email.com', '', 1, NULL, NULL, NULL, NULL, '130403'),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-22222222222', 'empresa pruebaaa usuar', 'empres usuario', 'empre ', 'av sn', '22222222222', '', 'emp_usu@email.com', '', 1, NULL, NULL, NULL, NULL, '020402'),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-33333333333', 'empresa nnn', 'empre', 'nnn', 'av snnnn', '33333333333', '', 'emp_nn@email.com', '', 1, NULL, NULL, NULL, NULL, '030302'),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2-12345678911', 'Empresa BASE', 'Empresa BASE', 'EB', 'direccion 169', '12345678911', '123445', 'empresa@email.com', 'www.empresa.com', 1, NULL, 'Imagen02.jpg', 'Imagen03.jpg', 'Imagen04.jpg', ''),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2-51111111111', 'empresa05_01', 'empresa comercial5', 'emp05_', 'av sn', '51111111111', '', 'emp5_1@email.com', '', 1, 'Imagen01.jpg', NULL, NULL, 'Imagen04.jpg', '050302');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zg_sucursales`
--

CREATE TABLE `zg_sucursales` (
  `IdEmpresa` varchar(100) NOT NULL,
  `IdSucursal` varchar(3) NOT NULL,
  `Descripcion` varchar(50) NOT NULL,
  `CUO` varchar(3) NOT NULL,
  `Direccion` varchar(50) NOT NULL,
  `Telefono` varchar(10) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Ubigeo` varchar(6) NOT NULL,
  `Principal` tinyint(1) DEFAULT NULL,
  `Responsable` varchar(20) NOT NULL,
  `Activo` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `zg_sucursales`
--

INSERT INTO `zg_sucursales` (`IdEmpresa`, `IdSucursal`, `Descripcion`, `CUO`, `Direccion`, `Telefono`, `Email`, `Ubigeo`, `Principal`, `Responsable`, `Activo`) VALUES
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '001', 'sucursalll 1', 'PRI', '', '...', '', '030203', 1, 'ALMACENERO', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '002', 'sucursal sur', 'SUR', 'av. losa alamos', '', '', '020503', 0, 'Coquito', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-20555555555', '001', 'PRINCIPAL', 'PRI', '', '...', '', '000000', 1, 'ALMACENERO', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-22222222222', '001', 'PRINCIPAL', 'PRI', '', '...', '', '000000', 1, 'ALMACENERO', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-33333333333', '001', 'PRINCIPAL', 'PRI', '', '...', '', '000000', 1, 'ALMACENERO', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2-12345678911', '001', 'PRINCIPAL', 'PRI', '', '...', '', '000000', 1, 'ALMACENERO', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2-51111111111', '001', 'sucursal1', 'SUC', 'av. sn', '5656565', '', '', 1, 'Brutus', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zg_tipodocumentosmenus`
--

CREATE TABLE `zg_tipodocumentosmenus` (
  `IdEmpresa` varchar(100) NOT NULL,
  `IdTipoDocumento` varchar(6) NOT NULL,
  `IdMenu` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zg_ubigeo`
--

CREATE TABLE `zg_ubigeo` (
  `IdUbigeo` varchar(6) DEFAULT NULL,
  `Departamento` varchar(50) DEFAULT NULL,
  `Provincia` varchar(50) DEFAULT NULL,
  `Distrito` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `zg_ubigeo`
--

INSERT INTO `zg_ubigeo` (`IdUbigeo`, `Departamento`, `Provincia`, `Distrito`) VALUES
('010101', 'AMAZONAS', 'CHACHAPOYAS', 'CHACHAPOYAS'),
('010102', 'AMAZONAS', 'CHACHAPOYAS', 'ASUNCIÓN'),
('010103', 'AMAZONAS', 'CHACHAPOYAS', 'BALSAS'),
('010104', 'AMAZONAS', 'CHACHAPOYAS', 'CHETO'),
('010105', 'AMAZONAS', 'CHACHAPOYAS', 'CHILIQUIN'),
('010106', 'AMAZONAS', 'CHACHAPOYAS', 'CHUQUIBAMBA'),
('010107', 'AMAZONAS', 'CHACHAPOYAS', 'GRANADA'),
('010108', 'AMAZONAS', 'CHACHAPOYAS', 'HUANCAS'),
('010109', 'AMAZONAS', 'CHACHAPOYAS', 'LA JALCA'),
('010110', 'AMAZONAS', 'CHACHAPOYAS', 'LEIMEBAMBA'),
('010111', 'AMAZONAS', 'CHACHAPOYAS', 'LEVANTO'),
('010112', 'AMAZONAS', 'CHACHAPOYAS', 'MAGDALENA'),
('010113', 'AMAZONAS', 'CHACHAPOYAS', 'MARISCAL CASTILLA'),
('010114', 'AMAZONAS', 'CHACHAPOYAS', 'MOLINOPAMPA'),
('010115', 'AMAZONAS', 'CHACHAPOYAS', 'MONTEVIDEO'),
('010116', 'AMAZONAS', 'CHACHAPOYAS', 'OLLEROS'),
('010117', 'AMAZONAS', 'CHACHAPOYAS', 'QUINJALCA'),
('010118', 'AMAZONAS', 'CHACHAPOYAS', 'SAN FRANCISCO DE DAGUAS'),
('010119', 'AMAZONAS', 'CHACHAPOYAS', 'SAN ISIDRO DE MAINO'),
('010120', 'AMAZONAS', 'CHACHAPOYAS', 'SOLOCO'),
('010121', 'AMAZONAS', 'CHACHAPOYAS', 'SONCHE'),
('010201', 'AMAZONAS', 'BAGUA', 'BAGUA'),
('010202', 'AMAZONAS', 'BAGUA', 'ARAMANGO'),
('010203', 'AMAZONAS', 'BAGUA', 'COPALLIN'),
('010204', 'AMAZONAS', 'BAGUA', 'EL PARCO'),
('010205', 'AMAZONAS', 'BAGUA', 'IMAZA'),
('010206', 'AMAZONAS', 'BAGUA', 'LA PECA'),
('010301', 'AMAZONAS', 'BONGARÁ', 'JUMBILLA'),
('010302', 'AMAZONAS', 'BONGARÁ', 'CHISQUILLA'),
('010303', 'AMAZONAS', 'BONGARÁ', 'CHURUJA'),
('010304', 'AMAZONAS', 'BONGARÁ', 'COROSHA'),
('010305', 'AMAZONAS', 'BONGARÁ', 'CUISPES'),
('010306', 'AMAZONAS', 'BONGARÁ', 'FLORIDA'),
('010307', 'AMAZONAS', 'BONGARÁ', 'JAZAN'),
('010308', 'AMAZONAS', 'BONGARÁ', 'RECTA'),
('010309', 'AMAZONAS', 'BONGARÁ', 'SAN CARLOS'),
('010310', 'AMAZONAS', 'BONGARÁ', 'SHIPASBAMBA'),
('010311', 'AMAZONAS', 'BONGARÁ', 'VALERA'),
('010312', 'AMAZONAS', 'BONGARÁ', 'YAMBRASBAMBA'),
('010401', 'AMAZONAS', 'CONDORCANQUI', 'NIEVA'),
('010402', 'AMAZONAS', 'CONDORCANQUI', 'EL CENEPA'),
('010403', 'AMAZONAS', 'CONDORCANQUI', 'RÍO SANTIAGO'),
('010501', 'AMAZONAS', 'LUYA', 'LAMUD'),
('010502', 'AMAZONAS', 'LUYA', 'CAMPORREDONDO'),
('010503', 'AMAZONAS', 'LUYA', 'COCABAMBA'),
('010504', 'AMAZONAS', 'LUYA', 'COLCAMAR'),
('010505', 'AMAZONAS', 'LUYA', 'CONILA'),
('010506', 'AMAZONAS', 'LUYA', 'INGUILPATA'),
('010507', 'AMAZONAS', 'LUYA', 'LONGUITA'),
('010508', 'AMAZONAS', 'LUYA', 'LONYA CHICO'),
('010509', 'AMAZONAS', 'LUYA', 'LUYA'),
('010510', 'AMAZONAS', 'LUYA', 'LUYA VIEJO'),
('010511', 'AMAZONAS', 'LUYA', 'MARÍA'),
('010512', 'AMAZONAS', 'LUYA', 'OCALLI'),
('010513', 'AMAZONAS', 'LUYA', 'OCUMAL'),
('010514', 'AMAZONAS', 'LUYA', 'PISUQUIA'),
('010515', 'AMAZONAS', 'LUYA', 'PROVIDENCIA'),
('010516', 'AMAZONAS', 'LUYA', 'SAN CRISTÓBAL'),
('010517', 'AMAZONAS', 'LUYA', 'SAN FRANCISCO DE YESO'),
('010518', 'AMAZONAS', 'LUYA', 'SAN JERÓNIMO'),
('010519', 'AMAZONAS', 'LUYA', 'SAN JUAN DE LOPECANCHA'),
('010520', 'AMAZONAS', 'LUYA', 'SANTA CATALINA'),
('010521', 'AMAZONAS', 'LUYA', 'SANTO TOMAS'),
('010522', 'AMAZONAS', 'LUYA', 'TINGO'),
('010523', 'AMAZONAS', 'LUYA', 'TRITA'),
('010601', 'AMAZONAS', 'RODRÍGUEZ DE MENDOZA', 'SAN NICOLÁS'),
('010602', 'AMAZONAS', 'RODRÍGUEZ DE MENDOZA', 'CHIRIMOTO'),
('010603', 'AMAZONAS', 'RODRÍGUEZ DE MENDOZA', 'COCHAMAL'),
('010604', 'AMAZONAS', 'RODRÍGUEZ DE MENDOZA', 'HUAMBO'),
('010605', 'AMAZONAS', 'RODRÍGUEZ DE MENDOZA', 'LIMABAMBA'),
('010606', 'AMAZONAS', 'RODRÍGUEZ DE MENDOZA', 'LONGAR'),
('010607', 'AMAZONAS', 'RODRÍGUEZ DE MENDOZA', 'MARISCAL BENAVIDES'),
('010608', 'AMAZONAS', 'RODRÍGUEZ DE MENDOZA', 'MILPUC'),
('010609', 'AMAZONAS', 'RODRÍGUEZ DE MENDOZA', 'OMIA'),
('010610', 'AMAZONAS', 'RODRÍGUEZ DE MENDOZA', 'SANTA ROSA'),
('010611', 'AMAZONAS', 'RODRÍGUEZ DE MENDOZA', 'TOTORA'),
('010612', 'AMAZONAS', 'RODRÍGUEZ DE MENDOZA', 'VISTA ALEGRE'),
('010701', 'AMAZONAS', 'UTCUBAMBA', 'BAGUA GRANDE'),
('010702', 'AMAZONAS', 'UTCUBAMBA', 'CAJARURO'),
('010703', 'AMAZONAS', 'UTCUBAMBA', 'CUMBA'),
('010704', 'AMAZONAS', 'UTCUBAMBA', 'EL MILAGRO'),
('010705', 'AMAZONAS', 'UTCUBAMBA', 'JAMALCA'),
('010706', 'AMAZONAS', 'UTCUBAMBA', 'LONYA GRANDE'),
('010707', 'AMAZONAS', 'UTCUBAMBA', 'YAMON'),
('020101', 'ÁNCASH', 'HUARAZ', 'HUARAZ'),
('020102', 'ÁNCASH', 'HUARAZ', 'COCHABAMBA'),
('020103', 'ÁNCASH', 'HUARAZ', 'COLCABAMBA'),
('020104', 'ÁNCASH', 'HUARAZ', 'HUANCHAY'),
('020105', 'ÁNCASH', 'HUARAZ', 'INDEPENDENCIA'),
('020106', 'ÁNCASH', 'HUARAZ', 'JANGAS'),
('020107', 'ÁNCASH', 'HUARAZ', 'LA LIBERTAD'),
('020108', 'ÁNCASH', 'HUARAZ', 'OLLEROS'),
('020109', 'ÁNCASH', 'HUARAZ', 'PAMPAS GRANDE'),
('020110', 'ÁNCASH', 'HUARAZ', 'PARIACOTO'),
('020111', 'ÁNCASH', 'HUARAZ', 'PIRA'),
('020112', 'ÁNCASH', 'HUARAZ', 'TARICA'),
('020201', 'ÁNCASH', 'AIJA', 'AIJA'),
('020202', 'ÁNCASH', 'AIJA', 'CORIS'),
('020203', 'ÁNCASH', 'AIJA', 'HUACLLAN'),
('020204', 'ÁNCASH', 'AIJA', 'LA MERCED'),
('020205', 'ÁNCASH', 'AIJA', 'SUCCHA'),
('020301', 'ÁNCASH', 'ANTONIO RAYMONDI', 'LLAMELLIN'),
('020302', 'ÁNCASH', 'ANTONIO RAYMONDI', 'ACZO'),
('020303', 'ÁNCASH', 'ANTONIO RAYMONDI', 'CHACCHO'),
('020304', 'ÁNCASH', 'ANTONIO RAYMONDI', 'CHINGAS'),
('020305', 'ÁNCASH', 'ANTONIO RAYMONDI', 'MIRGAS'),
('020306', 'ÁNCASH', 'ANTONIO RAYMONDI', 'SAN JUAN DE RONTOY'),
('020401', 'ÁNCASH', 'ASUNCIÓN', 'CHACAS'),
('020402', 'ÁNCASH', 'ASUNCIÓN', 'ACOCHACA'),
('020501', 'ÁNCASH', 'BOLOGNESI', 'CHIQUIAN'),
('020502', 'ÁNCASH', 'BOLOGNESI', 'ABELARDO PARDO LEZAMETA'),
('020503', 'ÁNCASH', 'BOLOGNESI', 'ANTONIO RAYMONDI'),
('020504', 'ÁNCASH', 'BOLOGNESI', 'AQUIA'),
('020505', 'ÁNCASH', 'BOLOGNESI', 'CAJACAY'),
('020506', 'ÁNCASH', 'BOLOGNESI', 'CANIS'),
('020507', 'ÁNCASH', 'BOLOGNESI', 'COLQUIOC'),
('020508', 'ÁNCASH', 'BOLOGNESI', 'HUALLANCA'),
('020509', 'ÁNCASH', 'BOLOGNESI', 'HUASTA'),
('020510', 'ÁNCASH', 'BOLOGNESI', 'HUAYLLACAYAN'),
('020511', 'ÁNCASH', 'BOLOGNESI', 'LA PRIMAVERA'),
('020512', 'ÁNCASH', 'BOLOGNESI', 'MANGAS'),
('020513', 'ÁNCASH', 'BOLOGNESI', 'PACLLON'),
('020514', 'ÁNCASH', 'BOLOGNESI', 'SAN MIGUEL DE CORPANQUI'),
('020515', 'ÁNCASH', 'BOLOGNESI', 'TICLLOS'),
('020601', 'ÁNCASH', 'CARHUAZ', 'CARHUAZ'),
('020602', 'ÁNCASH', 'CARHUAZ', 'ACOPAMPA'),
('020603', 'ÁNCASH', 'CARHUAZ', 'AMASHCA'),
('020604', 'ÁNCASH', 'CARHUAZ', 'ANTA'),
('020605', 'ÁNCASH', 'CARHUAZ', 'ATAQUERO'),
('020606', 'ÁNCASH', 'CARHUAZ', 'MARCARA'),
('020607', 'ÁNCASH', 'CARHUAZ', 'PARIAHUANCA'),
('020608', 'ÁNCASH', 'CARHUAZ', 'SAN MIGUEL DE ACO'),
('020609', 'ÁNCASH', 'CARHUAZ', 'SHILLA'),
('020610', 'ÁNCASH', 'CARHUAZ', 'TINCO'),
('020611', 'ÁNCASH', 'CARHUAZ', 'YUNGAR'),
('020701', 'ÁNCASH', 'CARLOS FERMÍN FITZCARRALD', 'SAN LUIS'),
('020702', 'ÁNCASH', 'CARLOS FERMÍN FITZCARRALD', 'SAN NICOLÁS'),
('020703', 'ÁNCASH', 'CARLOS FERMÍN FITZCARRALD', 'YAUYA'),
('020801', 'ÁNCASH', 'CASMA', 'CASMA'),
('020802', 'ÁNCASH', 'CASMA', 'BUENA VISTA ALTA'),
('020803', 'ÁNCASH', 'CASMA', 'COMANDANTE NOEL'),
('020804', 'ÁNCASH', 'CASMA', 'YAUTAN'),
('020901', 'ÁNCASH', 'CORONGO', 'CORONGO'),
('020902', 'ÁNCASH', 'CORONGO', 'ACO'),
('020903', 'ÁNCASH', 'CORONGO', 'BAMBAS'),
('020904', 'ÁNCASH', 'CORONGO', 'CUSCA'),
('020905', 'ÁNCASH', 'CORONGO', 'LA PAMPA'),
('020906', 'ÁNCASH', 'CORONGO', 'YANAC'),
('020907', 'ÁNCASH', 'CORONGO', 'YUPAN'),
('021001', 'ÁNCASH', 'HUARI', 'HUARI'),
('021002', 'ÁNCASH', 'HUARI', 'ANRA'),
('021003', 'ÁNCASH', 'HUARI', 'CAJAY'),
('021004', 'ÁNCASH', 'HUARI', 'CHAVIN DE HUANTAR'),
('021005', 'ÁNCASH', 'HUARI', 'HUACACHI'),
('021006', 'ÁNCASH', 'HUARI', 'HUACCHIS'),
('021007', 'ÁNCASH', 'HUARI', 'HUACHIS'),
('021008', 'ÁNCASH', 'HUARI', 'HUANTAR'),
('021009', 'ÁNCASH', 'HUARI', 'MASIN'),
('021010', 'ÁNCASH', 'HUARI', 'PAUCAS'),
('021011', 'ÁNCASH', 'HUARI', 'PONTO'),
('021012', 'ÁNCASH', 'HUARI', 'RAHUAPAMPA'),
('021013', 'ÁNCASH', 'HUARI', 'RAPAYAN'),
('021014', 'ÁNCASH', 'HUARI', 'SAN MARCOS'),
('021015', 'ÁNCASH', 'HUARI', 'SAN PEDRO DE CHANA'),
('021016', 'ÁNCASH', 'HUARI', 'UCO'),
('021101', 'ÁNCASH', 'HUARMEY', 'HUARMEY'),
('021102', 'ÁNCASH', 'HUARMEY', 'COCHAPETI'),
('021103', 'ÁNCASH', 'HUARMEY', 'CULEBRAS'),
('021104', 'ÁNCASH', 'HUARMEY', 'HUAYAN'),
('021105', 'ÁNCASH', 'HUARMEY', 'MALVAS'),
('021201', 'ÁNCASH', 'HUAYLAS', 'CARAZ'),
('021202', 'ÁNCASH', 'HUAYLAS', 'HUALLANCA'),
('021203', 'ÁNCASH', 'HUAYLAS', 'HUATA'),
('021204', 'ÁNCASH', 'HUAYLAS', 'HUAYLAS'),
('021205', 'ÁNCASH', 'HUAYLAS', 'MATO'),
('021206', 'ÁNCASH', 'HUAYLAS', 'PAMPAROMAS'),
('021207', 'ÁNCASH', 'HUAYLAS', 'PUEBLO LIBRE'),
('021208', 'ÁNCASH', 'HUAYLAS', 'SANTA CRUZ'),
('021209', 'ÁNCASH', 'HUAYLAS', 'SANTO TORIBIO'),
('021210', 'ÁNCASH', 'HUAYLAS', 'YURACMARCA'),
('021301', 'ÁNCASH', 'MARISCAL LUZURIAGA', 'PISCOBAMBA'),
('021302', 'ÁNCASH', 'MARISCAL LUZURIAGA', 'CASCA'),
('021303', 'ÁNCASH', 'MARISCAL LUZURIAGA', 'ELEAZAR GUZMÁN BARRON'),
('021304', 'ÁNCASH', 'MARISCAL LUZURIAGA', 'FIDEL OLIVAS ESCUDERO'),
('021305', 'ÁNCASH', 'MARISCAL LUZURIAGA', 'LLAMA'),
('021306', 'ÁNCASH', 'MARISCAL LUZURIAGA', 'LLUMPA'),
('021307', 'ÁNCASH', 'MARISCAL LUZURIAGA', 'LUCMA'),
('021308', 'ÁNCASH', 'MARISCAL LUZURIAGA', 'MUSGA'),
('021401', 'ÁNCASH', 'OCROS', 'OCROS'),
('021402', 'ÁNCASH', 'OCROS', 'ACAS'),
('021403', 'ÁNCASH', 'OCROS', 'CAJAMARQUILLA'),
('021404', 'ÁNCASH', 'OCROS', 'CARHUAPAMPA'),
('021405', 'ÁNCASH', 'OCROS', 'COCHAS'),
('021406', 'ÁNCASH', 'OCROS', 'CONGAS'),
('021407', 'ÁNCASH', 'OCROS', 'LLIPA'),
('021408', 'ÁNCASH', 'OCROS', 'SAN CRISTÓBAL DE RAJAN'),
('021409', 'ÁNCASH', 'OCROS', 'SAN PEDRO'),
('021410', 'ÁNCASH', 'OCROS', 'SANTIAGO DE CHILCAS'),
('021501', 'ÁNCASH', 'PALLASCA', 'CABANA'),
('021502', 'ÁNCASH', 'PALLASCA', 'BOLOGNESI'),
('021503', 'ÁNCASH', 'PALLASCA', 'CONCHUCOS'),
('021504', 'ÁNCASH', 'PALLASCA', 'HUACASCHUQUE'),
('021505', 'ÁNCASH', 'PALLASCA', 'HUANDOVAL'),
('021506', 'ÁNCASH', 'PALLASCA', 'LACABAMBA'),
('021507', 'ÁNCASH', 'PALLASCA', 'LLAPO'),
('021508', 'ÁNCASH', 'PALLASCA', 'PALLASCA'),
('021509', 'ÁNCASH', 'PALLASCA', 'PAMPAS'),
('021510', 'ÁNCASH', 'PALLASCA', 'SANTA ROSA'),
('021511', 'ÁNCASH', 'PALLASCA', 'TAUCA'),
('021601', 'ÁNCASH', 'POMABAMBA', 'POMABAMBA'),
('021602', 'ÁNCASH', 'POMABAMBA', 'HUAYLLAN'),
('021603', 'ÁNCASH', 'POMABAMBA', 'PAROBAMBA'),
('021604', 'ÁNCASH', 'POMABAMBA', 'QUINUABAMBA'),
('021701', 'ÁNCASH', 'RECUAY', 'RECUAY'),
('021702', 'ÁNCASH', 'RECUAY', 'CATAC'),
('021703', 'ÁNCASH', 'RECUAY', 'COTAPARACO'),
('021704', 'ÁNCASH', 'RECUAY', 'HUAYLLAPAMPA'),
('021705', 'ÁNCASH', 'RECUAY', 'LLACLLIN'),
('021706', 'ÁNCASH', 'RECUAY', 'MARCA'),
('021707', 'ÁNCASH', 'RECUAY', 'PAMPAS CHICO'),
('021708', 'ÁNCASH', 'RECUAY', 'PARARIN'),
('021709', 'ÁNCASH', 'RECUAY', 'TAPACOCHA'),
('021710', 'ÁNCASH', 'RECUAY', 'TICAPAMPA'),
('021801', 'ÁNCASH', 'SANTA', 'CHIMBOTE'),
('021802', 'ÁNCASH', 'SANTA', 'CÁCERES DEL PERÚ'),
('021803', 'ÁNCASH', 'SANTA', 'COISHCO'),
('021804', 'ÁNCASH', 'SANTA', 'MACATE'),
('021805', 'ÁNCASH', 'SANTA', 'MORO'),
('021806', 'ÁNCASH', 'SANTA', 'NEPEÑA'),
('021807', 'ÁNCASH', 'SANTA', 'SAMANCO'),
('021808', 'ÁNCASH', 'SANTA', 'SANTA'),
('021809', 'ÁNCASH', 'SANTA', 'NUEVO CHIMBOTE'),
('021901', 'ÁNCASH', 'SIHUAS', 'SIHUAS'),
('021902', 'ÁNCASH', 'SIHUAS', 'ACOBAMBA'),
('021903', 'ÁNCASH', 'SIHUAS', 'ALFONSO UGARTE'),
('021904', 'ÁNCASH', 'SIHUAS', 'CASHAPAMPA'),
('021905', 'ÁNCASH', 'SIHUAS', 'CHINGALPO'),
('021906', 'ÁNCASH', 'SIHUAS', 'HUAYLLABAMBA'),
('021907', 'ÁNCASH', 'SIHUAS', 'QUICHES'),
('021908', 'ÁNCASH', 'SIHUAS', 'RAGASH'),
('021909', 'ÁNCASH', 'SIHUAS', 'SAN JUAN'),
('021910', 'ÁNCASH', 'SIHUAS', 'SICSIBAMBA'),
('022001', 'ÁNCASH', 'YUNGAY', 'YUNGAY'),
('022002', 'ÁNCASH', 'YUNGAY', 'CASCAPARA'),
('022003', 'ÁNCASH', 'YUNGAY', 'MANCOS'),
('022004', 'ÁNCASH', 'YUNGAY', 'MATACOTO'),
('022005', 'ÁNCASH', 'YUNGAY', 'QUILLO'),
('022006', 'ÁNCASH', 'YUNGAY', 'RANRAHIRCA'),
('022007', 'ÁNCASH', 'YUNGAY', 'SHUPLUY'),
('022008', 'ÁNCASH', 'YUNGAY', 'YANAMA'),
('030101', 'APURÍMAC', 'ABANCAY', 'ABANCAY'),
('030102', 'APURÍMAC', 'ABANCAY', 'CHACOCHE'),
('030103', 'APURÍMAC', 'ABANCAY', 'CIRCA'),
('030104', 'APURÍMAC', 'ABANCAY', 'CURAHUASI'),
('030105', 'APURÍMAC', 'ABANCAY', 'HUANIPACA'),
('030106', 'APURÍMAC', 'ABANCAY', 'LAMBRAMA'),
('030107', 'APURÍMAC', 'ABANCAY', 'PICHIRHUA'),
('030108', 'APURÍMAC', 'ABANCAY', 'SAN PEDRO DE CACHORA'),
('030109', 'APURÍMAC', 'ABANCAY', 'TAMBURCO'),
('030201', 'APURÍMAC', 'ANDAHUAYLAS', 'ANDAHUAYLAS'),
('030202', 'APURÍMAC', 'ANDAHUAYLAS', 'ANDARAPA'),
('030203', 'APURÍMAC', 'ANDAHUAYLAS', 'CHIARA'),
('030204', 'APURÍMAC', 'ANDAHUAYLAS', 'HUANCARAMA'),
('030205', 'APURÍMAC', 'ANDAHUAYLAS', 'HUANCARAY'),
('030206', 'APURÍMAC', 'ANDAHUAYLAS', 'HUAYANA'),
('030207', 'APURÍMAC', 'ANDAHUAYLAS', 'KISHUARA'),
('030208', 'APURÍMAC', 'ANDAHUAYLAS', 'PACOBAMBA'),
('030209', 'APURÍMAC', 'ANDAHUAYLAS', 'PACUCHA'),
('030210', 'APURÍMAC', 'ANDAHUAYLAS', 'PAMPACHIRI'),
('030211', 'APURÍMAC', 'ANDAHUAYLAS', 'POMACOCHA'),
('030212', 'APURÍMAC', 'ANDAHUAYLAS', 'SAN ANTONIO DE CACHI'),
('030213', 'APURÍMAC', 'ANDAHUAYLAS', 'SAN JERÓNIMO'),
('030214', 'APURÍMAC', 'ANDAHUAYLAS', 'SAN MIGUEL DE CHACCRAMPA'),
('030215', 'APURÍMAC', 'ANDAHUAYLAS', 'SANTA MARÍA DE CHICMO'),
('030216', 'APURÍMAC', 'ANDAHUAYLAS', 'TALAVERA'),
('030217', 'APURÍMAC', 'ANDAHUAYLAS', 'TUMAY HUARACA'),
('030218', 'APURÍMAC', 'ANDAHUAYLAS', 'TURPO'),
('030219', 'APURÍMAC', 'ANDAHUAYLAS', 'KAQUIABAMBA'),
('030220', 'APURÍMAC', 'ANDAHUAYLAS', 'JOSÉ MARÍA ARGUEDAS'),
('030301', 'APURÍMAC', 'ANTABAMBA', 'ANTABAMBA'),
('030302', 'APURÍMAC', 'ANTABAMBA', 'EL ORO'),
('030303', 'APURÍMAC', 'ANTABAMBA', 'HUAQUIRCA'),
('030304', 'APURÍMAC', 'ANTABAMBA', 'JUAN ESPINOZA MEDRANO'),
('030305', 'APURÍMAC', 'ANTABAMBA', 'OROPESA'),
('030306', 'APURÍMAC', 'ANTABAMBA', 'PACHACONAS'),
('030307', 'APURÍMAC', 'ANTABAMBA', 'SABAINO'),
('030401', 'APURÍMAC', 'AYMARAES', 'CHALHUANCA'),
('030402', 'APURÍMAC', 'AYMARAES', 'CAPAYA'),
('030403', 'APURÍMAC', 'AYMARAES', 'CARAYBAMBA'),
('030404', 'APURÍMAC', 'AYMARAES', 'CHAPIMARCA'),
('030405', 'APURÍMAC', 'AYMARAES', 'COLCABAMBA'),
('030406', 'APURÍMAC', 'AYMARAES', 'COTARUSE'),
('030407', 'APURÍMAC', 'AYMARAES', 'IHUAYLLO'),
('030408', 'APURÍMAC', 'AYMARAES', 'JUSTO APU SAHUARAURA'),
('030409', 'APURÍMAC', 'AYMARAES', 'LUCRE'),
('030410', 'APURÍMAC', 'AYMARAES', 'POCOHUANCA'),
('030411', 'APURÍMAC', 'AYMARAES', 'SAN JUAN DE CHACÑA'),
('030412', 'APURÍMAC', 'AYMARAES', 'SAÑAYCA'),
('030413', 'APURÍMAC', 'AYMARAES', 'SORAYA'),
('030414', 'APURÍMAC', 'AYMARAES', 'TAPAIRIHUA'),
('030415', 'APURÍMAC', 'AYMARAES', 'TINTAY'),
('030416', 'APURÍMAC', 'AYMARAES', 'TORAYA'),
('030417', 'APURÍMAC', 'AYMARAES', 'YANACA'),
('030501', 'APURÍMAC', 'COTABAMBAS', 'TAMBOBAMBA'),
('030502', 'APURÍMAC', 'COTABAMBAS', 'COTABAMBAS'),
('030503', 'APURÍMAC', 'COTABAMBAS', 'COYLLURQUI'),
('030504', 'APURÍMAC', 'COTABAMBAS', 'HAQUIRA'),
('030505', 'APURÍMAC', 'COTABAMBAS', 'MARA'),
('030506', 'APURÍMAC', 'COTABAMBAS', 'CHALLHUAHUACHO'),
('030601', 'APURÍMAC', 'CHINCHEROS', 'CHINCHEROS'),
('030602', 'APURÍMAC', 'CHINCHEROS', 'ANCO_HUALLO'),
('030603', 'APURÍMAC', 'CHINCHEROS', 'COCHARCAS'),
('030604', 'APURÍMAC', 'CHINCHEROS', 'HUACCANA'),
('030605', 'APURÍMAC', 'CHINCHEROS', 'OCOBAMBA'),
('030606', 'APURÍMAC', 'CHINCHEROS', 'ONGOY'),
('030607', 'APURÍMAC', 'CHINCHEROS', 'URANMARCA'),
('030608', 'APURÍMAC', 'CHINCHEROS', 'RANRACANCHA'),
('030609', 'APURÍMAC', 'CHINCHEROS', 'ROCCHACC'),
('030610', 'APURÍMAC', 'CHINCHEROS', 'EL PORVENIR'),
('030701', 'APURÍMAC', 'GRAU', 'CHUQUIBAMBILLA'),
('030702', 'APURÍMAC', 'GRAU', 'CURPAHUASI'),
('030703', 'APURÍMAC', 'GRAU', 'GAMARRA'),
('030704', 'APURÍMAC', 'GRAU', 'HUAYLLATI'),
('030705', 'APURÍMAC', 'GRAU', 'MAMARA'),
('030706', 'APURÍMAC', 'GRAU', 'MICAELA BASTIDAS'),
('030707', 'APURÍMAC', 'GRAU', 'PATAYPAMPA'),
('030708', 'APURÍMAC', 'GRAU', 'PROGRESO'),
('030709', 'APURÍMAC', 'GRAU', 'SAN ANTONIO'),
('030710', 'APURÍMAC', 'GRAU', 'SANTA ROSA'),
('030711', 'APURÍMAC', 'GRAU', 'TURPAY'),
('030712', 'APURÍMAC', 'GRAU', 'VILCABAMBA'),
('030713', 'APURÍMAC', 'GRAU', 'VIRUNDO'),
('030714', 'APURÍMAC', 'GRAU', 'CURASCO'),
('040101', 'AREQUIPA', 'AREQUIPA', 'AREQUIPA'),
('040102', 'AREQUIPA', 'AREQUIPA', 'ALTO SELVA ALEGRE'),
('040103', 'AREQUIPA', 'AREQUIPA', 'CAYMA'),
('040104', 'AREQUIPA', 'AREQUIPA', 'CERRO COLORADO'),
('040105', 'AREQUIPA', 'AREQUIPA', 'CHARACATO'),
('040106', 'AREQUIPA', 'AREQUIPA', 'CHIGUATA'),
('040107', 'AREQUIPA', 'AREQUIPA', 'JACOBO HUNTER'),
('040108', 'AREQUIPA', 'AREQUIPA', 'LA JOYA'),
('040109', 'AREQUIPA', 'AREQUIPA', 'MARIANO MELGAR'),
('040110', 'AREQUIPA', 'AREQUIPA', 'MIRAFLORES'),
('040111', 'AREQUIPA', 'AREQUIPA', 'MOLLEBAYA'),
('040112', 'AREQUIPA', 'AREQUIPA', 'PAUCARPATA'),
('040113', 'AREQUIPA', 'AREQUIPA', 'POCSI'),
('040114', 'AREQUIPA', 'AREQUIPA', 'POLOBAYA'),
('040115', 'AREQUIPA', 'AREQUIPA', 'QUEQUEÑA'),
('040116', 'AREQUIPA', 'AREQUIPA', 'SABANDIA'),
('040117', 'AREQUIPA', 'AREQUIPA', 'SACHACA'),
('040118', 'AREQUIPA', 'AREQUIPA', 'SAN JUAN DE SIGUAS'),
('040119', 'AREQUIPA', 'AREQUIPA', 'SAN JUAN DE TARUCANI'),
('040120', 'AREQUIPA', 'AREQUIPA', 'SANTA ISABEL DE SIGUAS'),
('040121', 'AREQUIPA', 'AREQUIPA', 'SANTA RITA DE SIGUAS'),
('040122', 'AREQUIPA', 'AREQUIPA', 'SOCABAYA'),
('040123', 'AREQUIPA', 'AREQUIPA', 'TIABAYA'),
('040124', 'AREQUIPA', 'AREQUIPA', 'UCHUMAYO'),
('040125', 'AREQUIPA', 'AREQUIPA', 'VITOR'),
('040126', 'AREQUIPA', 'AREQUIPA', 'YANAHUARA'),
('040127', 'AREQUIPA', 'AREQUIPA', 'YARABAMBA'),
('040128', 'AREQUIPA', 'AREQUIPA', 'YURA'),
('040129', 'AREQUIPA', 'AREQUIPA', 'JOSÉ LUIS BUSTAMANTE Y RIVERO'),
('040201', 'AREQUIPA', 'CAMANÁ', 'CAMANÁ'),
('040202', 'AREQUIPA', 'CAMANÁ', 'JOSÉ MARÍA QUIMPER'),
('040203', 'AREQUIPA', 'CAMANÁ', 'MARIANO NICOLÁS VALCÁRCEL'),
('040204', 'AREQUIPA', 'CAMANÁ', 'MARISCAL CÁCERES'),
('040205', 'AREQUIPA', 'CAMANÁ', 'NICOLÁS DE PIEROLA'),
('040206', 'AREQUIPA', 'CAMANÁ', 'OCOÑA'),
('040207', 'AREQUIPA', 'CAMANÁ', 'QUILCA'),
('040208', 'AREQUIPA', 'CAMANÁ', 'SAMUEL PASTOR'),
('040301', 'AREQUIPA', 'CARAVELÍ', 'CARAVELÍ'),
('040302', 'AREQUIPA', 'CARAVELÍ', 'ACARÍ'),
('040303', 'AREQUIPA', 'CARAVELÍ', 'ATICO'),
('040304', 'AREQUIPA', 'CARAVELÍ', 'ATIQUIPA'),
('040305', 'AREQUIPA', 'CARAVELÍ', 'BELLA UNIÓN'),
('040306', 'AREQUIPA', 'CARAVELÍ', 'CAHUACHO'),
('040307', 'AREQUIPA', 'CARAVELÍ', 'CHALA'),
('040308', 'AREQUIPA', 'CARAVELÍ', 'CHAPARRA'),
('040309', 'AREQUIPA', 'CARAVELÍ', 'HUANUHUANU'),
('040310', 'AREQUIPA', 'CARAVELÍ', 'JAQUI'),
('040311', 'AREQUIPA', 'CARAVELÍ', 'LOMAS'),
('040312', 'AREQUIPA', 'CARAVELÍ', 'QUICACHA'),
('040313', 'AREQUIPA', 'CARAVELÍ', 'YAUCA'),
('040401', 'AREQUIPA', 'CASTILLA', 'APLAO'),
('040402', 'AREQUIPA', 'CASTILLA', 'ANDAGUA'),
('040403', 'AREQUIPA', 'CASTILLA', 'AYO'),
('040404', 'AREQUIPA', 'CASTILLA', 'CHACHAS'),
('040405', 'AREQUIPA', 'CASTILLA', 'CHILCAYMARCA'),
('040406', 'AREQUIPA', 'CASTILLA', 'CHOCO'),
('040407', 'AREQUIPA', 'CASTILLA', 'HUANCARQUI'),
('040408', 'AREQUIPA', 'CASTILLA', 'MACHAGUAY'),
('040409', 'AREQUIPA', 'CASTILLA', 'ORCOPAMPA'),
('040410', 'AREQUIPA', 'CASTILLA', 'PAMPACOLCA'),
('040411', 'AREQUIPA', 'CASTILLA', 'TIPAN'),
('040412', 'AREQUIPA', 'CASTILLA', 'UÑON'),
('040413', 'AREQUIPA', 'CASTILLA', 'URACA'),
('040414', 'AREQUIPA', 'CASTILLA', 'VIRACO'),
('0405', 'AREQUIPA', 'CAYLLOMA', ''),
('040501', 'AREQUIPA', 'CAYLLOMA', 'CHIVAY'),
('040502', 'AREQUIPA', 'CAYLLOMA', 'ACHOMA'),
('040503', 'AREQUIPA', 'CAYLLOMA', 'CABANACONDE'),
('040504', 'AREQUIPA', 'CAYLLOMA', 'CALLALLI'),
('040505', 'AREQUIPA', 'CAYLLOMA', 'CAYLLOMA'),
('040506', 'AREQUIPA', 'CAYLLOMA', 'COPORAQUE'),
('040507', 'AREQUIPA', 'CAYLLOMA', 'HUAMBO'),
('040508', 'AREQUIPA', 'CAYLLOMA', 'HUANCA'),
('040509', 'AREQUIPA', 'CAYLLOMA', 'ICHUPAMPA'),
('040510', 'AREQUIPA', 'CAYLLOMA', 'LARI'),
('040511', 'AREQUIPA', 'CAYLLOMA', 'LLUTA'),
('040512', 'AREQUIPA', 'CAYLLOMA', 'MACA'),
('040513', 'AREQUIPA', 'CAYLLOMA', 'MADRIGAL'),
('040514', 'AREQUIPA', 'CAYLLOMA', 'SAN ANTONIO DE CHUCA'),
('040515', 'AREQUIPA', 'CAYLLOMA', 'SIBAYO'),
('040516', 'AREQUIPA', 'CAYLLOMA', 'TAPAY'),
('040517', 'AREQUIPA', 'CAYLLOMA', 'TISCO'),
('040518', 'AREQUIPA', 'CAYLLOMA', 'TUTI'),
('040519', 'AREQUIPA', 'CAYLLOMA', 'YANQUE'),
('040520', 'AREQUIPA', 'CAYLLOMA', 'MAJES'),
('040601', 'AREQUIPA', 'CONDESUYOS', 'CHUQUIBAMBA'),
('040602', 'AREQUIPA', 'CONDESUYOS', 'ANDARAY'),
('040603', 'AREQUIPA', 'CONDESUYOS', 'CAYARANI'),
('040604', 'AREQUIPA', 'CONDESUYOS', 'CHICHAS'),
('040605', 'AREQUIPA', 'CONDESUYOS', 'IRAY'),
('040606', 'AREQUIPA', 'CONDESUYOS', 'RÍO GRANDE'),
('040607', 'AREQUIPA', 'CONDESUYOS', 'SALAMANCA'),
('040608', 'AREQUIPA', 'CONDESUYOS', 'YANAQUIHUA'),
('040701', 'AREQUIPA', 'ISLAY', 'MOLLENDO'),
('040702', 'AREQUIPA', 'ISLAY', 'COCACHACRA'),
('040703', 'AREQUIPA', 'ISLAY', 'DEAN VALDIVIA'),
('040704', 'AREQUIPA', 'ISLAY', 'ISLAY'),
('040705', 'AREQUIPA', 'ISLAY', 'MEJIA'),
('040706', 'AREQUIPA', 'ISLAY', 'PUNTA DE BOMBÓN'),
('040801', 'AREQUIPA', 'LA UNIÒN', 'COTAHUASI'),
('040802', 'AREQUIPA', 'LA UNIÒN', 'ALCA'),
('040803', 'AREQUIPA', 'LA UNIÒN', 'CHARCANA'),
('040804', 'AREQUIPA', 'LA UNIÒN', 'HUAYNACOTAS'),
('040805', 'AREQUIPA', 'LA UNIÒN', 'PAMPAMARCA'),
('040806', 'AREQUIPA', 'LA UNIÒN', 'PUYCA'),
('040807', 'AREQUIPA', 'LA UNIÒN', 'QUECHUALLA'),
('040808', 'AREQUIPA', 'LA UNIÒN', 'SAYLA'),
('040809', 'AREQUIPA', 'LA UNIÒN', 'TAURIA'),
('040810', 'AREQUIPA', 'LA UNIÒN', 'TOMEPAMPA'),
('040811', 'AREQUIPA', 'LA UNIÒN', 'TORO'),
('050101', 'AYACUCHO', 'HUAMANGA', 'AYACUCHO'),
('050102', 'AYACUCHO', 'HUAMANGA', 'ACOCRO'),
('050103', 'AYACUCHO', 'HUAMANGA', 'ACOS VINCHOS'),
('050104', 'AYACUCHO', 'HUAMANGA', 'CARMEN ALTO'),
('050105', 'AYACUCHO', 'HUAMANGA', 'CHIARA'),
('050106', 'AYACUCHO', 'HUAMANGA', 'OCROS'),
('050107', 'AYACUCHO', 'HUAMANGA', 'PACAYCASA'),
('050108', 'AYACUCHO', 'HUAMANGA', 'QUINUA'),
('050109', 'AYACUCHO', 'HUAMANGA', 'SAN JOSÉ DE TICLLAS'),
('050110', 'AYACUCHO', 'HUAMANGA', 'SAN JUAN BAUTISTA'),
('050111', 'AYACUCHO', 'HUAMANGA', 'SANTIAGO DE PISCHA'),
('050112', 'AYACUCHO', 'HUAMANGA', 'SOCOS'),
('050113', 'AYACUCHO', 'HUAMANGA', 'TAMBILLO'),
('050114', 'AYACUCHO', 'HUAMANGA', 'VINCHOS'),
('050115', 'AYACUCHO', 'HUAMANGA', 'JESÚS NAZARENO'),
('050116', 'AYACUCHO', 'HUAMANGA', 'ANDRÉS AVELINO CÁCERES DORREGARAY'),
('050201', 'AYACUCHO', 'CANGALLO', 'CANGALLO'),
('050202', 'AYACUCHO', 'CANGALLO', 'CHUSCHI'),
('050203', 'AYACUCHO', 'CANGALLO', 'LOS MOROCHUCOS'),
('050204', 'AYACUCHO', 'CANGALLO', 'MARÍA PARADO DE BELLIDO'),
('050205', 'AYACUCHO', 'CANGALLO', 'PARAS'),
('050206', 'AYACUCHO', 'CANGALLO', 'TOTOS'),
('050301', 'AYACUCHO', 'HUANCA SANCOS', 'SANCOS'),
('050302', 'AYACUCHO', 'HUANCA SANCOS', 'CARAPO'),
('050303', 'AYACUCHO', 'HUANCA SANCOS', 'SACSAMARCA'),
('050304', 'AYACUCHO', 'HUANCA SANCOS', 'SANTIAGO DE LUCANAMARCA'),
('050401', 'AYACUCHO', 'HUANTA', 'HUANTA'),
('050402', 'AYACUCHO', 'HUANTA', 'AYAHUANCO'),
('050403', 'AYACUCHO', 'HUANTA', 'HUAMANGUILLA'),
('050404', 'AYACUCHO', 'HUANTA', 'IGUAIN'),
('050405', 'AYACUCHO', 'HUANTA', 'LURICOCHA'),
('050406', 'AYACUCHO', 'HUANTA', 'SANTILLANA'),
('050407', 'AYACUCHO', 'HUANTA', 'SIVIA'),
('050408', 'AYACUCHO', 'HUANTA', 'LLOCHEGUA'),
('050409', 'AYACUCHO', 'HUANTA', 'CANAYRE'),
('050410', 'AYACUCHO', 'HUANTA', 'UCHURACCAY'),
('050411', 'AYACUCHO', 'HUANTA', 'PUCACOLPA'),
('050412', 'AYACUCHO', 'HUANTA', 'CHACA'),
('050501', 'AYACUCHO', 'LA MAR', 'SAN MIGUEL'),
('050502', 'AYACUCHO', 'LA MAR', 'ANCO'),
('050503', 'AYACUCHO', 'LA MAR', 'AYNA'),
('050504', 'AYACUCHO', 'LA MAR', 'CHILCAS'),
('050505', 'AYACUCHO', 'LA MAR', 'CHUNGUI'),
('050506', 'AYACUCHO', 'LA MAR', 'LUIS CARRANZA'),
('050507', 'AYACUCHO', 'LA MAR', 'SANTA ROSA'),
('050508', 'AYACUCHO', 'LA MAR', 'TAMBO'),
('050509', 'AYACUCHO', 'LA MAR', 'SAMUGARI'),
('050510', 'AYACUCHO', 'LA MAR', 'ANCHIHUAY'),
('050601', 'AYACUCHO', 'LUCANAS', 'PUQUIO'),
('050602', 'AYACUCHO', 'LUCANAS', 'AUCARA'),
('050603', 'AYACUCHO', 'LUCANAS', 'CABANA'),
('050604', 'AYACUCHO', 'LUCANAS', 'CARMEN SALCEDO'),
('050605', 'AYACUCHO', 'LUCANAS', 'CHAVIÑA'),
('050606', 'AYACUCHO', 'LUCANAS', 'CHIPAO'),
('050607', 'AYACUCHO', 'LUCANAS', 'HUAC-HUAS'),
('050608', 'AYACUCHO', 'LUCANAS', 'LARAMATE'),
('050609', 'AYACUCHO', 'LUCANAS', 'LEONCIO PRADO'),
('050610', 'AYACUCHO', 'LUCANAS', 'LLAUTA'),
('050611', 'AYACUCHO', 'LUCANAS', 'LUCANAS'),
('050612', 'AYACUCHO', 'LUCANAS', 'OCAÑA'),
('050613', 'AYACUCHO', 'LUCANAS', 'OTOCA'),
('050614', 'AYACUCHO', 'LUCANAS', 'SAISA'),
('050615', 'AYACUCHO', 'LUCANAS', 'SAN CRISTÓBAL'),
('050616', 'AYACUCHO', 'LUCANAS', 'SAN JUAN'),
('050617', 'AYACUCHO', 'LUCANAS', 'SAN PEDRO'),
('050618', 'AYACUCHO', 'LUCANAS', 'SAN PEDRO DE PALCO'),
('050619', 'AYACUCHO', 'LUCANAS', 'SANCOS'),
('050620', 'AYACUCHO', 'LUCANAS', 'SANTA ANA DE HUAYCAHUACHO'),
('050621', 'AYACUCHO', 'LUCANAS', 'SANTA LUCIA'),
('050701', 'AYACUCHO', 'PARINACOCHAS', 'CORACORA'),
('050702', 'AYACUCHO', 'PARINACOCHAS', 'CHUMPI'),
('050703', 'AYACUCHO', 'PARINACOCHAS', 'CORONEL CASTAÑEDA'),
('050704', 'AYACUCHO', 'PARINACOCHAS', 'PACAPAUSA'),
('050705', 'AYACUCHO', 'PARINACOCHAS', 'PULLO'),
('050706', 'AYACUCHO', 'PARINACOCHAS', 'PUYUSCA'),
('050707', 'AYACUCHO', 'PARINACOCHAS', 'SAN FRANCISCO DE RAVACAYCO'),
('050708', 'AYACUCHO', 'PARINACOCHAS', 'UPAHUACHO'),
('050801', 'AYACUCHO', 'PÀUCAR DEL SARA SARA', 'PAUSA'),
('050802', 'AYACUCHO', 'PÀUCAR DEL SARA SARA', 'COLTA'),
('050803', 'AYACUCHO', 'PÀUCAR DEL SARA SARA', 'CORCULLA'),
('050804', 'AYACUCHO', 'PÀUCAR DEL SARA SARA', 'LAMPA'),
('050805', 'AYACUCHO', 'PÀUCAR DEL SARA SARA', 'MARCABAMBA'),
('050806', 'AYACUCHO', 'PÀUCAR DEL SARA SARA', 'OYOLO'),
('050807', 'AYACUCHO', 'PÀUCAR DEL SARA SARA', 'PARARCA'),
('050808', 'AYACUCHO', 'PÀUCAR DEL SARA SARA', 'SAN JAVIER DE ALPABAMBA'),
('050809', 'AYACUCHO', 'PÀUCAR DEL SARA SARA', 'SAN JOSÉ DE USHUA'),
('050810', 'AYACUCHO', 'PÀUCAR DEL SARA SARA', 'SARA SARA'),
('050901', 'AYACUCHO', 'SUCRE', 'QUEROBAMBA'),
('050902', 'AYACUCHO', 'SUCRE', 'BELÉN'),
('050903', 'AYACUCHO', 'SUCRE', 'CHALCOS'),
('050904', 'AYACUCHO', 'SUCRE', 'CHILCAYOC'),
('050905', 'AYACUCHO', 'SUCRE', 'HUACAÑA'),
('050906', 'AYACUCHO', 'SUCRE', 'MORCOLLA'),
('050907', 'AYACUCHO', 'SUCRE', 'PAICO'),
('050908', 'AYACUCHO', 'SUCRE', 'SAN PEDRO DE LARCAY'),
('050909', 'AYACUCHO', 'SUCRE', 'SAN SALVADOR DE QUIJE'),
('050910', 'AYACUCHO', 'SUCRE', 'SANTIAGO DE PAUCARAY'),
('050911', 'AYACUCHO', 'SUCRE', 'SORAS'),
('051001', 'AYACUCHO', 'VÍCTOR FAJARDO', 'HUANCAPI'),
('051002', 'AYACUCHO', 'VÍCTOR FAJARDO', 'ALCAMENCA'),
('051003', 'AYACUCHO', 'VÍCTOR FAJARDO', 'APONGO'),
('051004', 'AYACUCHO', 'VÍCTOR FAJARDO', 'ASQUIPATA'),
('051005', 'AYACUCHO', 'VÍCTOR FAJARDO', 'CANARIA'),
('051006', 'AYACUCHO', 'VÍCTOR FAJARDO', 'CAYARA'),
('051007', 'AYACUCHO', 'VÍCTOR FAJARDO', 'COLCA'),
('051008', 'AYACUCHO', 'VÍCTOR FAJARDO', 'HUAMANQUIQUIA'),
('051009', 'AYACUCHO', 'VÍCTOR FAJARDO', 'HUANCARAYLLA'),
('051010', 'AYACUCHO', 'VÍCTOR FAJARDO', 'HUAYA'),
('051011', 'AYACUCHO', 'VÍCTOR FAJARDO', 'SARHUA'),
('051012', 'AYACUCHO', 'VÍCTOR FAJARDO', 'VILCANCHOS'),
('051101', 'AYACUCHO', 'VILCAS HUAMÁN', 'VILCAS HUAMAN'),
('051102', 'AYACUCHO', 'VILCAS HUAMÁN', 'ACCOMARCA'),
('051103', 'AYACUCHO', 'VILCAS HUAMÁN', 'CARHUANCA'),
('051104', 'AYACUCHO', 'VILCAS HUAMÁN', 'CONCEPCIÓN'),
('051105', 'AYACUCHO', 'VILCAS HUAMÁN', 'HUAMBALPA'),
('051106', 'AYACUCHO', 'VILCAS HUAMÁN', 'INDEPENDENCIA'),
('051107', 'AYACUCHO', 'VILCAS HUAMÁN', 'SAURAMA'),
('051108', 'AYACUCHO', 'VILCAS HUAMÁN', 'VISCHONGO'),
('060101', 'CAJAMARCA', 'CAJAMARCA', 'CAJAMARCA'),
('060102', 'CAJAMARCA', 'CAJAMARCA', 'ASUNCIÓN'),
('060103', 'CAJAMARCA', 'CAJAMARCA', 'CHETILLA'),
('060104', 'CAJAMARCA', 'CAJAMARCA', 'COSPAN'),
('060105', 'CAJAMARCA', 'CAJAMARCA', 'ENCAÑADA'),
('060106', 'CAJAMARCA', 'CAJAMARCA', 'JESÚS'),
('060107', 'CAJAMARCA', 'CAJAMARCA', 'LLACANORA'),
('060108', 'CAJAMARCA', 'CAJAMARCA', 'LOS BAÑOS DEL INCA'),
('060109', 'CAJAMARCA', 'CAJAMARCA', 'MAGDALENA'),
('060110', 'CAJAMARCA', 'CAJAMARCA', 'MATARA'),
('060111', 'CAJAMARCA', 'CAJAMARCA', 'NAMORA'),
('060112', 'CAJAMARCA', 'CAJAMARCA', 'SAN JUAN'),
('060201', 'CAJAMARCA', 'CAJABAMBA', 'CAJABAMBA'),
('060202', 'CAJAMARCA', 'CAJABAMBA', 'CACHACHI'),
('060203', 'CAJAMARCA', 'CAJABAMBA', 'CONDEBAMBA'),
('060204', 'CAJAMARCA', 'CAJABAMBA', 'SITACOCHA'),
('060301', 'CAJAMARCA', 'CELENDÍN', 'CELENDÍN'),
('060302', 'CAJAMARCA', 'CELENDÍN', 'CHUMUCH'),
('060303', 'CAJAMARCA', 'CELENDÍN', 'CORTEGANA'),
('060304', 'CAJAMARCA', 'CELENDÍN', 'HUASMIN'),
('060305', 'CAJAMARCA', 'CELENDÍN', 'JORGE CHÁVEZ'),
('060306', 'CAJAMARCA', 'CELENDÍN', 'JOSÉ GÁLVEZ'),
('060307', 'CAJAMARCA', 'CELENDÍN', 'MIGUEL IGLESIAS'),
('060308', 'CAJAMARCA', 'CELENDÍN', 'OXAMARCA'),
('060309', 'CAJAMARCA', 'CELENDÍN', 'SOROCHUCO'),
('060310', 'CAJAMARCA', 'CELENDÍN', 'SUCRE'),
('060311', 'CAJAMARCA', 'CELENDÍN', 'UTCO'),
('060312', 'CAJAMARCA', 'CELENDÍN', 'LA LIBERTAD DE PALLAN'),
('060401', 'CAJAMARCA', 'CHOTA', 'CHOTA'),
('060402', 'CAJAMARCA', 'CHOTA', 'ANGUIA'),
('060403', 'CAJAMARCA', 'CHOTA', 'CHADIN'),
('060404', 'CAJAMARCA', 'CHOTA', 'CHIGUIRIP'),
('060405', 'CAJAMARCA', 'CHOTA', 'CHIMBAN'),
('060406', 'CAJAMARCA', 'CHOTA', 'CHOROPAMPA'),
('060407', 'CAJAMARCA', 'CHOTA', 'COCHABAMBA'),
('060408', 'CAJAMARCA', 'CHOTA', 'CONCHAN'),
('060409', 'CAJAMARCA', 'CHOTA', 'HUAMBOS'),
('060410', 'CAJAMARCA', 'CHOTA', 'LAJAS'),
('060411', 'CAJAMARCA', 'CHOTA', 'LLAMA'),
('060412', 'CAJAMARCA', 'CHOTA', 'MIRACOSTA'),
('060413', 'CAJAMARCA', 'CHOTA', 'PACCHA'),
('060414', 'CAJAMARCA', 'CHOTA', 'PION'),
('060415', 'CAJAMARCA', 'CHOTA', 'QUEROCOTO'),
('060416', 'CAJAMARCA', 'CHOTA', 'SAN JUAN DE LICUPIS'),
('060417', 'CAJAMARCA', 'CHOTA', 'TACABAMBA'),
('060418', 'CAJAMARCA', 'CHOTA', 'TOCMOCHE'),
('060419', 'CAJAMARCA', 'CHOTA', 'CHALAMARCA'),
('060501', 'CAJAMARCA', 'CONTUMAZÁ', 'CONTUMAZA'),
('060502', 'CAJAMARCA', 'CONTUMAZÁ', 'CHILETE'),
('060503', 'CAJAMARCA', 'CONTUMAZÁ', 'CUPISNIQUE'),
('060504', 'CAJAMARCA', 'CONTUMAZÁ', 'GUZMANGO'),
('060505', 'CAJAMARCA', 'CONTUMAZÁ', 'SAN BENITO'),
('060506', 'CAJAMARCA', 'CONTUMAZÁ', 'SANTA CRUZ DE TOLEDO'),
('060507', 'CAJAMARCA', 'CONTUMAZÁ', 'TANTARICA'),
('060508', 'CAJAMARCA', 'CONTUMAZÁ', 'YONAN'),
('060601', 'CAJAMARCA', 'CUTERVO', 'CUTERVO'),
('060602', 'CAJAMARCA', 'CUTERVO', 'CALLAYUC'),
('060603', 'CAJAMARCA', 'CUTERVO', 'CHOROS'),
('060604', 'CAJAMARCA', 'CUTERVO', 'CUJILLO'),
('060605', 'CAJAMARCA', 'CUTERVO', 'LA RAMADA'),
('060606', 'CAJAMARCA', 'CUTERVO', 'PIMPINGOS'),
('060607', 'CAJAMARCA', 'CUTERVO', 'QUEROCOTILLO'),
('060608', 'CAJAMARCA', 'CUTERVO', 'SAN ANDRÉS DE CUTERVO'),
('060609', 'CAJAMARCA', 'CUTERVO', 'SAN JUAN DE CUTERVO'),
('060610', 'CAJAMARCA', 'CUTERVO', 'SAN LUIS DE LUCMA'),
('060611', 'CAJAMARCA', 'CUTERVO', 'SANTA CRUZ'),
('060612', 'CAJAMARCA', 'CUTERVO', 'SANTO DOMINGO DE LA CAPILLA'),
('060613', 'CAJAMARCA', 'CUTERVO', 'SANTO TOMAS'),
('060614', 'CAJAMARCA', 'CUTERVO', 'SOCOTA'),
('060615', 'CAJAMARCA', 'CUTERVO', 'TORIBIO CASANOVA'),
('060701', 'CAJAMARCA', 'HUALGAYOC', 'BAMBAMARCA'),
('060702', 'CAJAMARCA', 'HUALGAYOC', 'CHUGUR'),
('060703', 'CAJAMARCA', 'HUALGAYOC', 'HUALGAYOC'),
('060801', 'CAJAMARCA', 'JAÉN', 'JAÉN'),
('060802', 'CAJAMARCA', 'JAÉN', 'BELLAVISTA'),
('060803', 'CAJAMARCA', 'JAÉN', 'CHONTALI'),
('060804', 'CAJAMARCA', 'JAÉN', 'COLASAY'),
('060805', 'CAJAMARCA', 'JAÉN', 'HUABAL'),
('060806', 'CAJAMARCA', 'JAÉN', 'LAS PIRIAS'),
('060807', 'CAJAMARCA', 'JAÉN', 'POMAHUACA'),
('060808', 'CAJAMARCA', 'JAÉN', 'PUCARA'),
('060809', 'CAJAMARCA', 'JAÉN', 'SALLIQUE'),
('060810', 'CAJAMARCA', 'JAÉN', 'SAN FELIPE'),
('060811', 'CAJAMARCA', 'JAÉN', 'SAN JOSÉ DEL ALTO'),
('060812', 'CAJAMARCA', 'JAÉN', 'SANTA ROSA'),
('060901', 'CAJAMARCA', 'SAN IGNACIO', 'SAN IGNACIO'),
('060902', 'CAJAMARCA', 'SAN IGNACIO', 'CHIRINOS'),
('060903', 'CAJAMARCA', 'SAN IGNACIO', 'HUARANGO'),
('060904', 'CAJAMARCA', 'SAN IGNACIO', 'LA COIPA'),
('060905', 'CAJAMARCA', 'SAN IGNACIO', 'NAMBALLE'),
('060906', 'CAJAMARCA', 'SAN IGNACIO', 'SAN JOSÉ DE LOURDES'),
('060907', 'CAJAMARCA', 'SAN IGNACIO', 'TABACONAS'),
('061001', 'CAJAMARCA', 'SAN MARCOS', 'PEDRO GÁLVEZ'),
('061002', 'CAJAMARCA', 'SAN MARCOS', 'CHANCAY'),
('061003', 'CAJAMARCA', 'SAN MARCOS', 'EDUARDO VILLANUEVA'),
('061004', 'CAJAMARCA', 'SAN MARCOS', 'GREGORIO PITA'),
('061005', 'CAJAMARCA', 'SAN MARCOS', 'ICHOCAN'),
('061006', 'CAJAMARCA', 'SAN MARCOS', 'JOSÉ MANUEL QUIROZ'),
('061007', 'CAJAMARCA', 'SAN MARCOS', 'JOSÉ SABOGAL'),
('061101', 'CAJAMARCA', 'SAN MIGUEL', 'SAN MIGUEL'),
('061102', 'CAJAMARCA', 'SAN MIGUEL', 'BOLÍVAR'),
('061103', 'CAJAMARCA', 'SAN MIGUEL', 'CALQUIS'),
('061104', 'CAJAMARCA', 'SAN MIGUEL', 'CATILLUC'),
('061105', 'CAJAMARCA', 'SAN MIGUEL', 'EL PRADO'),
('061106', 'CAJAMARCA', 'SAN MIGUEL', 'LA FLORIDA'),
('061107', 'CAJAMARCA', 'SAN MIGUEL', 'LLAPA'),
('061108', 'CAJAMARCA', 'SAN MIGUEL', 'NANCHOC'),
('061109', 'CAJAMARCA', 'SAN MIGUEL', 'NIEPOS'),
('061110', 'CAJAMARCA', 'SAN MIGUEL', 'SAN GREGORIO'),
('061111', 'CAJAMARCA', 'SAN MIGUEL', 'SAN SILVESTRE DE COCHAN'),
('061112', 'CAJAMARCA', 'SAN MIGUEL', 'TONGOD'),
('061113', 'CAJAMARCA', 'SAN MIGUEL', 'UNIÓN AGUA BLANCA'),
('061201', 'CAJAMARCA', 'SAN PABLO', 'SAN PABLO'),
('061202', 'CAJAMARCA', 'SAN PABLO', 'SAN BERNARDINO'),
('061203', 'CAJAMARCA', 'SAN PABLO', 'SAN LUIS'),
('061204', 'CAJAMARCA', 'SAN PABLO', 'TUMBADEN'),
('061301', 'CAJAMARCA', 'SANTA CRUZ', 'SANTA CRUZ'),
('061302', 'CAJAMARCA', 'SANTA CRUZ', 'ANDABAMBA'),
('061303', 'CAJAMARCA', 'SANTA CRUZ', 'CATACHE'),
('061304', 'CAJAMARCA', 'SANTA CRUZ', 'CHANCAYBAÑOS'),
('061305', 'CAJAMARCA', 'SANTA CRUZ', 'LA ESPERANZA'),
('061306', 'CAJAMARCA', 'SANTA CRUZ', 'NINABAMBA'),
('061307', 'CAJAMARCA', 'SANTA CRUZ', 'PULAN'),
('061308', 'CAJAMARCA', 'SANTA CRUZ', 'SAUCEPAMPA'),
('061309', 'CAJAMARCA', 'SANTA CRUZ', 'SEXI'),
('061310', 'CAJAMARCA', 'SANTA CRUZ', 'UTICYACU'),
('061311', 'CAJAMARCA', 'SANTA CRUZ', 'YAUYUCAN'),
('070101', 'CALLAO', 'PROV. CONST. DEL CALLAO', 'CALLAO'),
('070102', 'CALLAO', 'PROV. CONST. DEL CALLAO', 'BELLAVISTA'),
('070103', 'CALLAO', 'PROV. CONST. DEL CALLAO', 'CARMEN DE LA LEGUA REYNOSO'),
('070104', 'CALLAO', 'PROV. CONST. DEL CALLAO', 'LA PERLA'),
('070105', 'CALLAO', 'PROV. CONST. DEL CALLAO', 'LA PUNTA'),
('070106', 'CALLAO', 'PROV. CONST. DEL CALLAO', 'VENTANILLA'),
('070107', 'CALLAO', 'PROV. CONST. DEL CALLAO', 'MI PERÚ'),
('080101', 'CUSCO', 'CUSCO', 'CUSCO'),
('080102', 'CUSCO', 'CUSCO', 'CCORCA'),
('080103', 'CUSCO', 'CUSCO', 'POROY'),
('080104', 'CUSCO', 'CUSCO', 'SAN JERÓNIMO'),
('080105', 'CUSCO', 'CUSCO', 'SAN SEBASTIAN'),
('080106', 'CUSCO', 'CUSCO', 'SANTIAGO'),
('080107', 'CUSCO', 'CUSCO', 'SAYLLA'),
('080108', 'CUSCO', 'CUSCO', 'WANCHAQ'),
('080201', 'CUSCO', 'ACOMAYO', 'ACOMAYO'),
('080202', 'CUSCO', 'ACOMAYO', 'ACOPIA'),
('080203', 'CUSCO', 'ACOMAYO', 'ACOS'),
('080204', 'CUSCO', 'ACOMAYO', 'MOSOC LLACTA'),
('080205', 'CUSCO', 'ACOMAYO', 'POMACANCHI'),
('080206', 'CUSCO', 'ACOMAYO', 'RONDOCAN'),
('080207', 'CUSCO', 'ACOMAYO', 'SANGARARA'),
('080301', 'CUSCO', 'ANTA', 'ANTA'),
('080302', 'CUSCO', 'ANTA', 'ANCAHUASI'),
('080303', 'CUSCO', 'ANTA', 'CACHIMAYO'),
('080304', 'CUSCO', 'ANTA', 'CHINCHAYPUJIO'),
('080305', 'CUSCO', 'ANTA', 'HUAROCONDO'),
('080306', 'CUSCO', 'ANTA', 'LIMATAMBO'),
('080307', 'CUSCO', 'ANTA', 'MOLLEPATA'),
('080308', 'CUSCO', 'ANTA', 'PUCYURA'),
('080309', 'CUSCO', 'ANTA', 'ZURITE'),
('080401', 'CUSCO', 'CALCA', 'CALCA'),
('080402', 'CUSCO', 'CALCA', 'COYA'),
('080403', 'CUSCO', 'CALCA', 'LAMAY'),
('080404', 'CUSCO', 'CALCA', 'LARES'),
('080405', 'CUSCO', 'CALCA', 'PISAC'),
('080406', 'CUSCO', 'CALCA', 'SAN SALVADOR'),
('080407', 'CUSCO', 'CALCA', 'TARAY'),
('080408', 'CUSCO', 'CALCA', 'YANATILE'),
('080501', 'CUSCO', 'CANAS', 'YANAOCA'),
('080502', 'CUSCO', 'CANAS', 'CHECCA'),
('080503', 'CUSCO', 'CANAS', 'KUNTURKANKI'),
('080504', 'CUSCO', 'CANAS', 'LANGUI'),
('080505', 'CUSCO', 'CANAS', 'LAYO'),
('080506', 'CUSCO', 'CANAS', 'PAMPAMARCA'),
('080507', 'CUSCO', 'CANAS', 'QUEHUE'),
('080508', 'CUSCO', 'CANAS', 'TUPAC AMARU'),
('080601', 'CUSCO', 'CANCHIS', 'SICUANI'),
('080602', 'CUSCO', 'CANCHIS', 'CHECACUPE'),
('080603', 'CUSCO', 'CANCHIS', 'COMBAPATA'),
('080604', 'CUSCO', 'CANCHIS', 'MARANGANI'),
('080605', 'CUSCO', 'CANCHIS', 'PITUMARCA'),
('080606', 'CUSCO', 'CANCHIS', 'SAN PABLO'),
('080607', 'CUSCO', 'CANCHIS', 'SAN PEDRO'),
('080608', 'CUSCO', 'CANCHIS', 'TINTA'),
('080701', 'CUSCO', 'CHUMBIVILCAS', 'SANTO TOMAS'),
('080702', 'CUSCO', 'CHUMBIVILCAS', 'CAPACMARCA'),
('080703', 'CUSCO', 'CHUMBIVILCAS', 'CHAMACA'),
('080704', 'CUSCO', 'CHUMBIVILCAS', 'COLQUEMARCA'),
('080705', 'CUSCO', 'CHUMBIVILCAS', 'LIVITACA'),
('080706', 'CUSCO', 'CHUMBIVILCAS', 'LLUSCO'),
('080707', 'CUSCO', 'CHUMBIVILCAS', 'QUIÑOTA'),
('080708', 'CUSCO', 'CHUMBIVILCAS', 'VELILLE'),
('080801', 'CUSCO', 'ESPINAR', 'ESPINAR'),
('080802', 'CUSCO', 'ESPINAR', 'CONDOROMA'),
('080803', 'CUSCO', 'ESPINAR', 'COPORAQUE'),
('080804', 'CUSCO', 'ESPINAR', 'OCORURO'),
('080805', 'CUSCO', 'ESPINAR', 'PALLPATA'),
('080806', 'CUSCO', 'ESPINAR', 'PICHIGUA'),
('080807', 'CUSCO', 'ESPINAR', 'SUYCKUTAMBO'),
('080808', 'CUSCO', 'ESPINAR', 'ALTO PICHIGUA'),
('080901', 'CUSCO', 'LA CONVENCIÓN', 'SANTA ANA'),
('080902', 'CUSCO', 'LA CONVENCIÓN', 'ECHARATE'),
('080903', 'CUSCO', 'LA CONVENCIÓN', 'HUAYOPATA'),
('080904', 'CUSCO', 'LA CONVENCIÓN', 'MARANURA'),
('080905', 'CUSCO', 'LA CONVENCIÓN', 'OCOBAMBA'),
('080906', 'CUSCO', 'LA CONVENCIÓN', 'QUELLOUNO'),
('080907', 'CUSCO', 'LA CONVENCIÓN', 'KIMBIRI'),
('080908', 'CUSCO', 'LA CONVENCIÓN', 'SANTA TERESA'),
('080909', 'CUSCO', 'LA CONVENCIÓN', 'VILCABAMBA'),
('080910', 'CUSCO', 'LA CONVENCIÓN', 'PICHARI'),
('080911', 'CUSCO', 'LA CONVENCIÓN', 'INKAWASI'),
('080912', 'CUSCO', 'LA CONVENCIÓN', 'VILLA VIRGEN'),
('080913', 'CUSCO', 'LA CONVENCIÓN', 'VILLA KINTIARINA'),
('081001', 'CUSCO', 'PARURO', 'PARURO'),
('081002', 'CUSCO', 'PARURO', 'ACCHA'),
('081003', 'CUSCO', 'PARURO', 'CCAPI'),
('081004', 'CUSCO', 'PARURO', 'COLCHA'),
('081005', 'CUSCO', 'PARURO', 'HUANOQUITE'),
('081006', 'CUSCO', 'PARURO', 'OMACHA'),
('081007', 'CUSCO', 'PARURO', 'PACCARITAMBO'),
('081008', 'CUSCO', 'PARURO', 'PILLPINTO'),
('081009', 'CUSCO', 'PARURO', 'YAURISQUE'),
('081101', 'CUSCO', 'PAUCARTAMBO', 'PAUCARTAMBO'),
('081102', 'CUSCO', 'PAUCARTAMBO', 'CAICAY'),
('081103', 'CUSCO', 'PAUCARTAMBO', 'CHALLABAMBA'),
('081104', 'CUSCO', 'PAUCARTAMBO', 'COLQUEPATA'),
('081105', 'CUSCO', 'PAUCARTAMBO', 'HUANCARANI'),
('081106', 'CUSCO', 'PAUCARTAMBO', 'KOSÑIPATA'),
('081201', 'CUSCO', 'QUISPICANCHI', 'URCOS'),
('081202', 'CUSCO', 'QUISPICANCHI', 'ANDAHUAYLILLAS'),
('081203', 'CUSCO', 'QUISPICANCHI', 'CAMANTI'),
('081204', 'CUSCO', 'QUISPICANCHI', 'CCARHUAYO'),
('081205', 'CUSCO', 'QUISPICANCHI', 'CCATCA'),
('081206', 'CUSCO', 'QUISPICANCHI', 'CUSIPATA'),
('081207', 'CUSCO', 'QUISPICANCHI', 'HUARO'),
('081208', 'CUSCO', 'QUISPICANCHI', 'LUCRE'),
('081209', 'CUSCO', 'QUISPICANCHI', 'MARCAPATA'),
('081210', 'CUSCO', 'QUISPICANCHI', 'OCONGATE'),
('081211', 'CUSCO', 'QUISPICANCHI', 'OROPESA'),
('081212', 'CUSCO', 'QUISPICANCHI', 'QUIQUIJANA'),
('081301', 'CUSCO', 'URUBAMBA', 'URUBAMBA'),
('081302', 'CUSCO', 'URUBAMBA', 'CHINCHERO'),
('081303', 'CUSCO', 'URUBAMBA', 'HUAYLLABAMBA'),
('081304', 'CUSCO', 'URUBAMBA', 'MACHUPICCHU'),
('081305', 'CUSCO', 'URUBAMBA', 'MARAS'),
('081306', 'CUSCO', 'URUBAMBA', 'OLLANTAYTAMBO'),
('081307', 'CUSCO', 'URUBAMBA', 'YUCAY'),
('090101', 'HUANCAVELICA', 'HUANCAVELICA', 'HUANCAVELICA'),
('090102', 'HUANCAVELICA', 'HUANCAVELICA', 'ACOBAMBILLA'),
('090103', 'HUANCAVELICA', 'HUANCAVELICA', 'ACORIA'),
('090104', 'HUANCAVELICA', 'HUANCAVELICA', 'CONAYCA'),
('090105', 'HUANCAVELICA', 'HUANCAVELICA', 'CUENCA'),
('090106', 'HUANCAVELICA', 'HUANCAVELICA', 'HUACHOCOLPA'),
('090107', 'HUANCAVELICA', 'HUANCAVELICA', 'HUAYLLAHUARA'),
('090108', 'HUANCAVELICA', 'HUANCAVELICA', 'IZCUCHACA'),
('090109', 'HUANCAVELICA', 'HUANCAVELICA', 'LARIA'),
('090110', 'HUANCAVELICA', 'HUANCAVELICA', 'MANTA'),
('090111', 'HUANCAVELICA', 'HUANCAVELICA', 'MARISCAL CÁCERES'),
('090112', 'HUANCAVELICA', 'HUANCAVELICA', 'MOYA'),
('090113', 'HUANCAVELICA', 'HUANCAVELICA', 'NUEVO OCCORO'),
('090114', 'HUANCAVELICA', 'HUANCAVELICA', 'PALCA'),
('090115', 'HUANCAVELICA', 'HUANCAVELICA', 'PILCHACA'),
('090116', 'HUANCAVELICA', 'HUANCAVELICA', 'VILCA'),
('090117', 'HUANCAVELICA', 'HUANCAVELICA', 'YAULI'),
('090118', 'HUANCAVELICA', 'HUANCAVELICA', 'ASCENSIÓN'),
('090119', 'HUANCAVELICA', 'HUANCAVELICA', 'HUANDO'),
('090201', 'HUANCAVELICA', 'ACOBAMBA', 'ACOBAMBA'),
('090202', 'HUANCAVELICA', 'ACOBAMBA', 'ANDABAMBA'),
('090203', 'HUANCAVELICA', 'ACOBAMBA', 'ANTA'),
('090204', 'HUANCAVELICA', 'ACOBAMBA', 'CAJA'),
('090205', 'HUANCAVELICA', 'ACOBAMBA', 'MARCAS'),
('090206', 'HUANCAVELICA', 'ACOBAMBA', 'PAUCARA'),
('090207', 'HUANCAVELICA', 'ACOBAMBA', 'POMACOCHA'),
('090208', 'HUANCAVELICA', 'ACOBAMBA', 'ROSARIO'),
('090301', 'HUANCAVELICA', 'ANGARAES', 'LIRCAY'),
('090302', 'HUANCAVELICA', 'ANGARAES', 'ANCHONGA'),
('090303', 'HUANCAVELICA', 'ANGARAES', 'CALLANMARCA'),
('090304', 'HUANCAVELICA', 'ANGARAES', 'CCOCHACCASA'),
('090305', 'HUANCAVELICA', 'ANGARAES', 'CHINCHO'),
('090306', 'HUANCAVELICA', 'ANGARAES', 'CONGALLA'),
('090307', 'HUANCAVELICA', 'ANGARAES', 'HUANCA-HUANCA'),
('090308', 'HUANCAVELICA', 'ANGARAES', 'HUAYLLAY GRANDE'),
('090309', 'HUANCAVELICA', 'ANGARAES', 'JULCAMARCA'),
('090310', 'HUANCAVELICA', 'ANGARAES', 'SAN ANTONIO DE ANTAPARCO'),
('090311', 'HUANCAVELICA', 'ANGARAES', 'SANTO TOMAS DE PATA'),
('090312', 'HUANCAVELICA', 'ANGARAES', 'SECCLLA'),
('090401', 'HUANCAVELICA', 'CASTROVIRREYNA', 'CASTROVIRREYNA'),
('090402', 'HUANCAVELICA', 'CASTROVIRREYNA', 'ARMA'),
('090403', 'HUANCAVELICA', 'CASTROVIRREYNA', 'AURAHUA'),
('090404', 'HUANCAVELICA', 'CASTROVIRREYNA', 'CAPILLAS'),
('090405', 'HUANCAVELICA', 'CASTROVIRREYNA', 'CHUPAMARCA'),
('090406', 'HUANCAVELICA', 'CASTROVIRREYNA', 'COCAS'),
('090407', 'HUANCAVELICA', 'CASTROVIRREYNA', 'HUACHOS'),
('090408', 'HUANCAVELICA', 'CASTROVIRREYNA', 'HUAMATAMBO'),
('090409', 'HUANCAVELICA', 'CASTROVIRREYNA', 'MOLLEPAMPA'),
('090410', 'HUANCAVELICA', 'CASTROVIRREYNA', 'SAN JUAN'),
('090411', 'HUANCAVELICA', 'CASTROVIRREYNA', 'SANTA ANA'),
('090412', 'HUANCAVELICA', 'CASTROVIRREYNA', 'TANTARA'),
('090413', 'HUANCAVELICA', 'CASTROVIRREYNA', 'TICRAPO'),
('090501', 'HUANCAVELICA', 'CHURCAMPA', 'CHURCAMPA'),
('090502', 'HUANCAVELICA', 'CHURCAMPA', 'ANCO'),
('090503', 'HUANCAVELICA', 'CHURCAMPA', 'CHINCHIHUASI'),
('090504', 'HUANCAVELICA', 'CHURCAMPA', 'EL CARMEN'),
('090505', 'HUANCAVELICA', 'CHURCAMPA', 'LA MERCED'),
('090506', 'HUANCAVELICA', 'CHURCAMPA', 'LOCROJA'),
('090507', 'HUANCAVELICA', 'CHURCAMPA', 'PAUCARBAMBA'),
('090508', 'HUANCAVELICA', 'CHURCAMPA', 'SAN MIGUEL DE MAYOCC'),
('090509', 'HUANCAVELICA', 'CHURCAMPA', 'SAN PEDRO DE CORIS'),
('090510', 'HUANCAVELICA', 'CHURCAMPA', 'PACHAMARCA'),
('090511', 'HUANCAVELICA', 'CHURCAMPA', 'COSME'),
('090601', 'HUANCAVELICA', 'HUAYTARÁ', 'HUAYTARA'),
('090602', 'HUANCAVELICA', 'HUAYTARÁ', 'AYAVI'),
('090603', 'HUANCAVELICA', 'HUAYTARÁ', 'CÓRDOVA'),
('090604', 'HUANCAVELICA', 'HUAYTARÁ', 'HUAYACUNDO ARMA'),
('090605', 'HUANCAVELICA', 'HUAYTARÁ', 'LARAMARCA'),
('090606', 'HUANCAVELICA', 'HUAYTARÁ', 'OCOYO'),
('090607', 'HUANCAVELICA', 'HUAYTARÁ', 'PILPICHACA'),
('090608', 'HUANCAVELICA', 'HUAYTARÁ', 'QUERCO'),
('090609', 'HUANCAVELICA', 'HUAYTARÁ', 'QUITO-ARMA'),
('090610', 'HUANCAVELICA', 'HUAYTARÁ', 'SAN ANTONIO DE CUSICANCHA'),
('090611', 'HUANCAVELICA', 'HUAYTARÁ', 'SAN FRANCISCO DE SANGAYAICO'),
('090612', 'HUANCAVELICA', 'HUAYTARÁ', 'SAN ISIDRO'),
('090613', 'HUANCAVELICA', 'HUAYTARÁ', 'SANTIAGO DE CHOCORVOS'),
('090614', 'HUANCAVELICA', 'HUAYTARÁ', 'SANTIAGO DE QUIRAHUARA'),
('090615', 'HUANCAVELICA', 'HUAYTARÁ', 'SANTO DOMINGO DE CAPILLAS'),
('090616', 'HUANCAVELICA', 'HUAYTARÁ', 'TAMBO'),
('090701', 'HUANCAVELICA', 'TAYACAJA', 'PAMPAS'),
('090702', 'HUANCAVELICA', 'TAYACAJA', 'ACOSTAMBO'),
('090703', 'HUANCAVELICA', 'TAYACAJA', 'ACRAQUIA'),
('090704', 'HUANCAVELICA', 'TAYACAJA', 'AHUAYCHA'),
('090705', 'HUANCAVELICA', 'TAYACAJA', 'COLCABAMBA'),
('090706', 'HUANCAVELICA', 'TAYACAJA', 'DANIEL HERNÁNDEZ'),
('090707', 'HUANCAVELICA', 'TAYACAJA', 'HUACHOCOLPA'),
('090709', 'HUANCAVELICA', 'TAYACAJA', 'HUARIBAMBA'),
('090710', 'HUANCAVELICA', 'TAYACAJA', 'ÑAHUIMPUQUIO'),
('090711', 'HUANCAVELICA', 'TAYACAJA', 'PAZOS'),
('090713', 'HUANCAVELICA', 'TAYACAJA', 'QUISHUAR'),
('090714', 'HUANCAVELICA', 'TAYACAJA', 'SALCABAMBA'),
('090715', 'HUANCAVELICA', 'TAYACAJA', 'SALCAHUASI'),
('090716', 'HUANCAVELICA', 'TAYACAJA', 'SAN MARCOS DE ROCCHAC'),
('090717', 'HUANCAVELICA', 'TAYACAJA', 'SURCUBAMBA'),
('090718', 'HUANCAVELICA', 'TAYACAJA', 'TINTAY PUNCU'),
('090719', 'HUANCAVELICA', 'TAYACAJA', 'QUICHUAS'),
('090720', 'HUANCAVELICA', 'TAYACAJA', 'ANDAYMARCA'),
('090721', 'HUANCAVELICA', 'TAYACAJA', 'ROBLE'),
('090722', 'HUANCAVELICA', 'TAYACAJA', 'PICHOS'),
('100101', 'HUÁNUCO', 'HUÁNUCO', 'HUANUCO'),
('100102', 'HUÁNUCO', 'HUÁNUCO', 'AMARILIS'),
('100103', 'HUÁNUCO', 'HUÁNUCO', 'CHINCHAO'),
('100104', 'HUÁNUCO', 'HUÁNUCO', 'CHURUBAMBA'),
('100105', 'HUÁNUCO', 'HUÁNUCO', 'MARGOS'),
('100106', 'HUÁNUCO', 'HUÁNUCO', 'QUISQUI (KICHKI)'),
('100107', 'HUÁNUCO', 'HUÁNUCO', 'SAN FRANCISCO DE CAYRAN'),
('100108', 'HUÁNUCO', 'HUÁNUCO', 'SAN PEDRO DE CHAULAN'),
('100109', 'HUÁNUCO', 'HUÁNUCO', 'SANTA MARÍA DEL VALLE'),
('100110', 'HUÁNUCO', 'HUÁNUCO', 'YARUMAYO'),
('100111', 'HUÁNUCO', 'HUÁNUCO', 'PILLCO MARCA'),
('100112', 'HUÁNUCO', 'HUÁNUCO', 'YACUS'),
('100113', 'HUÁNUCO', 'HUÁNUCO', 'SAN PABLO DE PILLAO'),
('100201', 'HUÁNUCO', 'AMBO', 'AMBO'),
('100202', 'HUÁNUCO', 'AMBO', 'CAYNA'),
('100203', 'HUÁNUCO', 'AMBO', 'COLPAS'),
('100204', 'HUÁNUCO', 'AMBO', 'CONCHAMARCA'),
('100205', 'HUÁNUCO', 'AMBO', 'HUACAR'),
('100206', 'HUÁNUCO', 'AMBO', 'SAN FRANCISCO'),
('100207', 'HUÁNUCO', 'AMBO', 'SAN RAFAEL'),
('100208', 'HUÁNUCO', 'AMBO', 'TOMAY KICHWA'),
('100301', 'HUÁNUCO', 'DOS DE MAYO', 'LA UNIÓN'),
('100307', 'HUÁNUCO', 'DOS DE MAYO', 'CHUQUIS'),
('100311', 'HUÁNUCO', 'DOS DE MAYO', 'MARÍAS'),
('100313', 'HUÁNUCO', 'DOS DE MAYO', 'PACHAS'),
('100316', 'HUÁNUCO', 'DOS DE MAYO', 'QUIVILLA'),
('100317', 'HUÁNUCO', 'DOS DE MAYO', 'RIPAN'),
('100321', 'HUÁNUCO', 'DOS DE MAYO', 'SHUNQUI'),
('100322', 'HUÁNUCO', 'DOS DE MAYO', 'SILLAPATA'),
('100323', 'HUÁNUCO', 'DOS DE MAYO', 'YANAS'),
('100401', 'HUÁNUCO', 'HUACAYBAMBA', 'HUACAYBAMBA'),
('100402', 'HUÁNUCO', 'HUACAYBAMBA', 'CANCHABAMBA'),
('100403', 'HUÁNUCO', 'HUACAYBAMBA', 'COCHABAMBA'),
('100404', 'HUÁNUCO', 'HUACAYBAMBA', 'PINRA'),
('100501', 'HUÁNUCO', 'HUAMALÍES', 'LLATA'),
('100502', 'HUÁNUCO', 'HUAMALÍES', 'ARANCAY'),
('100503', 'HUÁNUCO', 'HUAMALÍES', 'CHAVÍN DE PARIARCA'),
('100504', 'HUÁNUCO', 'HUAMALÍES', 'JACAS GRANDE'),
('100505', 'HUÁNUCO', 'HUAMALÍES', 'JIRCAN'),
('100506', 'HUÁNUCO', 'HUAMALÍES', 'MIRAFLORES'),
('100507', 'HUÁNUCO', 'HUAMALÍES', 'MONZÓN'),
('100508', 'HUÁNUCO', 'HUAMALÍES', 'PUNCHAO'),
('100509', 'HUÁNUCO', 'HUAMALÍES', 'PUÑOS'),
('100510', 'HUÁNUCO', 'HUAMALÍES', 'SINGA'),
('100511', 'HUÁNUCO', 'HUAMALÍES', 'TANTAMAYO'),
('100601', 'HUÁNUCO', 'LEONCIO PRADO', 'RUPA-RUPA'),
('100602', 'HUÁNUCO', 'LEONCIO PRADO', 'DANIEL ALOMÍA ROBLES'),
('100603', 'HUÁNUCO', 'LEONCIO PRADO', 'HERMÍLIO VALDIZAN'),
('100604', 'HUÁNUCO', 'LEONCIO PRADO', 'JOSÉ CRESPO Y CASTILLO'),
('100605', 'HUÁNUCO', 'LEONCIO PRADO', 'LUYANDO'),
('100606', 'HUÁNUCO', 'LEONCIO PRADO', 'MARIANO DAMASO BERAUN'),
('100607', 'HUÁNUCO', 'LEONCIO PRADO', 'PUCAYACU'),
('100608', 'HUÁNUCO', 'LEONCIO PRADO', 'CASTILLO GRANDE'),
('100701', 'HUÁNUCO', 'MARAÑÓN', 'HUACRACHUCO'),
('100702', 'HUÁNUCO', 'MARAÑÓN', 'CHOLON'),
('100703', 'HUÁNUCO', 'MARAÑÓN', 'SAN BUENAVENTURA'),
('100704', 'HUÁNUCO', 'MARAÑÓN', 'LA MORADA'),
('100705', 'HUÁNUCO', 'MARAÑÓN', 'SANTA ROSA DE ALTO YANAJANCA'),
('100801', 'HUÁNUCO', 'PACHITEA', 'PANAO'),
('100802', 'HUÁNUCO', 'PACHITEA', 'CHAGLLA'),
('100803', 'HUÁNUCO', 'PACHITEA', 'MOLINO'),
('100804', 'HUÁNUCO', 'PACHITEA', 'UMARI'),
('100901', 'HUÁNUCO', 'PUERTO INCA', 'PUERTO INCA'),
('100902', 'HUÁNUCO', 'PUERTO INCA', 'CODO DEL POZUZO'),
('100903', 'HUÁNUCO', 'PUERTO INCA', 'HONORIA'),
('100904', 'HUÁNUCO', 'PUERTO INCA', 'TOURNAVISTA'),
('100905', 'HUÁNUCO', 'PUERTO INCA', 'YUYAPICHIS'),
('101001', 'HUÁNUCO', 'LAURICOCHA', 'JESÚS'),
('101002', 'HUÁNUCO', 'LAURICOCHA', 'BAÑOS'),
('101003', 'HUÁNUCO', 'LAURICOCHA', 'JIVIA'),
('101004', 'HUÁNUCO', 'LAURICOCHA', 'QUEROPALCA'),
('101005', 'HUÁNUCO', 'LAURICOCHA', 'RONDOS'),
('101006', 'HUÁNUCO', 'LAURICOCHA', 'SAN FRANCISCO DE ASÍS'),
('101007', 'HUÁNUCO', 'LAURICOCHA', 'SAN MIGUEL DE CAURI'),
('101101', 'HUÁNUCO', 'YAROWILCA', 'CHAVINILLO'),
('101102', 'HUÁNUCO', 'YAROWILCA', 'CAHUAC'),
('101103', 'HUÁNUCO', 'YAROWILCA', 'CHACABAMBA'),
('101104', 'HUÁNUCO', 'YAROWILCA', 'APARICIO POMARES'),
('101105', 'HUÁNUCO', 'YAROWILCA', 'JACAS CHICO'),
('101106', 'HUÁNUCO', 'YAROWILCA', 'OBAS'),
('101107', 'HUÁNUCO', 'YAROWILCA', 'PAMPAMARCA'),
('101108', 'HUÁNUCO', 'YAROWILCA', 'CHORAS'),
('110101', 'ICA', 'ICA', 'ICA'),
('110102', 'ICA', 'ICA', 'LA TINGUIÑA'),
('110103', 'ICA', 'ICA', 'LOS AQUIJES'),
('110104', 'ICA', 'ICA', 'OCUCAJE'),
('110105', 'ICA', 'ICA', 'PACHACUTEC'),
('110106', 'ICA', 'ICA', 'PARCONA'),
('110107', 'ICA', 'ICA', 'PUEBLO NUEVO'),
('110108', 'ICA', 'ICA', 'SALAS'),
('110109', 'ICA', 'ICA', 'SAN JOSÉ DE LOS MOLINOS'),
('110110', 'ICA', 'ICA', 'SAN JUAN BAUTISTA'),
('110111', 'ICA', 'ICA', 'SANTIAGO'),
('110112', 'ICA', 'ICA', 'SUBTANJALLA'),
('110113', 'ICA', 'ICA', 'TATE'),
('110114', 'ICA', 'ICA', 'YAUCA DEL ROSARIO'),
('110201', 'ICA', 'CHINCHA', 'CHINCHA ALTA'),
('110202', 'ICA', 'CHINCHA', 'ALTO LARAN'),
('110203', 'ICA', 'CHINCHA', 'CHAVIN'),
('110204', 'ICA', 'CHINCHA', 'CHINCHA BAJA'),
('110205', 'ICA', 'CHINCHA', 'EL CARMEN'),
('110206', 'ICA', 'CHINCHA', 'GROCIO PRADO'),
('110207', 'ICA', 'CHINCHA', 'PUEBLO NUEVO'),
('110208', 'ICA', 'CHINCHA', 'SAN JUAN DE YANAC'),
('110209', 'ICA', 'CHINCHA', 'SAN PEDRO DE HUACARPANA'),
('110210', 'ICA', 'CHINCHA', 'SUNAMPE'),
('110211', 'ICA', 'CHINCHA', 'TAMBO DE MORA'),
('110301', 'ICA', 'NASCA', 'NASCA'),
('110302', 'ICA', 'NASCA', 'CHANGUILLO'),
('110303', 'ICA', 'NASCA', 'EL INGENIO'),
('110304', 'ICA', 'NASCA', 'MARCONA'),
('110305', 'ICA', 'NASCA', 'VISTA ALEGRE'),
('110401', 'ICA', 'PALPA', 'PALPA'),
('110402', 'ICA', 'PALPA', 'LLIPATA'),
('110403', 'ICA', 'PALPA', 'RÍO GRANDE'),
('110404', 'ICA', 'PALPA', 'SANTA CRUZ'),
('110405', 'ICA', 'PALPA', 'TIBILLO'),
('110501', 'ICA', 'PISCO', 'PISCO'),
('110502', 'ICA', 'PISCO', 'HUANCANO'),
('110503', 'ICA', 'PISCO', 'HUMAY'),
('110504', 'ICA', 'PISCO', 'INDEPENDENCIA'),
('110505', 'ICA', 'PISCO', 'PARACAS'),
('110506', 'ICA', 'PISCO', 'SAN ANDRÉS'),
('110507', 'ICA', 'PISCO', 'SAN CLEMENTE'),
('110508', 'ICA', 'PISCO', 'TUPAC AMARU INCA'),
('120101', 'JUNÍN', 'HUANCAYO', 'HUANCAYO'),
('120104', 'JUNÍN', 'HUANCAYO', 'CARHUACALLANGA'),
('120105', 'JUNÍN', 'HUANCAYO', 'CHACAPAMPA'),
('120106', 'JUNÍN', 'HUANCAYO', 'CHICCHE'),
('120107', 'JUNÍN', 'HUANCAYO', 'CHILCA'),
('120108', 'JUNÍN', 'HUANCAYO', 'CHONGOS ALTO'),
('120111', 'JUNÍN', 'HUANCAYO', 'CHUPURO'),
('120112', 'JUNÍN', 'HUANCAYO', 'COLCA'),
('120113', 'JUNÍN', 'HUANCAYO', 'CULLHUAS'),
('120114', 'JUNÍN', 'HUANCAYO', 'EL TAMBO'),
('120116', 'JUNÍN', 'HUANCAYO', 'HUACRAPUQUIO'),
('120117', 'JUNÍN', 'HUANCAYO', 'HUALHUAS'),
('120119', 'JUNÍN', 'HUANCAYO', 'HUANCAN'),
('120120', 'JUNÍN', 'HUANCAYO', 'HUASICANCHA'),
('120121', 'JUNÍN', 'HUANCAYO', 'HUAYUCACHI'),
('120122', 'JUNÍN', 'HUANCAYO', 'INGENIO'),
('120124', 'JUNÍN', 'HUANCAYO', 'PARIAHUANCA'),
('120125', 'JUNÍN', 'HUANCAYO', 'PILCOMAYO'),
('120126', 'JUNÍN', 'HUANCAYO', 'PUCARA'),
('120127', 'JUNÍN', 'HUANCAYO', 'QUICHUAY'),
('120128', 'JUNÍN', 'HUANCAYO', 'QUILCAS'),
('120129', 'JUNÍN', 'HUANCAYO', 'SAN AGUSTÍN'),
('120130', 'JUNÍN', 'HUANCAYO', 'SAN JERÓNIMO DE TUNAN'),
('120132', 'JUNÍN', 'HUANCAYO', 'SAÑO'),
('120133', 'JUNÍN', 'HUANCAYO', 'SAPALLANGA'),
('120134', 'JUNÍN', 'HUANCAYO', 'SICAYA'),
('120135', 'JUNÍN', 'HUANCAYO', 'SANTO DOMINGO DE ACOBAMBA'),
('120136', 'JUNÍN', 'HUANCAYO', 'VIQUES');
INSERT INTO `zg_ubigeo` (`IdUbigeo`, `Departamento`, `Provincia`, `Distrito`) VALUES
('120201', 'JUNÍN', 'CONCEPCIÓN', 'CONCEPCIÓN'),
('120202', 'JUNÍN', 'CONCEPCIÓN', 'ACO'),
('120203', 'JUNÍN', 'CONCEPCIÓN', 'ANDAMARCA'),
('120204', 'JUNÍN', 'CONCEPCIÓN', 'CHAMBARA'),
('120205', 'JUNÍN', 'CONCEPCIÓN', 'COCHAS'),
('120206', 'JUNÍN', 'CONCEPCIÓN', 'COMAS'),
('120207', 'JUNÍN', 'CONCEPCIÓN', 'HEROÍNAS TOLEDO'),
('120208', 'JUNÍN', 'CONCEPCIÓN', 'MANZANARES'),
('120209', 'JUNÍN', 'CONCEPCIÓN', 'MARISCAL CASTILLA'),
('120210', 'JUNÍN', 'CONCEPCIÓN', 'MATAHUASI'),
('120211', 'JUNÍN', 'CONCEPCIÓN', 'MITO'),
('120212', 'JUNÍN', 'CONCEPCIÓN', 'NUEVE DE JULIO'),
('120213', 'JUNÍN', 'CONCEPCIÓN', 'ORCOTUNA'),
('120214', 'JUNÍN', 'CONCEPCIÓN', 'SAN JOSÉ DE QUERO'),
('120215', 'JUNÍN', 'CONCEPCIÓN', 'SANTA ROSA DE OCOPA'),
('120301', 'JUNÍN', 'CHANCHAMAYO', 'CHANCHAMAYO'),
('120302', 'JUNÍN', 'CHANCHAMAYO', 'PERENE'),
('120303', 'JUNÍN', 'CHANCHAMAYO', 'PICHANAQUI'),
('120304', 'JUNÍN', 'CHANCHAMAYO', 'SAN LUIS DE SHUARO'),
('120305', 'JUNÍN', 'CHANCHAMAYO', 'SAN RAMÓN'),
('120306', 'JUNÍN', 'CHANCHAMAYO', 'VITOC'),
('120401', 'JUNÍN', 'JAUJA', 'JAUJA'),
('120402', 'JUNÍN', 'JAUJA', 'ACOLLA'),
('120403', 'JUNÍN', 'JAUJA', 'APATA'),
('120404', 'JUNÍN', 'JAUJA', 'ATAURA'),
('120405', 'JUNÍN', 'JAUJA', 'CANCHAYLLO'),
('120406', 'JUNÍN', 'JAUJA', 'CURICACA'),
('120407', 'JUNÍN', 'JAUJA', 'EL MANTARO'),
('120408', 'JUNÍN', 'JAUJA', 'HUAMALI'),
('120409', 'JUNÍN', 'JAUJA', 'HUARIPAMPA'),
('120410', 'JUNÍN', 'JAUJA', 'HUERTAS'),
('120411', 'JUNÍN', 'JAUJA', 'JANJAILLO'),
('120412', 'JUNÍN', 'JAUJA', 'JULCÁN'),
('120413', 'JUNÍN', 'JAUJA', 'LEONOR ORDÓÑEZ'),
('120414', 'JUNÍN', 'JAUJA', 'LLOCLLAPAMPA'),
('120415', 'JUNÍN', 'JAUJA', 'MARCO'),
('120416', 'JUNÍN', 'JAUJA', 'MASMA'),
('120417', 'JUNÍN', 'JAUJA', 'MASMA CHICCHE'),
('120418', 'JUNÍN', 'JAUJA', 'MOLINOS'),
('120419', 'JUNÍN', 'JAUJA', 'MONOBAMBA'),
('120420', 'JUNÍN', 'JAUJA', 'MUQUI'),
('120421', 'JUNÍN', 'JAUJA', 'MUQUIYAUYO'),
('120422', 'JUNÍN', 'JAUJA', 'PACA'),
('120423', 'JUNÍN', 'JAUJA', 'PACCHA'),
('120424', 'JUNÍN', 'JAUJA', 'PANCAN'),
('120425', 'JUNÍN', 'JAUJA', 'PARCO'),
('120426', 'JUNÍN', 'JAUJA', 'POMACANCHA'),
('120427', 'JUNÍN', 'JAUJA', 'RICRAN'),
('120428', 'JUNÍN', 'JAUJA', 'SAN LORENZO'),
('120429', 'JUNÍN', 'JAUJA', 'SAN PEDRO DE CHUNAN'),
('120430', 'JUNÍN', 'JAUJA', 'SAUSA'),
('120431', 'JUNÍN', 'JAUJA', 'SINCOS'),
('120432', 'JUNÍN', 'JAUJA', 'TUNAN MARCA'),
('120433', 'JUNÍN', 'JAUJA', 'YAULI'),
('120434', 'JUNÍN', 'JAUJA', 'YAUYOS'),
('120501', 'JUNÍN', 'JUNÍN', 'JUNIN'),
('120502', 'JUNÍN', 'JUNÍN', 'CARHUAMAYO'),
('120503', 'JUNÍN', 'JUNÍN', 'ONDORES'),
('120504', 'JUNÍN', 'JUNÍN', 'ULCUMAYO'),
('120601', 'JUNÍN', 'SATIPO', 'SATIPO'),
('120602', 'JUNÍN', 'SATIPO', 'COVIRIALI'),
('120603', 'JUNÍN', 'SATIPO', 'LLAYLLA'),
('120604', 'JUNÍN', 'SATIPO', 'MAZAMARI'),
('120605', 'JUNÍN', 'SATIPO', 'PAMPA HERMOSA'),
('120606', 'JUNÍN', 'SATIPO', 'PANGOA'),
('120607', 'JUNÍN', 'SATIPO', 'RÍO NEGRO'),
('120608', 'JUNÍN', 'SATIPO', 'RÍO TAMBO'),
('120609', 'JUNÍN', 'SATIPO', 'VIZCATAN DEL ENE'),
('120701', 'JUNÍN', 'TARMA', 'TARMA'),
('120702', 'JUNÍN', 'TARMA', 'ACOBAMBA'),
('120703', 'JUNÍN', 'TARMA', 'HUARICOLCA'),
('120704', 'JUNÍN', 'TARMA', 'HUASAHUASI'),
('120705', 'JUNÍN', 'TARMA', 'LA UNIÓN'),
('120706', 'JUNÍN', 'TARMA', 'PALCA'),
('120707', 'JUNÍN', 'TARMA', 'PALCAMAYO'),
('120708', 'JUNÍN', 'TARMA', 'SAN PEDRO DE CAJAS'),
('120709', 'JUNÍN', 'TARMA', 'TAPO'),
('120801', 'JUNÍN', 'YAULI', 'LA OROYA'),
('120802', 'JUNÍN', 'YAULI', 'CHACAPALPA'),
('120803', 'JUNÍN', 'YAULI', 'HUAY-HUAY'),
('120804', 'JUNÍN', 'YAULI', 'MARCAPOMACOCHA'),
('120805', 'JUNÍN', 'YAULI', 'MOROCOCHA'),
('120806', 'JUNÍN', 'YAULI', 'PACCHA'),
('120807', 'JUNÍN', 'YAULI', 'SANTA BÁRBARA DE CARHUACAYAN'),
('120808', 'JUNÍN', 'YAULI', 'SANTA ROSA DE SACCO'),
('120809', 'JUNÍN', 'YAULI', 'SUITUCANCHA'),
('120810', 'JUNÍN', 'YAULI', 'YAULI'),
('120901', 'JUNÍN', 'CHUPACA', 'CHUPACA'),
('120902', 'JUNÍN', 'CHUPACA', 'AHUAC'),
('120903', 'JUNÍN', 'CHUPACA', 'CHONGOS BAJO'),
('120904', 'JUNÍN', 'CHUPACA', 'HUACHAC'),
('120905', 'JUNÍN', 'CHUPACA', 'HUAMANCACA CHICO'),
('120906', 'JUNÍN', 'CHUPACA', 'SAN JUAN DE ISCOS'),
('120907', 'JUNÍN', 'CHUPACA', 'SAN JUAN DE JARPA'),
('120908', 'JUNÍN', 'CHUPACA', 'TRES DE DICIEMBRE'),
('120909', 'JUNÍN', 'CHUPACA', 'YANACANCHA'),
('130101', 'LA LIBERTAD', 'TRUJILLO', 'TRUJILLO'),
('130102', 'LA LIBERTAD', 'TRUJILLO', 'EL PORVENIR'),
('130103', 'LA LIBERTAD', 'TRUJILLO', 'FLORENCIA DE MORA'),
('130104', 'LA LIBERTAD', 'TRUJILLO', 'HUANCHACO'),
('130105', 'LA LIBERTAD', 'TRUJILLO', 'LA ESPERANZA'),
('130106', 'LA LIBERTAD', 'TRUJILLO', 'LAREDO'),
('130107', 'LA LIBERTAD', 'TRUJILLO', 'MOCHE'),
('130108', 'LA LIBERTAD', 'TRUJILLO', 'POROTO'),
('130109', 'LA LIBERTAD', 'TRUJILLO', 'SALAVERRY'),
('130110', 'LA LIBERTAD', 'TRUJILLO', 'SIMBAL'),
('130111', 'LA LIBERTAD', 'TRUJILLO', 'VICTOR LARCO HERRERA'),
('130201', 'LA LIBERTAD', 'ASCOPE', 'ASCOPE'),
('130202', 'LA LIBERTAD', 'ASCOPE', 'CHICAMA'),
('130203', 'LA LIBERTAD', 'ASCOPE', 'CHOCOPE'),
('130204', 'LA LIBERTAD', 'ASCOPE', 'MAGDALENA DE CAO'),
('130205', 'LA LIBERTAD', 'ASCOPE', 'PAIJAN'),
('130206', 'LA LIBERTAD', 'ASCOPE', 'RÁZURI'),
('130207', 'LA LIBERTAD', 'ASCOPE', 'SANTIAGO DE CAO'),
('130208', 'LA LIBERTAD', 'ASCOPE', 'CASA GRANDE'),
('130301', 'LA LIBERTAD', 'BOLÍVAR', 'BOLÍVAR'),
('130302', 'LA LIBERTAD', 'BOLÍVAR', 'BAMBAMARCA'),
('130303', 'LA LIBERTAD', 'BOLÍVAR', 'CONDORMARCA'),
('130304', 'LA LIBERTAD', 'BOLÍVAR', 'LONGOTEA'),
('130305', 'LA LIBERTAD', 'BOLÍVAR', 'UCHUMARCA'),
('130306', 'LA LIBERTAD', 'BOLÍVAR', 'UCUNCHA'),
('130401', 'LA LIBERTAD', 'CHEPÉN', 'CHEPEN'),
('130402', 'LA LIBERTAD', 'CHEPÉN', 'PACANGA'),
('130403', 'LA LIBERTAD', 'CHEPÉN', 'PUEBLO NUEVO'),
('130501', 'LA LIBERTAD', 'JULCÁN', 'JULCAN'),
('130502', 'LA LIBERTAD', 'JULCÁN', 'CALAMARCA'),
('130503', 'LA LIBERTAD', 'JULCÁN', 'CARABAMBA'),
('130504', 'LA LIBERTAD', 'JULCÁN', 'HUASO'),
('130601', 'LA LIBERTAD', 'OTUZCO', 'OTUZCO'),
('130602', 'LA LIBERTAD', 'OTUZCO', 'AGALLPAMPA'),
('130604', 'LA LIBERTAD', 'OTUZCO', 'CHARAT'),
('130605', 'LA LIBERTAD', 'OTUZCO', 'HUARANCHAL'),
('130606', 'LA LIBERTAD', 'OTUZCO', 'LA CUESTA'),
('130608', 'LA LIBERTAD', 'OTUZCO', 'MACHE'),
('130610', 'LA LIBERTAD', 'OTUZCO', 'PARANDAY'),
('130611', 'LA LIBERTAD', 'OTUZCO', 'SALPO'),
('130613', 'LA LIBERTAD', 'OTUZCO', 'SINSICAP'),
('130614', 'LA LIBERTAD', 'OTUZCO', 'USQUIL'),
('130701', 'LA LIBERTAD', 'PACASMAYO', 'SAN PEDRO DE LLOC'),
('130702', 'LA LIBERTAD', 'PACASMAYO', 'GUADALUPE'),
('130703', 'LA LIBERTAD', 'PACASMAYO', 'JEQUETEPEQUE'),
('130704', 'LA LIBERTAD', 'PACASMAYO', 'PACASMAYO'),
('130705', 'LA LIBERTAD', 'PACASMAYO', 'SAN JOSÉ'),
('130801', 'LA LIBERTAD', 'PATAZ', 'TAYABAMBA'),
('130802', 'LA LIBERTAD', 'PATAZ', 'BULDIBUYO'),
('130803', 'LA LIBERTAD', 'PATAZ', 'CHILLIA'),
('130804', 'LA LIBERTAD', 'PATAZ', 'HUANCASPATA'),
('130805', 'LA LIBERTAD', 'PATAZ', 'HUAYLILLAS'),
('130806', 'LA LIBERTAD', 'PATAZ', 'HUAYO'),
('130807', 'LA LIBERTAD', 'PATAZ', 'ONGON'),
('130808', 'LA LIBERTAD', 'PATAZ', 'PARCOY'),
('130809', 'LA LIBERTAD', 'PATAZ', 'PATAZ'),
('130810', 'LA LIBERTAD', 'PATAZ', 'PIAS'),
('130811', 'LA LIBERTAD', 'PATAZ', 'SANTIAGO DE CHALLAS'),
('130812', 'LA LIBERTAD', 'PATAZ', 'TAURIJA'),
('130813', 'LA LIBERTAD', 'PATAZ', 'URPAY'),
('130901', 'LA LIBERTAD', 'SÁNCHEZ CARRIÓN', 'HUAMACHUCO'),
('130902', 'LA LIBERTAD', 'SÁNCHEZ CARRIÓN', 'CHUGAY'),
('130903', 'LA LIBERTAD', 'SÁNCHEZ CARRIÓN', 'COCHORCO'),
('130904', 'LA LIBERTAD', 'SÁNCHEZ CARRIÓN', 'CURGOS'),
('130905', 'LA LIBERTAD', 'SÁNCHEZ CARRIÓN', 'MARCABAL'),
('130906', 'LA LIBERTAD', 'SÁNCHEZ CARRIÓN', 'SANAGORAN'),
('130907', 'LA LIBERTAD', 'SÁNCHEZ CARRIÓN', 'SARIN'),
('130908', 'LA LIBERTAD', 'SÁNCHEZ CARRIÓN', 'SARTIMBAMBA'),
('131001', 'LA LIBERTAD', 'SANTIAGO DE CHUCO', 'SANTIAGO DE CHUCO'),
('131002', 'LA LIBERTAD', 'SANTIAGO DE CHUCO', 'ANGASMARCA'),
('131003', 'LA LIBERTAD', 'SANTIAGO DE CHUCO', 'CACHICADAN'),
('131004', 'LA LIBERTAD', 'SANTIAGO DE CHUCO', 'MOLLEBAMBA'),
('131005', 'LA LIBERTAD', 'SANTIAGO DE CHUCO', 'MOLLEPATA'),
('131006', 'LA LIBERTAD', 'SANTIAGO DE CHUCO', 'QUIRUVILCA'),
('131007', 'LA LIBERTAD', 'SANTIAGO DE CHUCO', 'SANTA CRUZ DE CHUCA'),
('131008', 'LA LIBERTAD', 'SANTIAGO DE CHUCO', 'SITABAMBA'),
('131101', 'LA LIBERTAD', 'GRAN CHIMÚ', 'CASCAS'),
('131102', 'LA LIBERTAD', 'GRAN CHIMÚ', 'LUCMA'),
('131103', 'LA LIBERTAD', 'GRAN CHIMÚ', 'MARMOT'),
('131104', 'LA LIBERTAD', 'GRAN CHIMÚ', 'SAYAPULLO'),
('131201', 'LA LIBERTAD', 'VIRÚ', 'VIRU'),
('131202', 'LA LIBERTAD', 'VIRÚ', 'CHAO'),
('131203', 'LA LIBERTAD', 'VIRÚ', 'GUADALUPITO'),
('140101', 'LAMBAYEQUE', 'CHICLAYO', 'CHICLAYO'),
('140102', 'LAMBAYEQUE', 'CHICLAYO', 'CHONGOYAPE'),
('140103', 'LAMBAYEQUE', 'CHICLAYO', 'ETEN'),
('140104', 'LAMBAYEQUE', 'CHICLAYO', 'ETEN PUERTO'),
('140105', 'LAMBAYEQUE', 'CHICLAYO', 'JOSÉ LEONARDO ORTIZ'),
('140106', 'LAMBAYEQUE', 'CHICLAYO', 'LA VICTORIA'),
('140107', 'LAMBAYEQUE', 'CHICLAYO', 'LAGUNAS'),
('140108', 'LAMBAYEQUE', 'CHICLAYO', 'MONSEFU'),
('140109', 'LAMBAYEQUE', 'CHICLAYO', 'NUEVA ARICA'),
('140110', 'LAMBAYEQUE', 'CHICLAYO', 'OYOTUN'),
('140111', 'LAMBAYEQUE', 'CHICLAYO', 'PICSI'),
('140112', 'LAMBAYEQUE', 'CHICLAYO', 'PIMENTEL'),
('140113', 'LAMBAYEQUE', 'CHICLAYO', 'REQUE'),
('140114', 'LAMBAYEQUE', 'CHICLAYO', 'SANTA ROSA'),
('140115', 'LAMBAYEQUE', 'CHICLAYO', 'SAÑA'),
('140116', 'LAMBAYEQUE', 'CHICLAYO', 'CAYALTI'),
('140117', 'LAMBAYEQUE', 'CHICLAYO', 'PATAPO'),
('140118', 'LAMBAYEQUE', 'CHICLAYO', 'POMALCA'),
('140119', 'LAMBAYEQUE', 'CHICLAYO', 'PUCALA'),
('140120', 'LAMBAYEQUE', 'CHICLAYO', 'TUMAN'),
('140201', 'LAMBAYEQUE', 'FERREÑAFE', 'FERREÑAFE'),
('140202', 'LAMBAYEQUE', 'FERREÑAFE', 'CAÑARIS'),
('140203', 'LAMBAYEQUE', 'FERREÑAFE', 'INCAHUASI'),
('140204', 'LAMBAYEQUE', 'FERREÑAFE', 'MANUEL ANTONIO MESONES MURO'),
('140205', 'LAMBAYEQUE', 'FERREÑAFE', 'PITIPO'),
('140206', 'LAMBAYEQUE', 'FERREÑAFE', 'PUEBLO NUEVO'),
('140301', 'LAMBAYEQUE', 'LAMBAYEQUE', 'LAMBAYEQUE'),
('140302', 'LAMBAYEQUE', 'LAMBAYEQUE', 'CHOCHOPE'),
('140303', 'LAMBAYEQUE', 'LAMBAYEQUE', 'ILLIMO'),
('140304', 'LAMBAYEQUE', 'LAMBAYEQUE', 'JAYANCA'),
('140305', 'LAMBAYEQUE', 'LAMBAYEQUE', 'MOCHUMI'),
('140306', 'LAMBAYEQUE', 'LAMBAYEQUE', 'MORROPE'),
('140307', 'LAMBAYEQUE', 'LAMBAYEQUE', 'MOTUPE'),
('140308', 'LAMBAYEQUE', 'LAMBAYEQUE', 'OLMOS'),
('140309', 'LAMBAYEQUE', 'LAMBAYEQUE', 'PACORA'),
('140310', 'LAMBAYEQUE', 'LAMBAYEQUE', 'SALAS'),
('140311', 'LAMBAYEQUE', 'LAMBAYEQUE', 'SAN JOSÉ'),
('140312', 'LAMBAYEQUE', 'LAMBAYEQUE', 'TUCUME'),
('150101', 'LIMA', 'LIMA', 'LIMA'),
('150102', 'LIMA', 'LIMA', 'ANCÓN'),
('150103', 'LIMA', 'LIMA', 'ATE'),
('150104', 'LIMA', 'LIMA', 'BARRANCO'),
('150105', 'LIMA', 'LIMA', 'BREÑA'),
('150106', 'LIMA', 'LIMA', 'CARABAYLLO'),
('150107', 'LIMA', 'LIMA', 'CHACLACAYO'),
('150108', 'LIMA', 'LIMA', 'CHORRILLOS'),
('150109', 'LIMA', 'LIMA', 'CIENEGUILLA'),
('150110', 'LIMA', 'LIMA', 'COMAS'),
('150111', 'LIMA', 'LIMA', 'EL AGUSTINO'),
('150112', 'LIMA', 'LIMA', 'INDEPENDENCIA'),
('150113', 'LIMA', 'LIMA', 'JESÚS MARÍA'),
('150114', 'LIMA', 'LIMA', 'LA MOLINA'),
('150115', 'LIMA', 'LIMA', 'LA VICTORIA'),
('150116', 'LIMA', 'LIMA', 'LINCE'),
('150117', 'LIMA', 'LIMA', 'LOS OLIVOS'),
('150118', 'LIMA', 'LIMA', 'LURIGANCHO'),
('150119', 'LIMA', 'LIMA', 'LURIN'),
('150120', 'LIMA', 'LIMA', 'MAGDALENA DEL MAR'),
('150121', 'LIMA', 'LIMA', 'PUEBLO LIBRE'),
('150122', 'LIMA', 'LIMA', 'MIRAFLORES'),
('150123', 'LIMA', 'LIMA', 'PACHACAMAC'),
('150124', 'LIMA', 'LIMA', 'PUCUSANA'),
('150125', 'LIMA', 'LIMA', 'PUENTE PIEDRA'),
('150126', 'LIMA', 'LIMA', 'PUNTA HERMOSA'),
('150127', 'LIMA', 'LIMA', 'PUNTA NEGRA'),
('150128', 'LIMA', 'LIMA', 'RÍMAC'),
('150129', 'LIMA', 'LIMA', 'SAN BARTOLO'),
('150130', 'LIMA', 'LIMA', 'SAN BORJA'),
('150131', 'LIMA', 'LIMA', 'SAN ISIDRO'),
('150132', 'LIMA', 'LIMA', 'SAN JUAN DE LURIGANCHO'),
('150133', 'LIMA', 'LIMA', 'SAN JUAN DE MIRAFLORES'),
('150134', 'LIMA', 'LIMA', 'SAN LUIS'),
('150135', 'LIMA', 'LIMA', 'SAN MARTÍN DE PORRES'),
('150136', 'LIMA', 'LIMA', 'SAN MIGUEL'),
('150137', 'LIMA', 'LIMA', 'SANTA ANITA'),
('150138', 'LIMA', 'LIMA', 'SANTA MARÍA DEL MAR'),
('150139', 'LIMA', 'LIMA', 'SANTA ROSA'),
('150140', 'LIMA', 'LIMA', 'SANTIAGO DE SURCO'),
('150141', 'LIMA', 'LIMA', 'SURQUILLO'),
('150142', 'LIMA', 'LIMA', 'VILLA EL SALVADOR'),
('150143', 'LIMA', 'LIMA', 'VILLA MARÍA DEL TRIUNFO'),
('150201', 'LIMA', 'BARRANCA', 'BARRANCA'),
('150202', 'LIMA', 'BARRANCA', 'PARAMONGA'),
('150203', 'LIMA', 'BARRANCA', 'PATIVILCA'),
('150204', 'LIMA', 'BARRANCA', 'SUPE'),
('150205', 'LIMA', 'BARRANCA', 'SUPE PUERTO'),
('150301', 'LIMA', 'CAJATAMBO', 'CAJATAMBO'),
('150302', 'LIMA', 'CAJATAMBO', 'COPA'),
('150303', 'LIMA', 'CAJATAMBO', 'GORGOR'),
('150304', 'LIMA', 'CAJATAMBO', 'HUANCAPON'),
('150305', 'LIMA', 'CAJATAMBO', 'MANAS'),
('150401', 'LIMA', 'CANTA', 'CANTA'),
('150402', 'LIMA', 'CANTA', 'ARAHUAY'),
('150403', 'LIMA', 'CANTA', 'HUAMANTANGA'),
('150404', 'LIMA', 'CANTA', 'HUAROS'),
('150405', 'LIMA', 'CANTA', 'LACHAQUI'),
('150406', 'LIMA', 'CANTA', 'SAN BUENAVENTURA'),
('150407', 'LIMA', 'CANTA', 'SANTA ROSA DE QUIVES'),
('150501', 'LIMA', 'CAÑETE', 'SAN VICENTE DE CAÑETE'),
('150502', 'LIMA', 'CAÑETE', 'ASIA'),
('150503', 'LIMA', 'CAÑETE', 'CALANGO'),
('150504', 'LIMA', 'CAÑETE', 'CERRO AZUL'),
('150505', 'LIMA', 'CAÑETE', 'CHILCA'),
('150506', 'LIMA', 'CAÑETE', 'COAYLLO'),
('150507', 'LIMA', 'CAÑETE', 'IMPERIAL'),
('150508', 'LIMA', 'CAÑETE', 'LUNAHUANA'),
('150509', 'LIMA', 'CAÑETE', 'MALA'),
('150510', 'LIMA', 'CAÑETE', 'NUEVO IMPERIAL'),
('150511', 'LIMA', 'CAÑETE', 'PACARAN'),
('150512', 'LIMA', 'CAÑETE', 'QUILMANA'),
('150513', 'LIMA', 'CAÑETE', 'SAN ANTONIO'),
('150514', 'LIMA', 'CAÑETE', 'SAN LUIS'),
('150515', 'LIMA', 'CAÑETE', 'SANTA CRUZ DE FLORES'),
('150516', 'LIMA', 'CAÑETE', 'ZÚÑIGA'),
('150601', 'LIMA', 'HUARAL', 'HUARAL'),
('150602', 'LIMA', 'HUARAL', 'ATAVILLOS ALTO'),
('150603', 'LIMA', 'HUARAL', 'ATAVILLOS BAJO'),
('150604', 'LIMA', 'HUARAL', 'AUCALLAMA'),
('150605', 'LIMA', 'HUARAL', 'CHANCAY'),
('150606', 'LIMA', 'HUARAL', 'IHUARI'),
('150607', 'LIMA', 'HUARAL', 'LAMPIAN'),
('150608', 'LIMA', 'HUARAL', 'PACARAOS'),
('150609', 'LIMA', 'HUARAL', 'SAN MIGUEL DE ACOS'),
('150610', 'LIMA', 'HUARAL', 'SANTA CRUZ DE ANDAMARCA'),
('150611', 'LIMA', 'HUARAL', 'SUMBILCA'),
('150612', 'LIMA', 'HUARAL', 'VEINTISIETE DE NOVIEMBRE'),
('150701', 'LIMA', 'HUAROCHIRÍ', 'MATUCANA'),
('150702', 'LIMA', 'HUAROCHIRÍ', 'ANTIOQUIA'),
('150703', 'LIMA', 'HUAROCHIRÍ', 'CALLAHUANCA'),
('150704', 'LIMA', 'HUAROCHIRÍ', 'CARAMPOMA'),
('150705', 'LIMA', 'HUAROCHIRÍ', 'CHICLA'),
('150706', 'LIMA', 'HUAROCHIRÍ', 'CUENCA'),
('150707', 'LIMA', 'HUAROCHIRÍ', 'HUACHUPAMPA'),
('150708', 'LIMA', 'HUAROCHIRÍ', 'HUANZA'),
('150709', 'LIMA', 'HUAROCHIRÍ', 'HUAROCHIRI'),
('150710', 'LIMA', 'HUAROCHIRÍ', 'LAHUAYTAMBO'),
('150711', 'LIMA', 'HUAROCHIRÍ', 'LANGA'),
('150712', 'LIMA', 'HUAROCHIRÍ', 'LARAOS'),
('150713', 'LIMA', 'HUAROCHIRÍ', 'MARIATANA'),
('150714', 'LIMA', 'HUAROCHIRÍ', 'RICARDO PALMA'),
('150715', 'LIMA', 'HUAROCHIRÍ', 'SAN ANDRÉS DE TUPICOCHA'),
('150716', 'LIMA', 'HUAROCHIRÍ', 'SAN ANTONIO'),
('150717', 'LIMA', 'HUAROCHIRÍ', 'SAN BARTOLOMÉ'),
('150718', 'LIMA', 'HUAROCHIRÍ', 'SAN DAMIAN'),
('150719', 'LIMA', 'HUAROCHIRÍ', 'SAN JUAN DE IRIS'),
('150720', 'LIMA', 'HUAROCHIRÍ', 'SAN JUAN DE TANTARANCHE'),
('150721', 'LIMA', 'HUAROCHIRÍ', 'SAN LORENZO DE QUINTI'),
('150722', 'LIMA', 'HUAROCHIRÍ', 'SAN MATEO'),
('150723', 'LIMA', 'HUAROCHIRÍ', 'SAN MATEO DE OTAO'),
('150724', 'LIMA', 'HUAROCHIRÍ', 'SAN PEDRO DE CASTA'),
('150725', 'LIMA', 'HUAROCHIRÍ', 'SAN PEDRO DE HUANCAYRE'),
('150726', 'LIMA', 'HUAROCHIRÍ', 'SANGALLAYA'),
('150727', 'LIMA', 'HUAROCHIRÍ', 'SANTA CRUZ DE COCACHACRA'),
('150728', 'LIMA', 'HUAROCHIRÍ', 'SANTA EULALIA'),
('150729', 'LIMA', 'HUAROCHIRÍ', 'SANTIAGO DE ANCHUCAYA'),
('150730', 'LIMA', 'HUAROCHIRÍ', 'SANTIAGO DE TUNA'),
('150731', 'LIMA', 'HUAROCHIRÍ', 'SANTO DOMINGO DE LOS OLLEROS'),
('150732', 'LIMA', 'HUAROCHIRÍ', 'SURCO'),
('150801', 'LIMA', 'HUAURA', 'HUACHO'),
('150802', 'LIMA', 'HUAURA', 'AMBAR'),
('150803', 'LIMA', 'HUAURA', 'CALETA DE CARQUIN'),
('150804', 'LIMA', 'HUAURA', 'CHECRAS'),
('150805', 'LIMA', 'HUAURA', 'HUALMAY'),
('150806', 'LIMA', 'HUAURA', 'HUAURA'),
('150807', 'LIMA', 'HUAURA', 'LEONCIO PRADO'),
('150808', 'LIMA', 'HUAURA', 'PACCHO'),
('150809', 'LIMA', 'HUAURA', 'SANTA LEONOR'),
('150810', 'LIMA', 'HUAURA', 'SANTA MARÍA'),
('150811', 'LIMA', 'HUAURA', 'SAYAN'),
('150812', 'LIMA', 'HUAURA', 'VEGUETA'),
('150901', 'LIMA', 'OYÓN', 'OYON'),
('150902', 'LIMA', 'OYÓN', 'ANDAJES'),
('150903', 'LIMA', 'OYÓN', 'CAUJUL'),
('150904', 'LIMA', 'OYÓN', 'COCHAMARCA'),
('150905', 'LIMA', 'OYÓN', 'NAVAN'),
('150906', 'LIMA', 'OYÓN', 'PACHANGARA'),
('151001', 'LIMA', 'YAUYOS', 'YAUYOS'),
('151002', 'LIMA', 'YAUYOS', 'ALIS'),
('151003', 'LIMA', 'YAUYOS', 'ALLAUCA'),
('151004', 'LIMA', 'YAUYOS', 'AYAVIRI'),
('151005', 'LIMA', 'YAUYOS', 'AZÁNGARO'),
('151006', 'LIMA', 'YAUYOS', 'CACRA'),
('151007', 'LIMA', 'YAUYOS', 'CARANIA'),
('151008', 'LIMA', 'YAUYOS', 'CATAHUASI'),
('151009', 'LIMA', 'YAUYOS', 'CHOCOS'),
('151010', 'LIMA', 'YAUYOS', 'COCHAS'),
('151011', 'LIMA', 'YAUYOS', 'COLONIA'),
('151012', 'LIMA', 'YAUYOS', 'HONGOS'),
('151013', 'LIMA', 'YAUYOS', 'HUAMPARA'),
('151014', 'LIMA', 'YAUYOS', 'HUANCAYA'),
('151015', 'LIMA', 'YAUYOS', 'HUANGASCAR'),
('151016', 'LIMA', 'YAUYOS', 'HUANTAN'),
('151017', 'LIMA', 'YAUYOS', 'HUAÑEC'),
('151018', 'LIMA', 'YAUYOS', 'LARAOS'),
('151019', 'LIMA', 'YAUYOS', 'LINCHA'),
('151020', 'LIMA', 'YAUYOS', 'MADEAN'),
('151021', 'LIMA', 'YAUYOS', 'MIRAFLORES'),
('151022', 'LIMA', 'YAUYOS', 'OMAS'),
('151023', 'LIMA', 'YAUYOS', 'PUTINZA'),
('151024', 'LIMA', 'YAUYOS', 'QUINCHES'),
('151025', 'LIMA', 'YAUYOS', 'QUINOCAY'),
('151026', 'LIMA', 'YAUYOS', 'SAN JOAQUÍN'),
('151027', 'LIMA', 'YAUYOS', 'SAN PEDRO DE PILAS'),
('151028', 'LIMA', 'YAUYOS', 'TANTA'),
('151029', 'LIMA', 'YAUYOS', 'TAURIPAMPA'),
('151030', 'LIMA', 'YAUYOS', 'TOMAS'),
('151031', 'LIMA', 'YAUYOS', 'TUPE'),
('151032', 'LIMA', 'YAUYOS', 'VIÑAC'),
('151033', 'LIMA', 'YAUYOS', 'VITIS'),
('160101', 'LORETO', 'MAYNAS', 'IQUITOS'),
('160102', 'LORETO', 'MAYNAS', 'ALTO NANAY'),
('160103', 'LORETO', 'MAYNAS', 'FERNANDO LORES'),
('160104', 'LORETO', 'MAYNAS', 'INDIANA'),
('160105', 'LORETO', 'MAYNAS', 'LAS AMAZONAS'),
('160106', 'LORETO', 'MAYNAS', 'MAZAN'),
('160107', 'LORETO', 'MAYNAS', 'NAPO'),
('160108', 'LORETO', 'MAYNAS', 'PUNCHANA'),
('160110', 'LORETO', 'MAYNAS', 'TORRES CAUSANA'),
('160112', 'LORETO', 'MAYNAS', 'BELÉN'),
('160113', 'LORETO', 'MAYNAS', 'SAN JUAN BAUTISTA'),
('160201', 'LORETO', 'ALTO AMAZONAS', 'YURIMAGUAS'),
('160202', 'LORETO', 'ALTO AMAZONAS', 'BALSAPUERTO'),
('160205', 'LORETO', 'ALTO AMAZONAS', 'JEBEROS'),
('160206', 'LORETO', 'ALTO AMAZONAS', 'LAGUNAS'),
('160210', 'LORETO', 'ALTO AMAZONAS', 'SANTA CRUZ'),
('160211', 'LORETO', 'ALTO AMAZONAS', 'TENIENTE CESAR LÓPEZ ROJAS'),
('160301', 'LORETO', 'LORETO', 'NAUTA'),
('160302', 'LORETO', 'LORETO', 'PARINARI'),
('160303', 'LORETO', 'LORETO', 'TIGRE'),
('160304', 'LORETO', 'LORETO', 'TROMPETEROS'),
('160305', 'LORETO', 'LORETO', 'URARINAS'),
('160401', 'LORETO', 'MARISCAL RAMÓN CASTILLA', 'RAMÓN CASTILLA'),
('160402', 'LORETO', 'MARISCAL RAMÓN CASTILLA', 'PEBAS'),
('160403', 'LORETO', 'MARISCAL RAMÓN CASTILLA', 'YAVARI'),
('160404', 'LORETO', 'MARISCAL RAMÓN CASTILLA', 'SAN PABLO'),
('160501', 'LORETO', 'REQUENA', 'REQUENA'),
('160502', 'LORETO', 'REQUENA', 'ALTO TAPICHE'),
('160503', 'LORETO', 'REQUENA', 'CAPELO'),
('160504', 'LORETO', 'REQUENA', 'EMILIO SAN MARTÍN'),
('160505', 'LORETO', 'REQUENA', 'MAQUIA'),
('160506', 'LORETO', 'REQUENA', 'PUINAHUA'),
('160507', 'LORETO', 'REQUENA', 'SAQUENA'),
('160508', 'LORETO', 'REQUENA', 'SOPLIN'),
('160509', 'LORETO', 'REQUENA', 'TAPICHE'),
('160510', 'LORETO', 'REQUENA', 'JENARO HERRERA'),
('160511', 'LORETO', 'REQUENA', 'YAQUERANA'),
('160601', 'LORETO', 'UCAYALI', 'CONTAMANA'),
('160602', 'LORETO', 'UCAYALI', 'INAHUAYA'),
('160603', 'LORETO', 'UCAYALI', 'PADRE MÁRQUEZ'),
('160604', 'LORETO', 'UCAYALI', 'PAMPA HERMOSA'),
('160605', 'LORETO', 'UCAYALI', 'SARAYACU'),
('160606', 'LORETO', 'UCAYALI', 'VARGAS GUERRA'),
('160701', 'LORETO', 'DATEM DEL MARAÑÓN', 'BARRANCA'),
('160702', 'LORETO', 'DATEM DEL MARAÑÓN', 'CAHUAPANAS'),
('160703', 'LORETO', 'DATEM DEL MARAÑÓN', 'MANSERICHE'),
('160704', 'LORETO', 'DATEM DEL MARAÑÓN', 'MORONA'),
('160705', 'LORETO', 'DATEM DEL MARAÑÓN', 'PASTAZA'),
('160706', 'LORETO', 'DATEM DEL MARAÑÓN', 'ANDOAS'),
('160801', 'LORETO', 'PUTUMAYO', 'PUTUMAYO'),
('160802', 'LORETO', 'PUTUMAYO', 'ROSA PANDURO'),
('160803', 'LORETO', 'PUTUMAYO', 'TENIENTE MANUEL CLAVERO'),
('160804', 'LORETO', 'PUTUMAYO', 'YAGUAS'),
('170101', 'MADRE DE DIOS', 'TAMBOPATA', 'TAMBOPATA'),
('170102', 'MADRE DE DIOS', 'TAMBOPATA', 'INAMBARI'),
('170103', 'MADRE DE DIOS', 'TAMBOPATA', 'LAS PIEDRAS'),
('170104', 'MADRE DE DIOS', 'TAMBOPATA', 'LABERINTO'),
('170201', 'MADRE DE DIOS', 'MANU', 'MANU'),
('170202', 'MADRE DE DIOS', 'MANU', 'FITZCARRALD'),
('170203', 'MADRE DE DIOS', 'MANU', 'MADRE DE DIOS'),
('170204', 'MADRE DE DIOS', 'MANU', 'HUEPETUHE'),
('170301', 'MADRE DE DIOS', 'TAHUAMANU', 'IÑAPARI'),
('170302', 'MADRE DE DIOS', 'TAHUAMANU', 'IBERIA'),
('170303', 'MADRE DE DIOS', 'TAHUAMANU', 'TAHUAMANU'),
('180101', 'MOQUEGUA', 'MARISCAL NIETO', 'MOQUEGUA'),
('180102', 'MOQUEGUA', 'MARISCAL NIETO', 'CARUMAS'),
('180103', 'MOQUEGUA', 'MARISCAL NIETO', 'CUCHUMBAYA'),
('180104', 'MOQUEGUA', 'MARISCAL NIETO', 'SAMEGUA'),
('180105', 'MOQUEGUA', 'MARISCAL NIETO', 'SAN CRISTÓBAL'),
('180106', 'MOQUEGUA', 'MARISCAL NIETO', 'TORATA'),
('180201', 'MOQUEGUA', 'GENERAL SÁNCHEZ CERRO', 'OMATE'),
('180202', 'MOQUEGUA', 'GENERAL SÁNCHEZ CERRO', 'CHOJATA'),
('180203', 'MOQUEGUA', 'GENERAL SÁNCHEZ CERRO', 'COALAQUE'),
('180204', 'MOQUEGUA', 'GENERAL SÁNCHEZ CERRO', 'ICHUÑA'),
('180205', 'MOQUEGUA', 'GENERAL SÁNCHEZ CERRO', 'LA CAPILLA'),
('180206', 'MOQUEGUA', 'GENERAL SÁNCHEZ CERRO', 'LLOQUE'),
('180207', 'MOQUEGUA', 'GENERAL SÁNCHEZ CERRO', 'MATALAQUE'),
('180208', 'MOQUEGUA', 'GENERAL SÁNCHEZ CERRO', 'PUQUINA'),
('180209', 'MOQUEGUA', 'GENERAL SÁNCHEZ CERRO', 'QUINISTAQUILLAS'),
('180210', 'MOQUEGUA', 'GENERAL SÁNCHEZ CERRO', 'UBINAS'),
('180211', 'MOQUEGUA', 'GENERAL SÁNCHEZ CERRO', 'YUNGA'),
('180301', 'MOQUEGUA', 'ILO', 'ILO'),
('180302', 'MOQUEGUA', 'ILO', 'EL ALGARROBAL'),
('180303', 'MOQUEGUA', 'ILO', 'PACOCHA'),
('190101', 'PASCO', 'PASCO', 'CHAUPIMARCA'),
('190102', 'PASCO', 'PASCO', 'HUACHON'),
('190103', 'PASCO', 'PASCO', 'HUARIACA'),
('190104', 'PASCO', 'PASCO', 'HUAYLLAY'),
('190105', 'PASCO', 'PASCO', 'NINACACA'),
('190106', 'PASCO', 'PASCO', 'PALLANCHACRA'),
('190107', 'PASCO', 'PASCO', 'PAUCARTAMBO'),
('190108', 'PASCO', 'PASCO', 'SAN FRANCISCO DE ASÍS DE YARUSYACAN'),
('190109', 'PASCO', 'PASCO', 'SIMON BOLÍVAR'),
('190110', 'PASCO', 'PASCO', 'TICLACAYAN'),
('190111', 'PASCO', 'PASCO', 'TINYAHUARCO'),
('190112', 'PASCO', 'PASCO', 'VICCO'),
('190113', 'PASCO', 'PASCO', 'YANACANCHA'),
('190201', 'PASCO', 'DANIEL ALCIDES CARRIÓN', 'YANAHUANCA'),
('190202', 'PASCO', 'DANIEL ALCIDES CARRIÓN', 'CHACAYAN'),
('190203', 'PASCO', 'DANIEL ALCIDES CARRIÓN', 'GOYLLARISQUIZGA'),
('190204', 'PASCO', 'DANIEL ALCIDES CARRIÓN', 'PAUCAR'),
('190205', 'PASCO', 'DANIEL ALCIDES CARRIÓN', 'SAN PEDRO DE PILLAO'),
('190206', 'PASCO', 'DANIEL ALCIDES CARRIÓN', 'SANTA ANA DE TUSI'),
('190207', 'PASCO', 'DANIEL ALCIDES CARRIÓN', 'TAPUC'),
('190208', 'PASCO', 'DANIEL ALCIDES CARRIÓN', 'VILCABAMBA'),
('190301', 'PASCO', 'OXAPAMPA', 'OXAPAMPA'),
('190302', 'PASCO', 'OXAPAMPA', 'CHONTABAMBA'),
('190303', 'PASCO', 'OXAPAMPA', 'HUANCABAMBA'),
('190304', 'PASCO', 'OXAPAMPA', 'PALCAZU'),
('190305', 'PASCO', 'OXAPAMPA', 'POZUZO'),
('190306', 'PASCO', 'OXAPAMPA', 'PUERTO BERMÚDEZ'),
('190307', 'PASCO', 'OXAPAMPA', 'VILLA RICA'),
('190308', 'PASCO', 'OXAPAMPA', 'CONSTITUCIÓN'),
('200101', 'PIURA', 'PIURA', 'PIURA'),
('200104', 'PIURA', 'PIURA', 'CASTILLA'),
('200105', 'PIURA', 'PIURA', 'CATACAOS'),
('200107', 'PIURA', 'PIURA', 'CURA MORI'),
('200108', 'PIURA', 'PIURA', 'EL TALLAN'),
('200109', 'PIURA', 'PIURA', 'LA ARENA'),
('200110', 'PIURA', 'PIURA', 'LA UNIÓN'),
('200111', 'PIURA', 'PIURA', 'LAS LOMAS'),
('200114', 'PIURA', 'PIURA', 'TAMBO GRANDE'),
('200115', 'PIURA', 'PIURA', 'VEINTISEIS DE OCTUBRE'),
('200201', 'PIURA', 'AYABACA', 'AYABACA'),
('200202', 'PIURA', 'AYABACA', 'FRIAS'),
('200203', 'PIURA', 'AYABACA', 'JILILI'),
('200204', 'PIURA', 'AYABACA', 'LAGUNAS'),
('200205', 'PIURA', 'AYABACA', 'MONTERO'),
('200206', 'PIURA', 'AYABACA', 'PACAIPAMPA'),
('200207', 'PIURA', 'AYABACA', 'PAIMAS'),
('200208', 'PIURA', 'AYABACA', 'SAPILLICA'),
('200209', 'PIURA', 'AYABACA', 'SICCHEZ'),
('200210', 'PIURA', 'AYABACA', 'SUYO'),
('200301', 'PIURA', 'HUANCABAMBA', 'HUANCABAMBA'),
('200302', 'PIURA', 'HUANCABAMBA', 'CANCHAQUE'),
('200303', 'PIURA', 'HUANCABAMBA', 'EL CARMEN DE LA FRONTERA'),
('200304', 'PIURA', 'HUANCABAMBA', 'HUARMACA'),
('200305', 'PIURA', 'HUANCABAMBA', 'LALAQUIZ'),
('200306', 'PIURA', 'HUANCABAMBA', 'SAN MIGUEL DE EL FAIQUE'),
('200307', 'PIURA', 'HUANCABAMBA', 'SONDOR'),
('200308', 'PIURA', 'HUANCABAMBA', 'SONDORILLO'),
('200401', 'PIURA', 'MORROPÓN', 'CHULUCANAS'),
('200402', 'PIURA', 'MORROPÓN', 'BUENOS AIRES'),
('200403', 'PIURA', 'MORROPÓN', 'CHALACO'),
('200404', 'PIURA', 'MORROPÓN', 'LA MATANZA'),
('200405', 'PIURA', 'MORROPÓN', 'MORROPON'),
('200406', 'PIURA', 'MORROPÓN', 'SALITRAL'),
('200407', 'PIURA', 'MORROPÓN', 'SAN JUAN DE BIGOTE'),
('200408', 'PIURA', 'MORROPÓN', 'SANTA CATALINA DE MOSSA'),
('200409', 'PIURA', 'MORROPÓN', 'SANTO DOMINGO'),
('200410', 'PIURA', 'MORROPÓN', 'YAMANGO'),
('200501', 'PIURA', 'PAITA', 'PAITA'),
('200502', 'PIURA', 'PAITA', 'AMOTAPE'),
('200503', 'PIURA', 'PAITA', 'ARENAL'),
('200504', 'PIURA', 'PAITA', 'COLAN'),
('200505', 'PIURA', 'PAITA', 'LA HUACA'),
('200506', 'PIURA', 'PAITA', 'TAMARINDO'),
('200507', 'PIURA', 'PAITA', 'VICHAYAL'),
('200601', 'PIURA', 'SULLANA', 'SULLANA'),
('200602', 'PIURA', 'SULLANA', 'BELLAVISTA'),
('200603', 'PIURA', 'SULLANA', 'IGNACIO ESCUDERO'),
('200604', 'PIURA', 'SULLANA', 'LANCONES'),
('200605', 'PIURA', 'SULLANA', 'MARCAVELICA'),
('200606', 'PIURA', 'SULLANA', 'MIGUEL CHECA'),
('200607', 'PIURA', 'SULLANA', 'QUERECOTILLO'),
('200608', 'PIURA', 'SULLANA', 'SALITRAL'),
('200701', 'PIURA', 'TALARA', 'PARIÑAS'),
('200702', 'PIURA', 'TALARA', 'EL ALTO'),
('200703', 'PIURA', 'TALARA', 'LA BREA'),
('200704', 'PIURA', 'TALARA', 'LOBITOS'),
('200705', 'PIURA', 'TALARA', 'LOS ORGANOS'),
('200706', 'PIURA', 'TALARA', 'MANCORA'),
('200801', 'PIURA', 'SECHURA', 'SECHURA'),
('200802', 'PIURA', 'SECHURA', 'BELLAVISTA DE LA UNIÓN'),
('200803', 'PIURA', 'SECHURA', 'BERNAL'),
('200804', 'PIURA', 'SECHURA', 'CRISTO NOS VALGA'),
('200805', 'PIURA', 'SECHURA', 'VICE'),
('200806', 'PIURA', 'SECHURA', 'RINCONADA LLICUAR'),
('210101', 'PUNO', 'PUNO', 'PUNO'),
('210102', 'PUNO', 'PUNO', 'ACORA'),
('210103', 'PUNO', 'PUNO', 'AMANTANI'),
('210104', 'PUNO', 'PUNO', 'ATUNCOLLA'),
('210105', 'PUNO', 'PUNO', 'CAPACHICA'),
('210106', 'PUNO', 'PUNO', 'CHUCUITO'),
('210107', 'PUNO', 'PUNO', 'COATA'),
('210108', 'PUNO', 'PUNO', 'HUATA'),
('210109', 'PUNO', 'PUNO', 'MAÑAZO'),
('210110', 'PUNO', 'PUNO', 'PAUCARCOLLA'),
('210111', 'PUNO', 'PUNO', 'PICHACANI'),
('210112', 'PUNO', 'PUNO', 'PLATERIA'),
('210113', 'PUNO', 'PUNO', 'SAN ANTONIO'),
('210114', 'PUNO', 'PUNO', 'TIQUILLACA'),
('210115', 'PUNO', 'PUNO', 'VILQUE'),
('210201', 'PUNO', 'AZÁNGARO', 'AZÁNGARO'),
('210202', 'PUNO', 'AZÁNGARO', 'ACHAYA'),
('210203', 'PUNO', 'AZÁNGARO', 'ARAPA'),
('210204', 'PUNO', 'AZÁNGARO', 'ASILLO'),
('210205', 'PUNO', 'AZÁNGARO', 'CAMINACA'),
('210206', 'PUNO', 'AZÁNGARO', 'CHUPA'),
('210207', 'PUNO', 'AZÁNGARO', 'JOSÉ DOMINGO CHOQUEHUANCA'),
('210208', 'PUNO', 'AZÁNGARO', 'MUÑANI'),
('210209', 'PUNO', 'AZÁNGARO', 'POTONI'),
('210210', 'PUNO', 'AZÁNGARO', 'SAMAN'),
('210211', 'PUNO', 'AZÁNGARO', 'SAN ANTON'),
('210212', 'PUNO', 'AZÁNGARO', 'SAN JOSÉ'),
('210213', 'PUNO', 'AZÁNGARO', 'SAN JUAN DE SALINAS'),
('210214', 'PUNO', 'AZÁNGARO', 'SANTIAGO DE PUPUJA'),
('210215', 'PUNO', 'AZÁNGARO', 'TIRAPATA'),
('210301', 'PUNO', 'CARABAYA', 'MACUSANI'),
('210302', 'PUNO', 'CARABAYA', 'AJOYANI'),
('210303', 'PUNO', 'CARABAYA', 'AYAPATA'),
('210304', 'PUNO', 'CARABAYA', 'COASA'),
('210305', 'PUNO', 'CARABAYA', 'CORANI'),
('210306', 'PUNO', 'CARABAYA', 'CRUCERO'),
('210307', 'PUNO', 'CARABAYA', 'ITUATA'),
('210308', 'PUNO', 'CARABAYA', 'OLLACHEA'),
('210309', 'PUNO', 'CARABAYA', 'SAN GABAN'),
('210310', 'PUNO', 'CARABAYA', 'USICAYOS'),
('210401', 'PUNO', 'CHUCUITO', 'JULI'),
('210402', 'PUNO', 'CHUCUITO', 'DESAGUADERO'),
('210403', 'PUNO', 'CHUCUITO', 'HUACULLANI'),
('210404', 'PUNO', 'CHUCUITO', 'KELLUYO'),
('210405', 'PUNO', 'CHUCUITO', 'PISACOMA'),
('210406', 'PUNO', 'CHUCUITO', 'POMATA'),
('210407', 'PUNO', 'CHUCUITO', 'ZEPITA'),
('210501', 'PUNO', 'EL COLLAO', 'ILAVE'),
('210502', 'PUNO', 'EL COLLAO', 'CAPAZO'),
('210503', 'PUNO', 'EL COLLAO', 'PILCUYO'),
('210504', 'PUNO', 'EL COLLAO', 'SANTA ROSA'),
('210505', 'PUNO', 'EL COLLAO', 'CONDURIRI'),
('210601', 'PUNO', 'HUANCANÉ', 'HUANCANE'),
('210602', 'PUNO', 'HUANCANÉ', 'COJATA'),
('210603', 'PUNO', 'HUANCANÉ', 'HUATASANI'),
('210604', 'PUNO', 'HUANCANÉ', 'INCHUPALLA'),
('210605', 'PUNO', 'HUANCANÉ', 'PUSI'),
('210606', 'PUNO', 'HUANCANÉ', 'ROSASPATA'),
('210607', 'PUNO', 'HUANCANÉ', 'TARACO'),
('210608', 'PUNO', 'HUANCANÉ', 'VILQUE CHICO'),
('210701', 'PUNO', 'LAMPA', 'LAMPA'),
('210702', 'PUNO', 'LAMPA', 'CABANILLA'),
('210703', 'PUNO', 'LAMPA', 'CALAPUJA'),
('210704', 'PUNO', 'LAMPA', 'NICASIO'),
('210705', 'PUNO', 'LAMPA', 'OCUVIRI'),
('210706', 'PUNO', 'LAMPA', 'PALCA'),
('210707', 'PUNO', 'LAMPA', 'PARATIA'),
('210708', 'PUNO', 'LAMPA', 'PUCARA'),
('210709', 'PUNO', 'LAMPA', 'SANTA LUCIA'),
('210710', 'PUNO', 'LAMPA', 'VILAVILA'),
('210801', 'PUNO', 'MELGAR', 'AYAVIRI'),
('210802', 'PUNO', 'MELGAR', 'ANTAUTA'),
('210803', 'PUNO', 'MELGAR', 'CUPI'),
('210804', 'PUNO', 'MELGAR', 'LLALLI'),
('210805', 'PUNO', 'MELGAR', 'MACARI'),
('210806', 'PUNO', 'MELGAR', 'NUÑOA'),
('210807', 'PUNO', 'MELGAR', 'ORURILLO'),
('210808', 'PUNO', 'MELGAR', 'SANTA ROSA'),
('210809', 'PUNO', 'MELGAR', 'UMACHIRI'),
('210901', 'PUNO', 'MOHO', 'MOHO'),
('210902', 'PUNO', 'MOHO', 'CONIMA'),
('210903', 'PUNO', 'MOHO', 'HUAYRAPATA'),
('210904', 'PUNO', 'MOHO', 'TILALI'),
('211001', 'PUNO', 'SAN ANTONIO DE PUTINA', 'PUTINA'),
('211002', 'PUNO', 'SAN ANTONIO DE PUTINA', 'ANANEA'),
('211003', 'PUNO', 'SAN ANTONIO DE PUTINA', 'PEDRO VILCA APAZA'),
('211004', 'PUNO', 'SAN ANTONIO DE PUTINA', 'QUILCAPUNCU'),
('211005', 'PUNO', 'SAN ANTONIO DE PUTINA', 'SINA'),
('211101', 'PUNO', 'SAN ROMÁN', 'JULIACA'),
('211102', 'PUNO', 'SAN ROMÁN', 'CABANA'),
('211103', 'PUNO', 'SAN ROMÁN', 'CABANILLAS'),
('211104', 'PUNO', 'SAN ROMÁN', 'CARACOTO'),
('211201', 'PUNO', 'SANDIA', 'SANDIA'),
('211202', 'PUNO', 'SANDIA', 'CUYOCUYO'),
('211203', 'PUNO', 'SANDIA', 'LIMBANI'),
('211204', 'PUNO', 'SANDIA', 'PATAMBUCO'),
('211205', 'PUNO', 'SANDIA', 'PHARA'),
('211206', 'PUNO', 'SANDIA', 'QUIACA'),
('211207', 'PUNO', 'SANDIA', 'SAN JUAN DEL ORO'),
('211208', 'PUNO', 'SANDIA', 'YANAHUAYA'),
('211209', 'PUNO', 'SANDIA', 'ALTO INAMBARI'),
('211210', 'PUNO', 'SANDIA', 'SAN PEDRO DE PUTINA PUNCO'),
('211301', 'PUNO', 'YUNGUYO', 'YUNGUYO'),
('211302', 'PUNO', 'YUNGUYO', 'ANAPIA'),
('211303', 'PUNO', 'YUNGUYO', 'COPANI'),
('211304', 'PUNO', 'YUNGUYO', 'CUTURAPI'),
('211305', 'PUNO', 'YUNGUYO', 'OLLARAYA'),
('211306', 'PUNO', 'YUNGUYO', 'TINICACHI'),
('211307', 'PUNO', 'YUNGUYO', 'UNICACHI'),
('220101', 'SAN MARTÍN', 'MOYOBAMBA', 'MOYOBAMBA'),
('220102', 'SAN MARTÍN', 'MOYOBAMBA', 'CALZADA'),
('220103', 'SAN MARTÍN', 'MOYOBAMBA', 'HABANA'),
('220104', 'SAN MARTÍN', 'MOYOBAMBA', 'JEPELACIO'),
('220105', 'SAN MARTÍN', 'MOYOBAMBA', 'SORITOR'),
('220106', 'SAN MARTÍN', 'MOYOBAMBA', 'YANTALO'),
('220201', 'SAN MARTÍN', 'BELLAVISTA', 'BELLAVISTA'),
('220202', 'SAN MARTÍN', 'BELLAVISTA', 'ALTO BIAVO'),
('220203', 'SAN MARTÍN', 'BELLAVISTA', 'BAJO BIAVO'),
('220204', 'SAN MARTÍN', 'BELLAVISTA', 'HUALLAGA'),
('220205', 'SAN MARTÍN', 'BELLAVISTA', 'SAN PABLO'),
('220206', 'SAN MARTÍN', 'BELLAVISTA', 'SAN RAFAEL'),
('220301', 'SAN MARTÍN', 'EL DORADO', 'SAN JOSÉ DE SISA'),
('220302', 'SAN MARTÍN', 'EL DORADO', 'AGUA BLANCA'),
('220303', 'SAN MARTÍN', 'EL DORADO', 'SAN MARTÍN'),
('220304', 'SAN MARTÍN', 'EL DORADO', 'SANTA ROSA'),
('220305', 'SAN MARTÍN', 'EL DORADO', 'SHATOJA'),
('220401', 'SAN MARTÍN', 'HUALLAGA', 'SAPOSOA'),
('220402', 'SAN MARTÍN', 'HUALLAGA', 'ALTO SAPOSOA'),
('220403', 'SAN MARTÍN', 'HUALLAGA', 'EL ESLABÓN'),
('220404', 'SAN MARTÍN', 'HUALLAGA', 'PISCOYACU'),
('220405', 'SAN MARTÍN', 'HUALLAGA', 'SACANCHE'),
('220406', 'SAN MARTÍN', 'HUALLAGA', 'TINGO DE SAPOSOA'),
('220501', 'SAN MARTÍN', 'LAMAS', 'LAMAS'),
('220502', 'SAN MARTÍN', 'LAMAS', 'ALONSO DE ALVARADO'),
('220503', 'SAN MARTÍN', 'LAMAS', 'BARRANQUITA'),
('220504', 'SAN MARTÍN', 'LAMAS', 'CAYNARACHI'),
('220505', 'SAN MARTÍN', 'LAMAS', 'CUÑUMBUQUI'),
('220506', 'SAN MARTÍN', 'LAMAS', 'PINTO RECODO'),
('220507', 'SAN MARTÍN', 'LAMAS', 'RUMISAPA'),
('220508', 'SAN MARTÍN', 'LAMAS', 'SAN ROQUE DE CUMBAZA'),
('220509', 'SAN MARTÍN', 'LAMAS', 'SHANAO'),
('220510', 'SAN MARTÍN', 'LAMAS', 'TABALOSOS'),
('220511', 'SAN MARTÍN', 'LAMAS', 'ZAPATERO'),
('220601', 'SAN MARTÍN', 'MARISCAL CÁCERES', 'JUANJUÍ'),
('220602', 'SAN MARTÍN', 'MARISCAL CÁCERES', 'CAMPANILLA'),
('220603', 'SAN MARTÍN', 'MARISCAL CÁCERES', 'HUICUNGO'),
('220604', 'SAN MARTÍN', 'MARISCAL CÁCERES', 'PACHIZA'),
('220605', 'SAN MARTÍN', 'MARISCAL CÁCERES', 'PAJARILLO'),
('220701', 'SAN MARTÍN', 'PICOTA', 'PICOTA'),
('220702', 'SAN MARTÍN', 'PICOTA', 'BUENOS AIRES'),
('220703', 'SAN MARTÍN', 'PICOTA', 'CASPISAPA'),
('220704', 'SAN MARTÍN', 'PICOTA', 'PILLUANA'),
('220705', 'SAN MARTÍN', 'PICOTA', 'PUCACACA'),
('220706', 'SAN MARTÍN', 'PICOTA', 'SAN CRISTÓBAL'),
('220707', 'SAN MARTÍN', 'PICOTA', 'SAN HILARIÓN'),
('220708', 'SAN MARTÍN', 'PICOTA', 'SHAMBOYACU'),
('220709', 'SAN MARTÍN', 'PICOTA', 'TINGO DE PONASA'),
('220710', 'SAN MARTÍN', 'PICOTA', 'TRES UNIDOS'),
('220801', 'SAN MARTÍN', 'RIOJA', 'RIOJA'),
('220802', 'SAN MARTÍN', 'RIOJA', 'AWAJUN'),
('220803', 'SAN MARTÍN', 'RIOJA', 'ELÍAS SOPLIN VARGAS'),
('220804', 'SAN MARTÍN', 'RIOJA', 'NUEVA CAJAMARCA'),
('220805', 'SAN MARTÍN', 'RIOJA', 'PARDO MIGUEL'),
('220806', 'SAN MARTÍN', 'RIOJA', 'POSIC'),
('220807', 'SAN MARTÍN', 'RIOJA', 'SAN FERNANDO'),
('220808', 'SAN MARTÍN', 'RIOJA', 'YORONGOS'),
('220809', 'SAN MARTÍN', 'RIOJA', 'YURACYACU'),
('220901', 'SAN MARTÍN', 'SAN MARTÍN', 'TARAPOTO'),
('220902', 'SAN MARTÍN', 'SAN MARTÍN', 'ALBERTO LEVEAU'),
('220903', 'SAN MARTÍN', 'SAN MARTÍN', 'CACATACHI'),
('220904', 'SAN MARTÍN', 'SAN MARTÍN', 'CHAZUTA'),
('220905', 'SAN MARTÍN', 'SAN MARTÍN', 'CHIPURANA'),
('220906', 'SAN MARTÍN', 'SAN MARTÍN', 'EL PORVENIR'),
('220907', 'SAN MARTÍN', 'SAN MARTÍN', 'HUIMBAYOC'),
('220908', 'SAN MARTÍN', 'SAN MARTÍN', 'JUAN GUERRA'),
('220909', 'SAN MARTÍN', 'SAN MARTÍN', 'LA BANDA DE SHILCAYO'),
('220910', 'SAN MARTÍN', 'SAN MARTÍN', 'MORALES'),
('220911', 'SAN MARTÍN', 'SAN MARTÍN', 'PAPAPLAYA'),
('220912', 'SAN MARTÍN', 'SAN MARTÍN', 'SAN ANTONIO'),
('220913', 'SAN MARTÍN', 'SAN MARTÍN', 'SAUCE'),
('220914', 'SAN MARTÍN', 'SAN MARTÍN', 'SHAPAJA'),
('221001', 'SAN MARTÍN', 'TOCACHE', 'TOCACHE'),
('221002', 'SAN MARTÍN', 'TOCACHE', 'NUEVO PROGRESO'),
('221003', 'SAN MARTÍN', 'TOCACHE', 'POLVORA'),
('221004', 'SAN MARTÍN', 'TOCACHE', 'SHUNTE'),
('221005', 'SAN MARTÍN', 'TOCACHE', 'UCHIZA'),
('230101', 'TACNA', 'TACNA', 'TACNA'),
('230102', 'TACNA', 'TACNA', 'ALTO DE LA ALIANZA'),
('230103', 'TACNA', 'TACNA', 'CALANA'),
('230104', 'TACNA', 'TACNA', 'CIUDAD NUEVA'),
('230105', 'TACNA', 'TACNA', 'INCLAN'),
('230106', 'TACNA', 'TACNA', 'PACHIA'),
('230107', 'TACNA', 'TACNA', 'PALCA'),
('230108', 'TACNA', 'TACNA', 'POCOLLAY'),
('230109', 'TACNA', 'TACNA', 'SAMA'),
('230110', 'TACNA', 'TACNA', 'CORONEL GREGORIO ALBARRACÍN LANCHIPA'),
('230111', 'TACNA', 'TACNA', 'LA YARADA LOS PALOS'),
('230201', 'TACNA', 'CANDARAVE', 'CANDARAVE'),
('230202', 'TACNA', 'CANDARAVE', 'CAIRANI'),
('230203', 'TACNA', 'CANDARAVE', 'CAMILACA'),
('230204', 'TACNA', 'CANDARAVE', 'CURIBAYA'),
('230205', 'TACNA', 'CANDARAVE', 'HUANUARA'),
('230206', 'TACNA', 'CANDARAVE', 'QUILAHUANI'),
('230301', 'TACNA', 'JORGE BASADRE', 'LOCUMBA'),
('230302', 'TACNA', 'JORGE BASADRE', 'ILABAYA'),
('230303', 'TACNA', 'JORGE BASADRE', 'ITE'),
('230401', 'TACNA', 'TARATA', 'TARATA'),
('230402', 'TACNA', 'TARATA', 'HÉROES ALBARRACÍN'),
('230403', 'TACNA', 'TARATA', 'ESTIQUE'),
('230404', 'TACNA', 'TARATA', 'ESTIQUE-PAMPA'),
('230405', 'TACNA', 'TARATA', 'SITAJARA'),
('230406', 'TACNA', 'TARATA', 'SUSAPAYA'),
('230407', 'TACNA', 'TARATA', 'TARUCACHI'),
('230408', 'TACNA', 'TARATA', 'TICACO'),
('240101', 'TUMBES', 'TUMBES', 'TUMBES'),
('240102', 'TUMBES', 'TUMBES', 'CORRALES'),
('240103', 'TUMBES', 'TUMBES', 'LA CRUZ'),
('240104', 'TUMBES', 'TUMBES', 'PAMPAS DE HOSPITAL'),
('240105', 'TUMBES', 'TUMBES', 'SAN JACINTO'),
('240106', 'TUMBES', 'TUMBES', 'SAN JUAN DE LA VIRGEN'),
('240201', 'TUMBES', 'CONTRALMIRANTE VILLAR', 'ZORRITOS'),
('240202', 'TUMBES', 'CONTRALMIRANTE VILLAR', 'CASITAS'),
('240203', 'TUMBES', 'CONTRALMIRANTE VILLAR', 'CANOAS DE PUNTA SAL'),
('240301', 'TUMBES', 'ZARUMILLA', 'ZARUMILLA'),
('240302', 'TUMBES', 'ZARUMILLA', 'AGUAS VERDES'),
('240303', 'TUMBES', 'ZARUMILLA', 'MATAPALO'),
('240304', 'TUMBES', 'ZARUMILLA', 'PAPAYAL'),
('250101', 'UCAYALI', 'CORONEL PORTILLO', 'CALLERIA'),
('250102', 'UCAYALI', 'CORONEL PORTILLO', 'CAMPOVERDE'),
('250103', 'UCAYALI', 'CORONEL PORTILLO', 'IPARIA'),
('250104', 'UCAYALI', 'CORONEL PORTILLO', 'MASISEA'),
('250105', 'UCAYALI', 'CORONEL PORTILLO', 'YARINACOCHA'),
('250106', 'UCAYALI', 'CORONEL PORTILLO', 'NUEVA REQUENA'),
('250107', 'UCAYALI', 'CORONEL PORTILLO', 'MANANTAY'),
('250201', 'UCAYALI', 'ATALAYA', 'RAYMONDI'),
('250202', 'UCAYALI', 'ATALAYA', 'SEPAHUA'),
('250203', 'UCAYALI', 'ATALAYA', 'TAHUANIA'),
('250204', 'UCAYALI', 'ATALAYA', 'YURUA'),
('250301', 'UCAYALI', 'PADRE ABAD', 'PADRE ABAD'),
('250302', 'UCAYALI', 'PADRE ABAD', 'IRAZOLA'),
('250303', 'UCAYALI', 'PADRE ABAD', 'CURIMANA'),
('250304', 'UCAYALI', 'PADRE ABAD', 'NESHUYA'),
('250305', 'UCAYALI', 'PADRE ABAD', 'ALEXANDER VON HUMBOLDT'),
('250401', 'UCAYALI', 'PURÚS', 'PURUS');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zg_usuariosempresas`
--

CREATE TABLE `zg_usuariosempresas` (
  `IdEmpresa` varchar(100) NOT NULL,
  `IdUsuario` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `zg_usuariosempresas`
--

INSERT INTO `zg_usuariosempresas` (`IdEmpresa`, `IdUsuario`) VALUES
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '2BVtUZ0QCdYfWeaWgMU6DLwmR6E2'),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-20555555555', '2BVtUZ0QCdYfWeaWgMU6DLwmR6E2'),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-22222222222', '2BVtUZ0QCdYfWeaWgMU6DLwmR6E2'),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-33333333333', '2BVtUZ0QCdYfWeaWgMU6DLwmR6E2'),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2-12345678911', 'KKZln2PiRLfPLo0Hh9sla2wmW6t2'),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2-12345678911', 'KKZln2PiRLfPLo0Hh9sla2wmW6t2-1'),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2-12345678911', 'KKZln2PiRLfPLo0Hh9sla2wmW6t2-2'),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2-51111111111', 'KKZln2PiRLfPLo0Hh9sla2wmW6t2');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zg_usuariosmenus`
--

CREATE TABLE `zg_usuariosmenus` (
  `IdUsuario` varchar(100) NOT NULL,
  `IdMenu` varchar(12) NOT NULL,
  `Accion` varchar(50) DEFAULT NULL,
  `Activo` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `zg_usuariosmenus`
--

INSERT INTO `zg_usuariosmenus` (`IdUsuario`, `IdMenu`, `Accion`, `Activo`) VALUES
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', '0101', '1111', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', '0102', '1111', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', '0103', '1111', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', '0104', '1111', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', '0105', '1111', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', '0201', '1111', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', '0202', '1111', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', '0203', '1111', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', '0204', '1111', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', '0205', '1111', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', '0206', '1111', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', '0207', '1111', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', '0208', '1111', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', '0301', '1111', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', '0302', '1111', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', '0303', '1111', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', '0401', '1111', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', '0402', '1111', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', '0403', '1111', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', '0404', '1111', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', '0405', '1111', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', '0501', '1111', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2', '0101', '1111', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2', '0102', '1111', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2', '0103', '1111', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2', '0104', '1111', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2', '0105', '1111', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2', '0201', '1111', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2', '0202', '1111', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2', '0203', '1111', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2', '0204', '1111', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2', '0205', '1100', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2', '0206', '1111', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2', '0207', '1111', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2', '0208', '1111', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2', '0301', '1111', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2', '0302', '1111', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2', '0303', '1111', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2', '0401', '1111', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2', '0402', '1111', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2', '0403', '1111', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2', '0404', '1111', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2', '0405', '1111', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2', '0501', '1111', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2-2', '0101', '1100', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2-2', '0102', '0100', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2-2', '0201', '1100', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zg_usuariosplanes`
--

CREATE TABLE `zg_usuariosplanes` (
  `IdUsuario` varchar(50) NOT NULL,
  `IdPlan` int(11) NOT NULL,
  `Fecha` date DEFAULT NULL,
  `Hora` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `zg_usuariosplanes`
--

INSERT INTO `zg_usuariosplanes` (`IdUsuario`, `IdPlan`, `Fecha`, `Hora`) VALUES
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', 7, '2019-06-11', '16:47:03'),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2', 8, '2019-06-12', '08:44:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zg_usuariossucursales`
--

CREATE TABLE `zg_usuariossucursales` (
  `IdEmpresa` varchar(100) NOT NULL,
  `IdUsuario` varchar(100) NOT NULL,
  `IdSucursal` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `zg_usuariossucursales`
--

INSERT INTO `zg_usuariossucursales` (`IdEmpresa`, `IdUsuario`, `IdSucursal`) VALUES
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', '001'),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-12345678911', '2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', '002'),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-20555555555', '2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', '001'),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-22222222222', '2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', '001'),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-33333333333', '2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', '001'),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2-12345678911', 'KKZln2PiRLfPLo0Hh9sla2wmW6t2', '001'),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2-12345678911', 'KKZln2PiRLfPLo0Hh9sla2wmW6t2-1', '001'),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2-12345678911', 'KKZln2PiRLfPLo0Hh9sla2wmW6t2-2', '001'),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2-51111111111', 'KKZln2PiRLfPLo0Hh9sla2wmW6t2', '001');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zg_zmenus`
--

CREATE TABLE `zg_zmenus` (
  `IdModulo` int(11) NOT NULL,
  `IdMenu` varchar(12) NOT NULL,
  `Nombre` varchar(20) NOT NULL,
  `SubMenu` tinyint(4) NOT NULL,
  `Proceso` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `zg_zmenus`
--

INSERT INTO `zg_zmenus` (`IdModulo`, `IdMenu`, `Nombre`, `SubMenu`, `Proceso`) VALUES
(2, '01', 'Seguridad', 0, 0),
(2, '0101', 'Empresas', 1, 0),
(2, '0102', 'Usuarios', 1, 0),
(2, '0103', 'Cambio_Clave', 1, 0),
(2, '0104', 'Bitacora', 1, 0),
(2, '02', 'Inventarios', 0, 0),
(2, '0201', 'Tipo_Documentos', 1, 0),
(2, '0202', 'Lineas', 1, 0),
(2, '0203', 'SubLineas', 1, 0),
(2, '0204', 'Almacenes', 1, 0),
(2, '0205', 'Sucursales', 1, 0),
(2, '0206', 'Zonas', 1, 0),
(2, '0207', 'Medidas', 1, 0),
(2, '0208', 'Items', 1, 0),
(2, '03', 'Compras', 0, 0),
(2, '0301', 'Correlativos', 1, 0),
(2, '0302', 'Proveedores', 1, 0),
(2, '0303', 'Orden_Compra', 1, 1),
(2, '04', 'Ventas', 0, 0),
(2, '0401', 'Ventas', 1, 0),
(2, '0402', 'Productos', 1, 0),
(2, '0403', 'Clientes', 1, 0),
(2, '0404', 'Nueva_Venta', 1, 1),
(2, '0405', 'Factura_Ventas', 1, 0),
(2, '05', 'Tesoreria', 0, 0),
(2, '0501', 'Caja_Chica', 1, 1),
(3, '10', 'Registros', 0, 0),
(3, '1001', 'Empleados', 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zg_zmodulos`
--

CREATE TABLE `zg_zmodulos` (
  `IdModulo` int(11) NOT NULL,
  `Codigo` varchar(2) DEFAULT NULL,
  `Descripcion` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `zg_zmodulos`
--

INSERT INTO `zg_zmodulos` (`IdModulo`, `Codigo`, `Descripcion`) VALUES
(1, '01', 'Contabilidad.Net'),
(2, '02', 'Logistica.Net'),
(3, '03', 'Planillas.Net');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zg_zplanes`
--

CREATE TABLE `zg_zplanes` (
  `IdPlan` int(11) NOT NULL,
  `IdModulo` int(11) NOT NULL,
  `Descripcion` varchar(100) DEFAULT NULL,
  `Precio` decimal(18,2) DEFAULT NULL,
  `ImgagenPlan` varchar(1000) DEFAULT NULL,
  `DiasDemo` int(11) DEFAULT NULL,
  `NroEmpresas` int(11) DEFAULT NULL,
  `NroUsuarios` int(11) DEFAULT NULL,
  `Activo` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `zg_zplanes`
--

INSERT INTO `zg_zplanes` (`IdPlan`, `IdModulo`, `Descripcion`, `Precio`, `ImgagenPlan`, `DiasDemo`, `NroEmpresas`, `NroUsuarios`, `Activo`) VALUES
(1, 1, 'DEMO', '0.00', '', 30, 1, 1, 1),
(2, 1, 'STANDART', '50.00', '', 0, 5, 1, 1),
(3, 1, 'BUSSINESS', '100.00', '', 0, 15, 2, 1),
(4, 1, 'PREMIUM', '150.00', '', 0, 30, 5, 1),
(5, 1, 'ULTIMATE', '300.00', '', 0, 500, 500, 1),
(6, 2, 'DEMO', '0.00', '', 30, 1, 1, 1),
(7, 2, 'STANDART', '50.00', '', 0, 5, 1, 1),
(8, 2, 'BUSSINESS', '100.00', '', 0, 15, 2, 1),
(9, 2, 'PREMIUM', '150.00', '', 0, 30, 5, 1),
(10, 2, 'ULTIMATE', '300.00', '', 0, 500, 500, 1),
(11, 3, 'DEMO', '0.00', '', 30, 1, 1, 1),
(12, 3, 'STANDART', '50.00', '', 0, 5, 1, 1),
(13, 3, 'BUSSINESS', '100.00', '', 0, 15, 2, 1),
(14, 3, 'PREMIUM', '150.00', '', 0, 30, 5, 1),
(15, 3, 'ULTIMATE', '300.00', '', 0, 500, 500, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zg_zusuarios`
--

CREATE TABLE `zg_zusuarios` (
  `IdUsuario` varchar(100) NOT NULL,
  `IdUsuarioAuth` varchar(50) DEFAULT NULL,
  `Nombre` varchar(30) DEFAULT NULL,
  `LogLogin` varchar(50) NOT NULL,
  `LogClave` varchar(400) NOT NULL,
  `Estado` int(11) DEFAULT NULL,
  `Foto` varchar(1000) DEFAULT NULL,
  `IdUsuarioAuthKey` varchar(50) NOT NULL,
  `FechaRegistro` datetime DEFAULT NULL,
  `PeriodoIniFac` int(11) DEFAULT NULL,
  `PeriodoFinfac` int(11) DEFAULT NULL,
  `Telefono` varchar(50) DEFAULT NULL,
  `Activo` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `zg_zusuarios`
--

INSERT INTO `zg_zusuarios` (`IdUsuario`, `IdUsuarioAuth`, `Nombre`, `LogLogin`, `LogClave`, `Estado`, `Foto`, `IdUsuarioAuthKey`, `FechaRegistro`, `PeriodoIniFac`, `PeriodoFinfac`, `Telefono`, `Activo`) VALUES
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', '2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', 'prueba', 'test@email.com', 'AEu4IL2vbH_0BjNmGHJi4aAmZaJYX-kiEsEQ36e3SfLU0O2J0goxdOK11qrWioWsZkYO1niE5pdxirDCNqV3w3S4NoZ4acW6-PmlS1exi2j1p4yGjCG1_bmiDay2fPysXP-RUCYcrYDBcFODqWrxKwF3hKR5N93ZM5rY05Pdvm5RVQz-zOnpxZUg2qZpG_owY3cYU8MjkasEkLl_yPzYwn2aZcLFH1PbqQ', 0, 'FotoUser.jpg', '', '0000-00-00 00:00:00', 2019, 0, '45655588', 1),
('2BVtUZ0QCdYfWeaWgMU6DLwmR6E2-1', '', 'anita', 'anita@email.com', '', 0, 'FotoUser.jpg', '2BVtUZ0QCdYfWeaWgMU6DLwmR6E2', '2019-06-12 00:00:00', NULL, NULL, '6366655', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2', 'KKZln2PiRLfPLo0Hh9sla2wmW6t2', 'Andre', 'emp5@email.com', 'AEu4IL2xrAWtOldDWCz4aza2q8Drpa7mT2DDyS9Lj8CAkDoiAv9X4pYgjo7wuWJDu9v2OR-MBd_LUDI3QML18PW5hQBwg-GuIqNxrreTyzVNxPKBweW2ocXhZcx70t8Dk9vzITtkvIWVZXuTExh8Dcrp9BVZJDfhUS_JSRr3jZi1QiRZxvSb46RekBe7HWji0Kloa0NiLg1m5wXFThuf1TwYA_A1D3RZbA', 0, 'FotoUser.jpg', '', '0000-00-00 00:00:00', 2019, 0, NULL, 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2-1', '', 'alberto aaaaaa', 'albert@email.com', 'albert@email.com', 0, 'FotoUser.jpg', 'KKZln2PiRLfPLo0Hh9sla2wmW6t2', '2019-06-12 00:00:00', NULL, NULL, '55555555', 1),
('KKZln2PiRLfPLo0Hh9sla2wmW6t2-2', 'pg9qO9aCL6bTlTrlXXqK7Uidssc2', 'usuario1', 'empr2@gmail.com', 'AEu4IL0JDOQE6NGLmm-Y9WainCAVVrBBEYHDtPUx1V0e4rbUMD2KoszbBdr3jHjzB5FgZHU7cQun_BOmbpJpAy8xDLmdYU8oOfzt_Uqw3klo6TsFiOn1qux2y5RYo8CkRVYRkPB0QqciS_sSjadlsCcW5C_-R6J5UHavQ_R0oUItTETdzB-LUUniuY7rZfe5brElWVfU1YWQSnLx64LwUUmGMupoaHSjUA', 0, '', 'KKZln2PiRLfPLo0Hh9sla2wmW6t2', '2019-06-12 00:00:00', NULL, NULL, '323232', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `gen_monedas`
--
ALTER TABLE `gen_monedas`
  ADD PRIMARY KEY (`IdEmpresa`,`IdMoneda`),
  ADD KEY `Idx_IdEmpresa` (`IdEmpresa`),
  ADD KEY `Idx_IdMoneda` (`IdMoneda`);

--
-- Indices de la tabla `gen_tipoproducto`
--
ALTER TABLE `gen_tipoproducto`
  ADD PRIMARY KEY (`IdTipoProducto`),
  ADD KEY `Idx_IdTipoProducto` (`IdTipoProducto`);

--
-- Indices de la tabla `lo_almacenes`
--
ALTER TABLE `lo_almacenes`
  ADD PRIMARY KEY (`IdEmpresa`,`IdAlmacen`),
  ADD KEY `Idx_IdEmpresa` (`IdEmpresa`),
  ADD KEY `Idx_IdAlmacen` (`IdAlmacen`);

--
-- Indices de la tabla `lo_empresasmonedas`
--
ALTER TABLE `lo_empresasmonedas`
  ADD PRIMARY KEY (`IdEmpresa`,`IdMoneda`),
  ADD KEY `Idx_IdEmpresa` (`IdEmpresa`),
  ADD KEY `Idx_IdMoneda` (`IdMoneda`);

--
-- Indices de la tabla `lo_impuestos`
--
ALTER TABLE `lo_impuestos`
  ADD PRIMARY KEY (`IdEmpresa`,`IdImpuesto`),
  ADD KEY `Idx_IdEmpresa` (`IdEmpresa`),
  ADD KEY `Idx_IdImpuesto` (`IdImpuesto`);

--
-- Indices de la tabla `lo_lineas`
--
ALTER TABLE `lo_lineas`
  ADD PRIMARY KEY (`IdEmpresa`,`IdAlmacen`,`IdLinea`,`IdPropiedad1`),
  ADD KEY `Idx_IdLinea` (`IdLinea`,`IdPropiedad2`),
  ADD KEY `Idx_IdEmpresa` (`IdEmpresa`),
  ADD KEY `Idx_IdAlmacen` (`IdAlmacen`),
  ADD KEY `Idx_IdPropiedad1` (`IdPropiedad1`);

--
-- Indices de la tabla `lo_listapreciosdet`
--
ALTER TABLE `lo_listapreciosdet`
  ADD PRIMARY KEY (`IdEmpresa`,`IdProducto`,`IdListaPrecio`,`IdPropiedad1`,`Codigo`),
  ADD KEY `Idx_IdEmpresa` (`IdEmpresa`),
  ADD KEY `Idx_IdProducto` (`IdProducto`),
  ADD KEY `Idx_IdListaPrecio` (`IdListaPrecio`),
  ADD KEY `FK_ListaPreciosDet_propiedades1` (`IdPropiedad1`),
  ADD KEY `Codigo` (`Codigo`);

--
-- Indices de la tabla `lo_listapreciosenc`
--
ALTER TABLE `lo_listapreciosenc`
  ADD PRIMARY KEY (`IdEmpresa`,`IdListaPrecio`),
  ADD KEY `Idx_IdEmpresa` (`IdEmpresa`),
  ADD KEY `Idx_IdListaPrecio` (`IdListaPrecio`);

--
-- Indices de la tabla `lo_origenes`
--
ALTER TABLE `lo_origenes`
  ADD PRIMARY KEY (`IdEmpresa`,`IdOrigen`),
  ADD KEY `Idx_IdEmpresa` (`IdEmpresa`);

--
-- Indices de la tabla `lo_productos`
--
ALTER TABLE `lo_productos`
  ADD PRIMARY KEY (`IdEmpresa`,`IdProducto`),
  ADD KEY `Idx_Idproducto` (`IdProducto`),
  ADD KEY `Idx_productos` (`IdEmpresa`,`IdAlmacen`,`IdSubLinea`);

--
-- Indices de la tabla `lo_productosdetalles`
--
ALTER TABLE `lo_productosdetalles`
  ADD PRIMARY KEY (`IdEmpresa`,`IdProducto`,`IdProductoDet`,`IdPropiedad`),
  ADD KEY `Idx_IdEmpresa` (`IdEmpresa`),
  ADD KEY `Idx_IdProducto` (`IdProducto`),
  ADD KEY `Idx_IdProductoDet` (`IdProductoDet`),
  ADD KEY `Idx_IdPropiedad` (`IdPropiedad`);

--
-- Indices de la tabla `lo_propiedades`
--
ALTER TABLE `lo_propiedades`
  ADD PRIMARY KEY (`IdEmpresa`,`IdPropiedad`),
  ADD KEY `Idx_IdEmpresa` (`IdEmpresa`),
  ADD KEY `Idx_IdPropiedad` (`IdPropiedad`);

--
-- Indices de la tabla `lo_propiedadesdetalles`
--
ALTER TABLE `lo_propiedadesdetalles`
  ADD PRIMARY KEY (`IdEmpresa`,`IdPropiedad`,`Codigo`),
  ADD KEY `Idx_IdEmpresa` (`IdEmpresa`),
  ADD KEY `Idx_IdPropiedad` (`IdPropiedad`),
  ADD KEY `Codigo` (`Codigo`);

--
-- Indices de la tabla `lo_sublineas`
--
ALTER TABLE `lo_sublineas`
  ADD PRIMARY KEY (`IdEmpresa`,`IdLinea`,`IdSubLinea`),
  ADD KEY `Idx_lo_sublineas` (`IdEmpresa`,`IdLinea`,`IdSubLinea`);

--
-- Indices de la tabla `lo_sucursaleslistaprecios`
--
ALTER TABLE `lo_sucursaleslistaprecios`
  ADD PRIMARY KEY (`IdEmpresa`,`IdSucursal`,`IdListaPrecio`),
  ADD KEY `Idx_IdEmpresa` (`IdEmpresa`),
  ADD KEY `Idx_IdSucursal` (`IdSucursal`),
  ADD KEY `Idx_IdListaPrecio` (`IdListaPrecio`);

--
-- Indices de la tabla `lo_tipodocumentos`
--
ALTER TABLE `lo_tipodocumentos`
  ADD PRIMARY KEY (`IdEmpresa`,`IdTipoDocumento`),
  ADD KEY `IdTipoDocumento` (`IdTipoDocumento`);

--
-- Indices de la tabla `stipodatosmysql`
--
ALTER TABLE `stipodatosmysql`
  ADD PRIMARY KEY (`IdTipDat`);

--
-- Indices de la tabla `zg_correlativos`
--
ALTER TABLE `zg_correlativos`
  ADD PRIMARY KEY (`IdEmpresa`,`IdSucursal`,`IdTipoDocumento`,`Serie`),
  ADD KEY `FK_correlativos_empresa` (`IdEmpresa`),
  ADD KEY `FK_correlativos_tipodocumentos` (`IdTipoDocumento`),
  ADD KEY `FK_correlativos_sucursales` (`IdSucursal`),
  ADD KEY `Serie` (`Serie`);

--
-- Indices de la tabla `zg_empresas`
--
ALTER TABLE `zg_empresas`
  ADD PRIMARY KEY (`IdEmpresa`),
  ADD KEY `Idx_zg_empresas` (`IdEmpresa`);

--
-- Indices de la tabla `zg_sucursales`
--
ALTER TABLE `zg_sucursales`
  ADD PRIMARY KEY (`IdEmpresa`,`IdSucursal`),
  ADD KEY `Idx_zg_usuariosempresas` (`IdEmpresa`),
  ADD KEY `IdSucursal` (`IdSucursal`);

--
-- Indices de la tabla `zg_tipodocumentosmenus`
--
ALTER TABLE `zg_tipodocumentosmenus`
  ADD PRIMARY KEY (`IdEmpresa`,`IdTipoDocumento`,`IdMenu`),
  ADD KEY `FK_tipodocumentosmenus_empresas` (`IdEmpresa`),
  ADD KEY `FK_tipodocumentosmenus_tipodocumentos` (`IdTipoDocumento`),
  ADD KEY `FK_tipodocumentosmenus_menus` (`IdMenu`);

--
-- Indices de la tabla `zg_usuariosempresas`
--
ALTER TABLE `zg_usuariosempresas`
  ADD PRIMARY KEY (`IdEmpresa`,`IdUsuario`),
  ADD KEY `Idx_zg_usuariosempresas` (`IdEmpresa`,`IdUsuario`),
  ADD KEY `FK_usuariosempresas_usuarios` (`IdUsuario`);

--
-- Indices de la tabla `zg_usuariosmenus`
--
ALTER TABLE `zg_usuariosmenus`
  ADD PRIMARY KEY (`IdUsuario`,`IdMenu`),
  ADD KEY `Idx_zg_usuariosmenus` (`IdUsuario`,`IdMenu`);

--
-- Indices de la tabla `zg_usuariosplanes`
--
ALTER TABLE `zg_usuariosplanes`
  ADD PRIMARY KEY (`IdUsuario`,`IdPlan`),
  ADD KEY `Idx_zg_usuariosplanes` (`IdUsuario`,`IdPlan`),
  ADD KEY `FK_usuariosplanes_planes` (`IdPlan`);

--
-- Indices de la tabla `zg_usuariossucursales`
--
ALTER TABLE `zg_usuariossucursales`
  ADD PRIMARY KEY (`IdEmpresa`,`IdUsuario`,`IdSucursal`),
  ADD KEY `FK_usuariossucursales_usuarios` (`IdUsuario`),
  ADD KEY `Idx_zg_usuariosempresas` (`IdEmpresa`,`IdUsuario`,`IdSucursal`);

--
-- Indices de la tabla `zg_zmenus`
--
ALTER TABLE `zg_zmenus`
  ADD PRIMARY KEY (`IdMenu`,`IdModulo`),
  ADD KEY `Idx_zmenus_zmodulos` (`IdMenu`),
  ADD KEY `FK_zmenus_zmodulos` (`IdModulo`);

--
-- Indices de la tabla `zg_zmodulos`
--
ALTER TABLE `zg_zmodulos`
  ADD PRIMARY KEY (`IdModulo`),
  ADD KEY `Idx_zmodulos` (`IdModulo`);

--
-- Indices de la tabla `zg_zplanes`
--
ALTER TABLE `zg_zplanes`
  ADD PRIMARY KEY (`IdPlan`,`IdModulo`),
  ADD KEY `Idx_zplanes_zmodulos` (`IdPlan`,`IdModulo`),
  ADD KEY `FK_zplanes_zmodulos` (`IdModulo`);

--
-- Indices de la tabla `zg_zusuarios`
--
ALTER TABLE `zg_zusuarios`
  ADD PRIMARY KEY (`IdUsuario`),
  ADD KEY `Idx_zusuario` (`IdUsuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `stipodatosmysql`
--
ALTER TABLE `stipodatosmysql`
  MODIFY `IdTipDat` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `gen_monedas`
--
ALTER TABLE `gen_monedas`
  ADD CONSTRAINT `FK_Monedas_empresas` FOREIGN KEY (`IdEmpresa`) REFERENCES `zg_empresas` (`IdEmpresa`);

--
-- Filtros para la tabla `lo_almacenes`
--
ALTER TABLE `lo_almacenes`
  ADD CONSTRAINT `FK_almacenes_empresas` FOREIGN KEY (`IdEmpresa`) REFERENCES `zg_empresas` (`IdEmpresa`);

--
-- Filtros para la tabla `lo_empresasmonedas`
--
ALTER TABLE `lo_empresasmonedas`
  ADD CONSTRAINT `FK_EmpresasMonedas_empresas` FOREIGN KEY (`IdEmpresa`) REFERENCES `zg_empresas` (`IdEmpresa`),
  ADD CONSTRAINT `FK_EmpresasMonedas_monedas` FOREIGN KEY (`IdMoneda`) REFERENCES `gen_monedas` (`IdMoneda`);

--
-- Filtros para la tabla `lo_impuestos`
--
ALTER TABLE `lo_impuestos`
  ADD CONSTRAINT `FK_Impuestos_empresas` FOREIGN KEY (`IdEmpresa`) REFERENCES `zg_empresas` (`IdEmpresa`);

--
-- Filtros para la tabla `lo_lineas`
--
ALTER TABLE `lo_lineas`
  ADD CONSTRAINT `FK_lineas_almacenes` FOREIGN KEY (`IdAlmacen`) REFERENCES `lo_almacenes` (`IdAlmacen`),
  ADD CONSTRAINT `FK_lineas_empresas` FOREIGN KEY (`IdEmpresa`) REFERENCES `zg_empresas` (`IdEmpresa`),
  ADD CONSTRAINT `FK_lineas_propiedades` FOREIGN KEY (`IdPropiedad1`) REFERENCES `lo_propiedades` (`IdPropiedad`);

--
-- Filtros para la tabla `lo_listapreciosdet`
--
ALTER TABLE `lo_listapreciosdet`
  ADD CONSTRAINT `FK_ListaPreciosDet_ListaPreciosEnc` FOREIGN KEY (`IdListaPrecio`) REFERENCES `lo_listapreciosenc` (`IdListaPrecio`),
  ADD CONSTRAINT `FK_ListaPreciosDet_empresas` FOREIGN KEY (`IdEmpresa`) REFERENCES `zg_empresas` (`IdEmpresa`),
  ADD CONSTRAINT `FK_ListaPreciosDet_productos` FOREIGN KEY (`IdProducto`) REFERENCES `lo_productos` (`IdProducto`),
  ADD CONSTRAINT `FK_ListaPreciosDet_propiedades1` FOREIGN KEY (`IdPropiedad1`) REFERENCES `lo_propiedades` (`IdPropiedad`);

--
-- Filtros para la tabla `lo_listapreciosenc`
--
ALTER TABLE `lo_listapreciosenc`
  ADD CONSTRAINT `FK_lo_ListaPreciosEnc` FOREIGN KEY (`IdEmpresa`) REFERENCES `zg_empresas` (`IdEmpresa`);

--
-- Filtros para la tabla `lo_origenes`
--
ALTER TABLE `lo_origenes`
  ADD CONSTRAINT `FK_Origenes_empresas` FOREIGN KEY (`IdEmpresa`) REFERENCES `zg_empresas` (`IdEmpresa`);

--
-- Filtros para la tabla `lo_productos`
--
ALTER TABLE `lo_productos`
  ADD CONSTRAINT `FK_productos_empresas` FOREIGN KEY (`IdEmpresa`) REFERENCES `zg_empresas` (`IdEmpresa`);

--
-- Filtros para la tabla `lo_productosdetalles`
--
ALTER TABLE `lo_productosdetalles`
  ADD CONSTRAINT `FK_productosDet_empresas` FOREIGN KEY (`IdEmpresa`) REFERENCES `zg_empresas` (`IdEmpresa`),
  ADD CONSTRAINT `FK_productosDet_productos` FOREIGN KEY (`IdProducto`) REFERENCES `lo_productos` (`IdProducto`),
  ADD CONSTRAINT `FK_productosDet_propiedades` FOREIGN KEY (`IdPropiedad`) REFERENCES `lo_propiedades` (`IdPropiedad`);

--
-- Filtros para la tabla `lo_propiedades`
--
ALTER TABLE `lo_propiedades`
  ADD CONSTRAINT `FK_propiedades_empresas` FOREIGN KEY (`IdEmpresa`) REFERENCES `zg_empresas` (`IdEmpresa`);

--
-- Filtros para la tabla `lo_propiedadesdetalles`
--
ALTER TABLE `lo_propiedadesdetalles`
  ADD CONSTRAINT `FK_propiedadesDet_empresas` FOREIGN KEY (`IdEmpresa`) REFERENCES `zg_empresas` (`IdEmpresa`),
  ADD CONSTRAINT `FK_propiedadesDet_propiedades` FOREIGN KEY (`IdPropiedad`) REFERENCES `lo_propiedades` (`IdPropiedad`);

--
-- Filtros para la tabla `lo_sucursaleslistaprecios`
--
ALTER TABLE `lo_sucursaleslistaprecios`
  ADD CONSTRAINT `FK_SucListaPrecios_empresas` FOREIGN KEY (`IdEmpresa`) REFERENCES `zg_empresas` (`IdEmpresa`),
  ADD CONSTRAINT `FK_SucListaPrecios_listaprecios` FOREIGN KEY (`IdListaPrecio`) REFERENCES `lo_listapreciosenc` (`IdListaPrecio`),
  ADD CONSTRAINT `FK_SucListaPrecios_sucursales` FOREIGN KEY (`IdSucursal`) REFERENCES `zg_sucursales` (`IdSucursal`);

--
-- Filtros para la tabla `lo_tipodocumentos`
--
ALTER TABLE `lo_tipodocumentos`
  ADD CONSTRAINT `FK_tipodocumentos_empresas` FOREIGN KEY (`IdEmpresa`) REFERENCES `zg_empresas` (`IdEmpresa`);

--
-- Filtros para la tabla `zg_correlativos`
--
ALTER TABLE `zg_correlativos`
  ADD CONSTRAINT `FK_correlativos_empresa` FOREIGN KEY (`IdEmpresa`) REFERENCES `zg_empresas` (`IdEmpresa`),
  ADD CONSTRAINT `FK_correlativos_sucursales` FOREIGN KEY (`IdSucursal`) REFERENCES `zg_sucursales` (`IdSucursal`),
  ADD CONSTRAINT `FK_correlativos_tipodocumentos` FOREIGN KEY (`IdTipoDocumento`) REFERENCES `lo_tipodocumentos` (`IdTipoDocumento`);

--
-- Filtros para la tabla `zg_sucursales`
--
ALTER TABLE `zg_sucursales`
  ADD CONSTRAINT `FK_sucursales_empresas` FOREIGN KEY (`IdEmpresa`) REFERENCES `zg_empresas` (`IdEmpresa`);

--
-- Filtros para la tabla `zg_tipodocumentosmenus`
--
ALTER TABLE `zg_tipodocumentosmenus`
  ADD CONSTRAINT `FK_tipodocumentosmenus_empresas` FOREIGN KEY (`IdEmpresa`) REFERENCES `zg_empresas` (`IdEmpresa`),
  ADD CONSTRAINT `FK_tipodocumentosmenus_menus` FOREIGN KEY (`IdMenu`) REFERENCES `zg_zmenus` (`IdMenu`),
  ADD CONSTRAINT `FK_tipodocumentosmenus_tipodocs` FOREIGN KEY (`IdTipoDocumento`) REFERENCES `lo_tipodocumentos` (`IdTipoDocumento`);

--
-- Filtros para la tabla `zg_usuariosempresas`
--
ALTER TABLE `zg_usuariosempresas`
  ADD CONSTRAINT `FK_usuariosempresas_empresas` FOREIGN KEY (`IdEmpresa`) REFERENCES `zg_empresas` (`IdEmpresa`),
  ADD CONSTRAINT `FK_usuariosempresas_usuarios` FOREIGN KEY (`IdUsuario`) REFERENCES `zg_zusuarios` (`IdUsuario`);

--
-- Filtros para la tabla `zg_usuariosmenus`
--
ALTER TABLE `zg_usuariosmenus`
  ADD CONSTRAINT `FK_usuariosmenus_usuarios` FOREIGN KEY (`IdUsuario`) REFERENCES `zg_zusuarios` (`IdUsuario`);

--
-- Filtros para la tabla `zg_usuariosplanes`
--
ALTER TABLE `zg_usuariosplanes`
  ADD CONSTRAINT `FK_usuariosplanes_planes` FOREIGN KEY (`IdPlan`) REFERENCES `zg_zplanes` (`IdPlan`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_usuariosplanes_usuarios` FOREIGN KEY (`IdUsuario`) REFERENCES `zg_zusuarios` (`IdUsuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `zg_usuariossucursales`
--
ALTER TABLE `zg_usuariossucursales`
  ADD CONSTRAINT `FK_usuariossucursales_empresas` FOREIGN KEY (`IdEmpresa`) REFERENCES `zg_empresas` (`IdEmpresa`),
  ADD CONSTRAINT `FK_usuariossucursales_usuarios` FOREIGN KEY (`IdUsuario`) REFERENCES `zg_zusuarios` (`IdUsuario`);

--
-- Filtros para la tabla `zg_zmenus`
--
ALTER TABLE `zg_zmenus`
  ADD CONSTRAINT `FK_zmenus_zmodulos` FOREIGN KEY (`IdModulo`) REFERENCES `zg_zmodulos` (`IdModulo`);

--
-- Filtros para la tabla `zg_zplanes`
--
ALTER TABLE `zg_zplanes`
  ADD CONSTRAINT `FK_zplanes_zmodulos` FOREIGN KEY (`IdModulo`) REFERENCES `zg_zmodulos` (`IdModulo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
