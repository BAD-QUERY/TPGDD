USE GD2C2020
GO

/*******************************/
/*     LIMPIEZA DE ENTORNO     */
/*******************************/

IF OBJECT_ID('BAD_QUERY.Compra_X_autoparte', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.Compra_X_autoparte;
IF OBJECT_ID('BAD_QUERY.Factura_X_autoparte', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.Factura_X_autoparte;
IF OBJECT_ID('BAD_QUERY.Autopartes', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.Autopartes;
IF OBJECT_ID('BAD_QUERY.Compras_automoviles', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.Compras_automoviles;
IF OBJECT_ID('BAD_QUERY.Facturas_automoviles', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.Facturas_automoviles;
IF OBJECT_ID('BAD_QUERY.Automoviles', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.Automoviles;
IF OBJECT_ID('BAD_QUERY.Compras_autopartes', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.Compras_autopartes;
IF OBJECT_ID('BAD_QUERY.Facturas_autopartes', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.Facturas_autopartes;
IF OBJECT_ID('BAD_QUERY.Compras_automoviles', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.Compras_automoviles;
IF OBJECT_ID('BAD_QUERY.Clientes', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.Clientes;
IF OBJECT_ID('BAD_QUERY.Sucursales', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.Sucursales;
IF OBJECT_ID('BAD_QUERY.Modelos', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.Modelos;
IF OBJECT_ID('BAD_QUERY.Tipos_auto', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.Tipos_auto;
IF OBJECT_ID('BAD_QUERY.Tipos_caja', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.Tipos_caja;
IF OBJECT_ID('BAD_QUERY.Tipos_transmision', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.Tipos_transmision;
IF OBJECT_ID('BAD_QUERY.Tipos_motor', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.Tipos_motor;
IF OBJECT_ID('BAD_QUERY.Logs', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.Logs;
IF OBJECT_ID('BAD_QUERY.vw_compras_automoviles', 'V') IS NOT NULL 
  DROP VIEW BAD_QUERY.vw_compras_automoviles;
IF OBJECT_ID('BAD_QUERY.vw_ventas_automoviles', 'V') IS NOT NULL 
  DROP VIEW  BAD_QUERY.vw_ventas_automoviles;
IF OBJECT_ID('BAD_QUERY.vw_automoviles_disponibles', 'V') IS NOT NULL 
  DROP VIEW BAD_QUERY.vw_automoviles_disponibles;
IF OBJECT_ID('BAD_QUERY.vw_automoviles_vendidos', 'V') IS NOT NULL 
  DROP VIEW BAD_QUERY.vw_automoviles_vendidos;
IF OBJECT_ID('BAD_QUERY.vw_compras_clientes', 'V') IS NOT NULL 
  DROP VIEW BAD_QUERY.vw_compras_clientes;
IF OBJECT_ID('BAD_QUERY.vw_compras_autopartes', 'V') IS NOT NULL 
  DROP VIEW BAD_QUERY.vw_compras_autopartes;
IF OBJECT_ID('BAD_QUERY.vw_facturas_autopartes', 'V') IS NOT NULL 
  DROP VIEW BAD_QUERY.vw_facturas_autopartes;
IF OBJECT_ID('BAD_QUERY.vw_modelos_disponibles', 'V') IS NOT NULL 
  DROP VIEW BAD_QUERY.vw_modelos_disponibles;
IF OBJECT_ID('BAD_QUERY.sp_migrar_datos', 'P') IS NOT NULL 
  DROP PROCEDURE BAD_QUERY.sp_migrar_datos
IF OBJECT_ID('BAD_QUERY.sp_registrar_compra_automovil', 'P') IS NOT NULL 
  DROP PROCEDURE BAD_QUERY.sp_registrar_compra_automovil
IF OBJECT_ID('BAD_QUERY.sp_registrar_venta_automovil', 'P') IS NOT NULL 
  DROP PROCEDURE BAD_QUERY.sp_registrar_venta_automovil
IF OBJECT_ID('BAD_QUERY.sp_registrar_compra_autoparte', 'P') IS NOT NULL
  DROP PROCEDURE BAD_QUERY.sp_registrar_compra_autoparte
IF OBJECT_ID('BAD_QUERY.sp_registrar_venta_autoparte', 'P') IS NOT NULL
  DROP PROCEDURE BAD_QUERY.sp_registrar_venta_autoparte
IF EXISTS(SELECT name FROM sys.objects WHERE type_desc LIKE '%fun%' AND name LIKE 'f_precio_venta')
	DROP FUNCTION BAD_QUERY.f_precio_venta
IF EXISTS (SELECT name FROM sys.schemas WHERE name LIKE 'BAD_QUERY')
	DROP SCHEMA BAD_QUERY
GO

-- Creacion del esquema solicitado
CREATE SCHEMA BAD_QUERY
GO

/*******************************/
/*            TABLAS           */
/*******************************/

CREATE TABLE BAD_QUERY.Clientes (
	cliente_id int IDENTITY PRIMARY KEY,
	cliente_nombre nvarchar(255),
	cliente_apellido nvarchar(255),
	cliente_direccion nvarchar(255),
	cliente_dni decimal(18,0),
	cliente_fecha_nacimiento datetime2(3),
	cliente_mail nvarchar(255)
)

CREATE TABLE BAD_QUERY.Sucursales (
	sucursal_id int IDENTITY PRIMARY KEY,
	sucursal_direccion nvarchar(255),
	sucursal_ciudad nvarchar(255),
	sucursal_telefono decimal(18,0),
	sucursal_mail nvarchar(255)
) 

CREATE TABLE BAD_QUERY.Tipos_auto (
	tipo_auto_codigo decimal(18,0) PRIMARY KEY,
	tipo_auto_descripcion nvarchar(255)
) 

CREATE TABLE BAD_QUERY.Tipos_caja (
	tipo_caja_codigo decimal(18,0) PRIMARY KEY,
	tipo_caja_descripcion nvarchar(255)
) 

CREATE TABLE BAD_QUERY.Tipos_transmision (
	tipo_transmision_codigo decimal(18,0) PRIMARY KEY,
	tipo_transmision_descripcion nvarchar(255)
) 

CREATE TABLE BAD_QUERY.Tipos_motor (
	tipo_motor_codigo decimal(18,0) PRIMARY KEY,
	tipo_motor_descripcion nvarchar(255)
) 

CREATE TABLE BAD_QUERY.Modelos (
	modelo_codigo decimal(18,0) PRIMARY KEY,
	modelo_nombre nvarchar(255),
	modelo_potencia decimal(18,0),
	modelo_fabricante nvarchar(255),
	modelo_tipo_auto decimal(18,0) FOREIGN KEY REFERENCES BAD_QUERY.Tipos_auto(tipo_auto_codigo),
	modelo_tipo_caja decimal(18,0) FOREIGN KEY REFERENCES BAD_QUERY.Tipos_caja(tipo_caja_codigo), 
	modelo_tipo_transmision decimal(18,0) FOREIGN KEY REFERENCES BAD_QUERY.Tipos_transmision(tipo_transmision_codigo),
	modelo_tipo_motor decimal(18,0) FOREIGN KEY REFERENCES BAD_QUERY.Tipos_motor(tipo_motor_codigo)
) 

CREATE TABLE BAD_QUERY.Automoviles (
	automovil_id int IDENTITY PRIMARY KEY,
	automovil_numero_chasis nvarchar(50),
	automovil_numero_motor nvarchar(50),
	automovil_patente nvarchar(50),
	automovil_fecha_alta datetime2(3),
	automovil_cantidad_km decimal(18,0),
	automovil_modelo decimal(18,0) FOREIGN KEY REFERENCES BAD_QUERY.Modelos(modelo_codigo)
)

CREATE TABLE BAD_QUERY.Autopartes(
	autoparte_codigo decimal(18,0) PRIMARY KEY,
	autoparte_descripcion nvarchar(255),
	autoparte_modelo_auto decimal(18,0) FOREIGN KEY REFERENCES BAD_QUERY.Modelos(modelo_codigo),
	autoparte_categoria nvarchar(255),
)

CREATE TABLE BAD_QUERY.Compras_autopartes(
   compra_autopartes_numero decimal(18,0) PRIMARY KEY,
   compra_autopartes_fecha datetime2(3),
   compra_autopartes_sucursal int FOREIGN KEY REFERENCES BAD_QUERY.Sucursales(sucursal_id),
   compra_autopartes_cliente int FOREIGN KEY REFERENCES BAD_QUERY.Clientes(cliente_id)
)

CREATE TABLE BAD_QUERY.Compra_X_autoparte(
	compra_autopartes decimal(18,0) NOT NULL FOREIGN KEY REFERENCES BAD_QUERY.Compras_autopartes(compra_autopartes_numero),
	autoparte decimal(18,0) NOT NULL FOREIGN KEY REFERENCES BAD_QUERY.Autopartes(autoparte_codigo),
	cantidad decimal(18,0) NOT NULL,
	precio decimal(18,2) NOT NULL
)

CREATE TABLE BAD_QUERY.Facturas_autopartes(
	factura_autopartes_numero decimal(18,0) PRIMARY KEY,
	factura_autopartes_fecha datetime2(3),
	factura_autopartes_sucursal int FOREIGN KEY REFERENCES BAD_QUERY.Sucursales(sucursal_id),
	factura_autopartes_cliente int FOREIGN KEY REFERENCES BAD_QUERY.Clientes(cliente_id),
)

CREATE TABLE BAD_QUERY.Factura_X_autoparte(
	factura_autopartes decimal(18,0) NOT NULL FOREIGN KEY REFERENCES BAD_QUERY.Facturas_autopartes(factura_autopartes_numero),
	autoparte decimal(18,0) NOT NULL FOREIGN KEY REFERENCES BAD_QUERY.Autopartes(autoparte_codigo),
	cantidad decimal(18,0) NOT NULL,
	precio decimal(18,2) NOT NULL
)

CREATE TABLE BAD_QUERY.Compras_automoviles(
	compra_automovil_numero decimal(18,0) PRIMARY KEY,
	compra_automovil_fecha datetime2(3),
	compra_automovil_precio decimal(18,2),
	compra_automovil_sucursal int FOREIGN KEY REFERENCES BAD_QUERY.Sucursales(sucursal_id),
	compra_automovil_automovil int FOREIGN KEY REFERENCES BAD_QUERY.Automoviles(automovil_id),
	compra_automovil_cliente int FOREIGN KEY REFERENCES BAD_QUERY.Clientes(cliente_id)
)

CREATE TABLE BAD_QUERY.Facturas_automoviles(
	factura_automovil_numero decimal(18,0) PRIMARY KEY,
	factura_automovil_fecha datetime2(3),
	factura_automovil_precio decimal(18,2),
	factura_automovil_sucursal int FOREIGN KEY REFERENCES BAD_QUERY.Sucursales(sucursal_id),
	factura_automovil_automovil int FOREIGN KEY REFERENCES BAD_QUERY.Automoviles(automovil_id),
	factura_automovil_cliente int FOREIGN KEY REFERENCES BAD_QUERY.Clientes(cliente_id)
)
GO

CREATE TABLE BAD_QUERY.Logs(
  evento varchar(255),
  fecha datetime,
  usuario sysname
)
GO

/*******************************/
/*            VISTAS           */
/*******************************/

CREATE VIEW BAD_QUERY.vw_compras_automoviles AS
SELECT compra_automovil_numero [Nro compra], 
compra_automovil_fecha [Fecha compra],
modelo_nombre [Modelo], 
modelo_fabricante [Fabricante],
modelo_potencia [Potencia],
automovil_cantidad_km [Kilometraje],
compra_automovil_precio [Costo],
CONCAT(cliente_nombre,' ', cliente_apellido) [Vendedor],
cliente_dni [DNI vendedor]
FROM
BAD_QUERY.Compras_automoviles Co
INNER JOIN BAD_QUERY.Automoviles A ON Co.compra_automovil_automovil = A.automovil_id
INNER JOIN BAD_QUERY.Modelos M ON A.automovil_modelo = M.modelo_codigo
INNER JOIN BAD_QUERY.Clientes Cl ON Co.compra_automovil_cliente = Cl.cliente_id
GO

CREATE VIEW BAD_QUERY.vw_ventas_automoviles AS
SELECT factura_automovil_numero [Nro factura], 
factura_automovil_fecha [Fecha venta],
modelo_nombre [Modelo], 
modelo_fabricante [Fabricante],
modelo_potencia [Potencia],
automovil_cantidad_km [Kilometraje],
factura_automovil_precio [Precio venta],
CONCAT(cliente_nombre,' ', cliente_apellido) [Comprador],
cliente_dni [DNI comprador]
FROM
BAD_QUERY.Facturas_automoviles Fa
INNER JOIN BAD_QUERY.Automoviles A ON Fa.factura_automovil_automovil = A.automovil_id
INNER JOIN BAD_QUERY.Modelos M ON A.automovil_modelo = M.modelo_codigo
INNER JOIN BAD_QUERY.Clientes Cl ON Fa.factura_automovil_cliente = Cl.cliente_id
GO

CREATE VIEW BAD_QUERY.vw_automoviles_disponibles AS
SELECT * FROM BAD_QUERY.Automoviles 
WHERE automovil_id NOT IN (SELECT factura_automovil_automovil FROM BAD_QUERY.Facturas_automoviles)
GO

CREATE VIEW BAD_QUERY.vw_automoviles_vendidos AS
SELECT sucursal_id [Sucursal], sucursal_direccion [Direccion], COUNT(factura_automovil_sucursal) [Cantidad de ventas], SUM(factura_automovil_precio) [Cantidad facturada]
FROM BAD_QUERY.Sucursales INNER JOIN BAD_QUERY.Facturas_automoviles ON sucursal_id = factura_automovil_sucursal
WHERE YEAR(factura_automovil_fecha) = YEAR(GETDATE()) AND MONTH(factura_automovil_fecha) = MONTH(GETDATE())
GROUP BY sucursal_id, sucursal_direccion
GO

CREATE VIEW BAD_QUERY.vw_compras_clientes AS
SELECT cliente_id AS [ID cliente], 
CONCAT(cliente_nombre,' ',cliente_apellido) [Nombreliente],
COUNT(compra_automovil_numero) AS [Cantidad de automoviles comprados],
SUM(compra_automovil_precio) AS [Dinero gastado]
FROM BAD_QUERY.Clientes
INNER JOIN BAD_QUERY.Compras_automoviles ON cliente_id = compra_automovil_cliente
GROUP BY cliente_id,cliente_nombre,cliente_apellido
GO

CREATE VIEW BAD_QUERY.vw_compras_autopartes AS
SELECT
compra_autopartes_numero [Nro compra], 
compra_autopartes_fecha [Fecha Compra], 
SUM (cantidad) [Cantidad comprada],
SUM (precio) [Costo total]
FROM BAD_QUERY.Compras_autopartes
INNER JOIN BAD_QUERY.Compra_X_autoparte ON compra_autopartes_numero = compra_autopartes
GROUP BY compra_autopartes_numero, compra_autopartes_fecha
GO

CREATE VIEW BAD_QUERY.vw_facturas_autopartes AS
SELECT
factura_autopartes_numero [Nro factura], 
factura_autopartes_fecha [Fecha factura], 
SUM (cantidad) [Cantidad vendida],
SUM (precio) [Precio total]
FROM BAD_QUERY.Facturas_autopartes
INNER JOIN BAD_QUERY.Factura_X_autoparte ON factura_autopartes_numero = factura_autopartes
GROUP BY factura_autopartes_numero, factura_autopartes_fecha
GO

CREATE VIEW BAD_QUERY.vw_modelos_disponibles AS
SELECT DISTINCT
modelo_fabricante [Marca],
modelo_nombre [Modelo],
tipo_auto_descripcion [Tipo],
tipo_caja_descripcion [Caja],
tipo_motor_descripcion [Motor],
tipo_transmision_descripcion [Transmision],
modelo_potencia [Potencia]
FROM BAD_QUERY.vw_automoviles_disponibles
INNER JOIN BAD_QUERY.Modelos ON automovil_modelo = modelo_codigo
INNER JOIN BAD_QUERY.Tipos_auto ON modelo_tipo_auto = tipo_auto_codigo 
INNER JOIN BAD_QUERY.Tipos_caja ON modelo_tipo_caja = tipo_caja_codigo 
INNER JOIN BAD_QUERY.Tipos_motor ON modelo_tipo_motor = tipo_motor_codigo 
INNER JOIN BAD_QUERY.Tipos_transmision ON modelo_tipo_transmision = tipo_transmision_codigo 
GO


/*******************************/
/*          FUNCIONES          */
/*******************************/

CREATE FUNCTION BAD_QUERY.f_precio_venta(@precio_compra DECIMAL(18,0))
RETURNS DECIMAL(18,0)
AS
BEGIN
	RETURN (@precio_compra * 1.2)
END
GO

/*******************************/
/*      STORED PROCEDURES      */
/*******************************/
CREATE PROCEDURE BAD_QUERY.sp_registrar_compra_automovil
@id_sucursal int, 
@nro_chasis nvarchar(50),
@nro_motor nvarchar(50), 
@patente nvarchar(50), 
@kilometraje decimal(18,0), 
@modelo decimal(18,0),
@numero_compra decimal(18,0),
@fecha_alta datetime2(3),
@precio_automovil decimal(18,0)
AS
BEGIN
    DECLARE @id_automovil int 

	BEGIN TRANSACTION
	BEGIN TRY
		INSERT INTO BAD_QUERY.Automoviles values (@nro_chasis, @nro_motor, @patente, @fecha_alta, @kilometraje, @modelo)
		SELECT @id_automovil = scope_identity()
		INSERT INTO BAD_QUERY.Compras_automoviles (compra_automovil_numero, compra_automovil_fecha, compra_automovil_precio, compra_automovil_sucursal,
		 compra_automovil_automovil)
		 VALUES(@numero_compra, GETDATE(), @precio_automovil, @id_sucursal, @id_automovil)

		 COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH

END
GO

CREATE PROCEDURE BAD_QUERY.sp_registrar_venta_automovil
@id_automovil int,
@id_sucursal int,
@numero_factura decimal(18,0)
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY

        DECLARE @precio_automovil decimal(18,0) = BAD_QUERY.f_precio_venta((SELECT compra_automovil_precio FROM BAD_QUERY.Compras_automoviles WHERE compra_automovil_automovil = @id_automovil))
	
		INSERT INTO BAD_QUERY.Facturas_automoviles(factura_automovil_numero, factura_automovil_fecha, factura_automovil_precio, factura_automovil_sucursal,
		factura_automovil_automovil)
		values(@numero_factura, GETDATE(), @precio_automovil, @id_sucursal, @id_automovil)

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH

END
GO

CREATE PROCEDURE BAD_QUERY.sp_registrar_compra_autoparte
@codigo_autoparte DECIMAL(18,0),
@descripcion NVARCHAR(255),
@categoria NVARCHAR(255),
@id_modelo_automovil DECIMAL(18,0),
@numero_compra DECIMAL(18,0),
@cantidad DECIMAL(18,0),
@precio DECIMAL(18,0),
@id_vendedor DECIMAL(18,0),
@id_sucursal INT
AS
BEGIN
	BEGIN
		BEGIN TRANSACTION
		BEGIN TRY
			IF NOT EXISTS(SELECT compra_autopartes_numero FROM BAD_QUERY.Compras_autopartes WHERE compra_autopartes_numero = @numero_compra)
			BEGIN	
				INSERT INTO BAD_QUERY.Compras_autopartes VALUES(@numero_compra, CONVERT(DATETIME2(3), GETDATE()), @id_sucursal, @id_vendedor)
			END

			INSERT INTO BAD_QUERY.Compra_X_autoparte VALUES(@numero_compra, @codigo_autoparte, @cantidad, @precio)

			IF NOT EXISTS(SELECT autoparte_codigo FROM BAD_QUERY.Autopartes WHERE autoparte_codigo = @codigo_autoparte)
			BEGIN
				INSERT INTO BAD_QUERY.Autopartes VALUES(@codigo_autoparte, @descripcion, @id_modelo_automovil, @categoria) 
			END

			COMMIT TRANSACTION
		END TRY

		BEGIN CATCH
			ROLLBACK TRANSACTION
		END CATCH
	END
END
GO

CREATE PROCEDURE BAD_QUERY.sp_registrar_venta_autoparte
@ciudad NVARCHAR(255),
@id_sucursal INT,
@codigo_autoparte DECIMAL(18,0),
@categoria NVARCHAR(255),
@cantidad DECIMAL(18,0),
@precio DECIMAL(18,0),
@numero_factura DECIMAL(18,0),
@fecha DATETIME2(3),
@id_comprador DECIMAL(18,0)
AS
BEGIN
	DECLARE @numero_compra DECIMAL(18,0) = (SELECT MAX(compra_autopartes_numero) FROM BAD_QUERY.Compras_autopartes) + 1
	DECLARE @precio_venta DECIMAL(18,0) = BAD_QUERY.f_precio_venta(@precio)
	
	BEGIN TRANSACTION
	BEGIN TRY
		INSERT INTO BAD_QUERY.Facturas_autopartes VALUES(@numero_factura, @fecha, @id_sucursal, @id_comprador)
		INSERT INTO BAD_QUERY.Factura_X_autoparte VALUES(@numero_factura, @codigo_autoparte, @cantidad, @precio_venta)

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO

CREATE PROCEDURE BAD_QUERY.sp_migrar_datos
AS
    BEGIN

        --Se deshabilitan los triggers de logs antes de la migración.
		;
        DISABLE TRIGGER ALL ON BAD_QUERY.Compras_automoviles;
        DISABLE TRIGGER ALL ON BAD_QUERY.Facturas_automoviles;
        DISABLE TRIGGER ALL ON BAD_QUERY.Compras_autopartes;
        DISABLE TRIGGER ALL ON BAD_QUERY.Facturas_autopartes;
	
        -- Datos de clientes
        INSERT INTO BAD_QUERY.Clientes
               SELECT DISTINCT 
                      CLIENTE_NOMBRE, 
                      CLIENTE_APELLIDO, 
                      CLIENTE_DIRECCION, 
                      CLIENTE_DNI, 
                      CLIENTE_FECHA_NAC, 
                      CLIENTE_MAIL
               FROM GD2C2020.gd_esquema.Maestra
               WHERE CLIENTE_APELLIDO IS NOT NULL;
        INSERT INTO BAD_QUERY.Clientes
               SELECT DISTINCT 
                      FAC_CLIENTE_NOMBRE, 
                      FAC_CLIENTE_APELLIDO, 
                      FAC_CLIENTE_DIRECCION, 
                      FAC_CLIENTE_DNI, 
                      FAC_CLIENTE_FECHA_NAC, 
                      FAC_CLIENTE_MAIL
               FROM GD2C2020.gd_esquema.Maestra
               WHERE FAC_CLIENTE_DNI IS NOT NULL
                     AND FAC_CLIENTE_DNI NOT IN
               (
                   SELECT cliente_dni
                   FROM BAD_QUERY.Clientes
               );
        --

        -- Datos de sucursales
        INSERT INTO BAD_QUERY.Sucursales
               SELECT DISTINCT 
                      SUCURSAL_DIRECCION, 
                      SUCURSAL_CIUDAD, 
                      SUCURSAL_TELEFONO, 
                      SUCURSAL_MAIL
               FROM GD2C2020.gd_esquema.Maestra
               WHERE SUCURSAL_DIRECCION IS NOT NULL;

        -- Datos de tipo auto
        INSERT INTO BAD_QUERY.Tipos_auto
               SELECT DISTINCT 
                      TIPO_AUTO_CODIGO, 
                      TIPO_AUTO_DESC
               FROM GD2C2020.gd_esquema.Maestra
               WHERE TIPO_AUTO_CODIGO IS NOT NULL;
        --

        -- Datos de tipo caja
        INSERT INTO BAD_QUERY.Tipos_caja
               SELECT DISTINCT 
                      TIPO_CAJA_CODIGO, 
                      TIPO_CAJA_DESC
               FROM GD2C2020.gd_esquema.Maestra
               WHERE TIPO_CAJA_CODIGO IS NOT NULL;
        --

        -- Datos de tipo transmision
        INSERT INTO BAD_QUERY.Tipos_transmision
               SELECT DISTINCT 
                      TIPO_TRANSMISION_CODIGO, 
                      TIPO_TRANSMISION_DESC
               FROM GD2C2020.gd_esquema.Maestra
               WHERE TIPO_TRANSMISION_CODIGO IS NOT NULL;
        --

        -- Datos de tipo motor
        INSERT INTO BAD_QUERY.Tipos_motor
               SELECT DISTINCT 
                      TIPO_MOTOR_CODIGO, 
                      NULL
               FROM GD2C2020.gd_esquema.Maestra
               WHERE TIPO_TRANSMISION_CODIGO IS NOT NULL;
        --

        -- Datos de modelo
        INSERT INTO BAD_QUERY.Modelos
               SELECT DISTINCT 
                      MODELO_CODIGO, 
                      MODELO_NOMBRE, 
                      MODELO_POTENCIA, 
                      FABRICANTE_NOMBRE, 
                      TIPO_AUTO_CODIGO, 
                      TIPO_CAJA_CODIGO, 
                      TIPO_TRANSMISION_CODIGO, 
                      TIPO_MOTOR_CODIGO
               FROM GD2C2020.gd_esquema.Maestra
               WHERE MODELO_CODIGO IS NOT NULL
                     AND TIPO_AUTO_CODIGO IS NOT NULL
                     AND TIPO_CAJA_CODIGO IS NOT NULL
                     AND TIPO_TRANSMISION_CODIGO IS NOT NULL
                     AND TIPO_MOTOR_CODIGO IS NOT NULL; 
        --

        -- Datos de autoparte
        INSERT INTO BAD_QUERY.Autopartes
               SELECT DISTINCT 
                      AUTO_PARTE_CODIGO, 
                      AUTO_PARTE_DESCRIPCION, 
                      MODELO_CODIGO, 
                      NULL
               FROM GD2C2020.gd_esquema.Maestra
               WHERE AUTO_PARTE_CODIGO IS NOT NULL; 
        --

        -- Datos de automoviles
        INSERT INTO BAD_QUERY.Automoviles
               SELECT DISTINCT 
                      AUTO_NRO_CHASIS, 
                      AUTO_NRO_MOTOR, 
                      AUTO_PATENTE, 
                      AUTO_FECHA_ALTA, 
                      AUTO_CANT_KMS, 
                      MODELO_CODIGO
               FROM GD2C2020.gd_esquema.Maestra
               WHERE AUTO_PATENTE IS NOT NULL; 
        --

        -- Datos de compras automoviles
        INSERT INTO BAD_QUERY.Compras_automoviles
               SELECT DISTINCT 
                      COMPRA_NRO, 
                      COMPRA_FECHA, 
                      COMPRA_PRECIO, 
                      sucursal_id, 
                      automovil_id, 
                      cliente_id
               FROM GD2C2020.gd_esquema.Maestra
                    INNER JOIN GD2C2020.BAD_QUERY.Sucursales ON GD2C2020.BAD_QUERY.Sucursales.sucursal_direccion = GD2C2020.gd_esquema.Maestra.SUCURSAL_DIRECCION
                    INNER JOIN GD2C2020.BAD_QUERY.Automoviles ON GD2C2020.BAD_QUERY.Automoviles.automovil_patente = GD2C2020.gd_esquema.Maestra.AUTO_PATENTE
                    INNER JOIN GD2C2020.BAD_QUERY.Clientes ON GD2C2020.BAD_QUERY.Clientes.cliente_dni = GD2C2020.gd_esquema.Maestra.CLIENTE_DNI
                                                              AND GD2C2020.BAD_QUERY.Clientes.cliente_direccion = GD2C2020.gd_esquema.Maestra.CLIENTE_DIRECCION
               WHERE COMPRA_NRO IS NOT NULL; 
        --

        -- Datos de facturas automoviles
        INSERT INTO BAD_QUERY.Facturas_automoviles
               SELECT DISTINCT 
                      FACTURA_NRO, 
                      FACTURA_FECHA, 
                      PRECIO_FACTURADO, 
                      sucursal_id, 
                      automovil_id, 
                      cliente_id
               FROM GD2C2020.gd_esquema.Maestra
                    INNER JOIN GD2C2020.BAD_QUERY.Sucursales ON GD2C2020.BAD_QUERY.Sucursales.sucursal_direccion = GD2C2020.gd_esquema.Maestra.FAC_SUCURSAL_DIRECCION
                    INNER JOIN GD2C2020.BAD_QUERY.Automoviles ON GD2C2020.BAD_QUERY.Automoviles.automovil_patente = GD2C2020.gd_esquema.Maestra.AUTO_PATENTE
                    INNER JOIN GD2C2020.BAD_QUERY.Clientes ON GD2C2020.BAD_QUERY.Clientes.cliente_dni = GD2C2020.gd_esquema.Maestra.FAC_CLIENTE_DNI
                                                              AND GD2C2020.BAD_QUERY.Clientes.cliente_direccion = GD2C2020.gd_esquema.Maestra.FAC_CLIENTE_DIRECCION
               WHERE FACTURA_NRO IS NOT NULL; 
        --

        -- Datos de compras autopartes
        INSERT INTO BAD_QUERY.Compras_autopartes
               SELECT DISTINCT 
                      COMPRA_NRO, 
                      COMPRA_FECHA, 
                      sucursal_id, 
                      cliente_id
               FROM GD2C2020.gd_esquema.Maestra
                    INNER JOIN GD2C2020.BAD_QUERY.Sucursales ON GD2C2020.BAD_QUERY.Sucursales.sucursal_direccion = GD2C2020.gd_esquema.Maestra.SUCURSAL_DIRECCION
                    INNER JOIN GD2C2020.BAD_QUERY.Clientes ON GD2C2020.BAD_QUERY.Clientes.cliente_dni = GD2C2020.gd_esquema.Maestra.CLIENTE_DNI
                                                              AND GD2C2020.BAD_QUERY.Clientes.cliente_direccion = GD2C2020.gd_esquema.Maestra.CLIENTE_DIRECCION
               WHERE COMPRA_NRO IS NOT NULL
                     AND AUTO_PARTE_CODIGO IS NOT NULL;
        --

        -- Datos de facturas autopartes
        INSERT INTO BAD_QUERY.Facturas_autopartes
               SELECT DISTINCT 
                      FACTURA_NRO, 
                      FACTURA_FECHA, 
                      sucursal_id, 
                      cliente_id
               FROM GD2C2020.gd_esquema.Maestra
                    INNER JOIN GD2C2020.BAD_QUERY.Sucursales ON GD2C2020.BAD_QUERY.Sucursales.sucursal_direccion = GD2C2020.gd_esquema.Maestra.FAC_SUCURSAL_DIRECCION
                    INNER JOIN GD2C2020.BAD_QUERY.Clientes ON GD2C2020.BAD_QUERY.Clientes.cliente_dni = GD2C2020.gd_esquema.Maestra.FAC_CLIENTE_DNI
                                                              AND GD2C2020.BAD_QUERY.Clientes.cliente_direccion = GD2C2020.gd_esquema.Maestra.FAC_CLIENTE_DIRECCION
               WHERE FACTURA_NRO IS NOT NULL
                     AND AUTO_PARTE_CODIGO IS NOT NULL;
        --

        -- Datos de compras x autopartes
        INSERT INTO BAD_QUERY.Compra_X_autoparte
               SELECT COMPRA_NRO, 
                      AUTO_PARTE_CODIGO, 
                      COMPRA_CANT, 
                      COMPRA_PRECIO
               FROM GD2C2020.gd_esquema.Maestra
               WHERE COMPRA_NRO IS NOT NULL
                     AND AUTO_PARTE_CODIGO IS NOT NULL;
        --

        -- Datos de factura x autopartes
        INSERT INTO BAD_QUERY.Factura_X_autoparte
               SELECT FACTURA_NRO, 
                      AUTO_PARTE_CODIGO, 
                      CANT_FACTURADA, 
                      PRECIO_FACTURADO
               FROM GD2C2020.gd_esquema.Maestra
               WHERE FACTURA_NRO IS NOT NULL
                     AND AUTO_PARTE_CODIGO IS NOT NULL;
        --
        --Se habilitan los triggers de logs luego de la migracion
        ENABLE TRIGGER ALL ON BAD_QUERY.Compras_automoviles;
        ENABLE TRIGGER ALL ON BAD_QUERY.Facturas_automoviles;
        ENABLE TRIGGER ALL ON BAD_QUERY.Compras_autopartes;
        ENABLE TRIGGER ALL ON BAD_QUERY.Facturas_autopartes;

    END;
GO

/*******************************/
/*           TRIGGERS          */
/*******************************/

CREATE TRIGGER BAD_QUERY.tr_log_compras_automoviles ON BAD_QUERY.Compras_automoviles AFTER INSERT
AS
BEGIN
	DECLARE @Nro_compra int

	DECLARE #micursor CURSOR FOR 
		Select compra_automovil_numero from INSERTED

	OPEN #micursor  
	FETCH NEXT FROM #micursor INTO @Nro_compra 

	WHILE @@FETCH_STATUS = 0  
	BEGIN  
		INSERT INTO BAD_QUERY.Logs values (CONCAT('Se ha agregado la compra de automovil numero: ', @Nro_compra), GETDATE(), SYSTEM_USER)

		FETCH NEXT FROM #micursor INTO @Nro_compra 
	END 
	CLOSE #micursor
	DEALLOCATE #micursor

END
GO

CREATE TRIGGER BAD_QUERY.tr_log_ventas_automoviles ON BAD_QUERY.Facturas_automoviles AFTER INSERT
AS
BEGIN
	DECLARE @Nro_factura int

	DECLARE #micursor CURSOR FOR 
		Select factura_automovil_numero from INSERTED

	OPEN #micursor  
	FETCH NEXT FROM #micursor INTO @Nro_factura 

	WHILE @@FETCH_STATUS = 0  
	BEGIN  
		INSERT INTO BAD_QUERY.Logs values (CONCAT('Se ha agregado la factura de automovil numero: ', @Nro_factura), GETDATE(), SYSTEM_USER)

		FETCH NEXT FROM #micursor INTO @Nro_factura 
	END 
	CLOSE #micursor
	DEALLOCATE #micursor
END
GO

CREATE TRIGGER BAD_QUERY.tr_log_compras_autopartes ON BAD_QUERY.Compras_autopartes AFTER INSERT
AS
BEGIN
	DECLARE @Nro_compra int

	DECLARE #micursor CURSOR FOR 
		Select compra_autopartes_numero from INSERTED

	OPEN #micursor  
	FETCH NEXT FROM #micursor INTO @Nro_compra 

	WHILE @@FETCH_STATUS = 0  
	BEGIN  
		INSERT INTO BAD_QUERY.Logs values (CONCAT('Se ha agregado la compra de autopartes numero: ', @Nro_compra), GETDATE(), SYSTEM_USER)

		FETCH NEXT FROM #micursor INTO @Nro_compra 
	END 
	CLOSE #micursor
	DEALLOCATE #micursor

END
GO

CREATE TRIGGER BAD_QUERY.tr_log_ventas_autopartes ON BAD_QUERY.Facturas_autopartes AFTER INSERT
AS
BEGIN
	DECLARE @Nro_factura int

	DECLARE #micursor CURSOR FOR 
		Select factura_autopartes_numero from INSERTED

	OPEN #micursor  
	FETCH NEXT FROM #micursor INTO @Nro_factura

	WHILE @@FETCH_STATUS = 0  
	BEGIN  
		INSERT INTO BAD_QUERY.Logs values (CONCAT('Se ha agregado la factura de autopartes numero: ', @Nro_factura), GETDATE(), SYSTEM_USER)

		FETCH NEXT FROM #micursor INTO @Nro_factura 
	END 
	CLOSE #micursor
	DEALLOCATE #micursor
END
GO


/*******************************/
/*          MIGRACIÓN          */
/*******************************/

EXECUTE BAD_QUERY.sp_migrar_datos;
GO

DROP PROCEDURE BAD_QUERY.sp_migrar_datos;
GO

/*******************************/
/*            INDICES          */
/*******************************/
CREATE INDEX indice_sucursales ON BAD_QUERY.Sucursales(sucursal_direccion)
CREATE INDEX indice_modelos ON BAD_QUERY.Modelos(modelo_tipo_auto,modelo_tipo_caja,modelo_tipo_transmision,modelo_tipo_motor)
CREATE INDEX indice_automoviles ON BAD_QUERY.Automoviles(automovil_patente,automovil_modelo)
CREATE INDEX indice_autopartes ON BAD_QUERY.Autopartes(autoparte_modelo_auto)
GO
