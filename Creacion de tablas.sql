USE GD2C2020
GO

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
IF OBJECT_ID('BAD_QUERY.sp_migrar_datos', 'P') IS NOT NULL 
  DROP PROCEDURE BAD_QUERY.sp_migrar_datos
IF OBJECT_ID('BAD_QUERY.Logs', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.Logs;
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

CREATE SCHEMA BAD_QUERY
GO

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
CREATE INDEX indice_sucursales ON BAD_QUERY.Sucursales(sucursal_direccion)

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
CREATE INDEX indice_modelos ON BAD_QUERY.Modelos(modelo_tipo_auto,modelo_tipo_caja,modelo_tipo_transmision,modelo_tipo_motor)

CREATE TABLE BAD_QUERY.Automoviles (
	automovil_id int IDENTITY PRIMARY KEY,
	automovil_numero_chasis nvarchar(50),
	automovil_numero_motor nvarchar(50),
	automovil_patente nvarchar(50),
	automovil_fecha_alta datetime2(3),
	automovil_cantidad_km decimal(18,0),
	automovil_modelo decimal(18,0) FOREIGN KEY REFERENCES BAD_QUERY.Modelos(modelo_codigo)
)
CREATE INDEX indice_automoviles ON BAD_QUERY.Automoviles(automovil_patente,automovil_modelo)

CREATE TABLE BAD_QUERY.Autopartes(
	autoparte_codigo decimal(18,0) PRIMARY KEY,
	autoparte_descripcion nvarchar(255),
	autoparte_modelo_auto decimal(18,0) FOREIGN KEY REFERENCES BAD_QUERY.Modelos(modelo_codigo),
	autoparte_categoria nvarchar(255),
)
CREATE INDEX indice_autopartes ON BAD_QUERY.Autopartes(autoparte_modelo_auto)

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

CREATE FUNCTION BAD_QUERY.f_precio_venta(@precio_compra DECIMAL(18,0))
RETURNS DECIMAL(18,0)
AS
BEGIN
	RETURN (@precio_compra * 1.2)
END
GO

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

	INSERT INTO BAD_QUERY.Automoviles values (@nro_chasis, @nro_motor, @patente, @fecha_alta, @kilometraje, @modelo)
	SELECT @id_automovil = scope_identity()

	INSERT INTO BAD_QUERY.Compras_automoviles (compra_automovil_numero, compra_automovil_fecha, compra_automovil_precio, compra_automovil_sucursal,
	 compra_automovil_automovil)
	 values(@numero_compra, GETDATE(), @precio_automovil, @id_sucursal, @id_automovil)

END
GO


CREATE PROCEDURE BAD_QUERY.sp_registrar_venta_automovil
@id_automovil int,
@id_sucursal int,
@numero_factura decimal(18,0)
AS
BEGIN
    DECLARE @precio_automovil decimal(18,0) = BAD_QUERY.f_precio_venta((SELECT compra_automovil_precio FROM BAD_QUERY.Compras_automoviles WHERE compra_automovil_automovil = @id_automovil))
	
	INSERT INTO BAD_QUERY.Facturas_automoviles(factura_automovil_numero, factura_automovil_fecha, factura_automovil_precio, factura_automovil_sucursal,
	 factura_automovil_automovil)
	 values(@numero_factura, GETDATE(), @precio_automovil, @id_sucursal, @id_automovil)

END
GO

CREATE PROCEDURE BAD_QUERY.sp_registrar_compra_autoparte
@codigo_autoparte INT,
@descripcion NVARCHAR(255),
@categoria NVARCHAR(255),
@id_modelo_automovil INT,
@id_sucursal INT
AS
BEGIN
	IF NOT EXISTS(SELECT autoparte_codigo FROM BAD_QUERY.Autopartes WHERE autoparte_codigo = @codigo_autoparte)
	BEGIN
		BEGIN TRANSACTION
		BEGIN TRY
			INSERT INTO BAD_QUERY.Autopartes VALUES(@codigo_autoparte, @descripcion, @id_modelo_automovil, @categoria) 

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
@codigo_autoparte INT,
@categoria NVARCHAR(255),
@cantidad INT,
@precio DECIMAL(18,0),
@numero_factura DECIMAL(18,0),
@fecha DATETIME2(3),
@id_vendedor INT,
@id_comprador INT
AS
BEGIN
	DECLARE @numero_compra DECIMAL(18,0) = (SELECT MAX(compra_autopartes_numero) FROM BAD_QUERY.Compras_autopartes) + 1
	DECLARE @precio_venta DECIMAL(18,0) = BAD_QUERY.f_precio_venta(@precio)
	
	BEGIN TRANSACTION
	BEGIN TRY
		INSERT INTO BAD_QUERY.Compras_autopartes VALUES(@numero_compra, CONVERT(DATETIME2(3), GETDATE()), @id_sucursal, @id_vendedor)
		INSERT INTO BAD_QUERY.Compra_X_autoparte VALUES(@numero_compra, @codigo_autoparte, @cantidad, @precio)
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
-- Datos de clientes
INSERT INTO BAD_QUERY.Clientes
SELECT DISTINCT CLIENTE_NOMBRE, CLIENTE_APELLIDO, CLIENTE_DIRECCION, CLIENTE_DNI, CLIENTE_FECHA_NAC, CLIENTE_MAIL
FROM GD2C2020.gd_esquema.Maestra
WHERE CLIENTE_APELLIDO IS NOT NULL

INSERT INTO BAD_QUERY.Clientes
SELECT DISTINCT FAC_CLIENTE_NOMBRE, FAC_CLIENTE_APELLIDO, FAC_CLIENTE_DIRECCION, FAC_CLIENTE_DNI, FAC_CLIENTE_FECHA_NAC, FAC_CLIENTE_MAIL
FROM GD2C2020.gd_esquema.Maestra
WHERE FAC_CLIENTE_DNI IS NOT NULL AND FAC_CLIENTE_DNI NOT IN (SELECT cliente_dni FROM BAD_QUERY.Clientes)
--

-- Datos de sucursales
INSERT INTO BAD_QUERY.Sucursales
SELECT DISTINCT SUCURSAL_DIRECCION, SUCURSAL_CIUDAD, SUCURSAL_TELEFONO,SUCURSAL_MAIL
FROM GD2C2020.gd_esquema.Maestra
WHERE SUCURSAL_DIRECCION IS NOT NULL

-- Esto se usaria para contemplar las sucursales que figuran en una factura pero no en una compra. En la base de datos este caso no se da. 
/*INSERT INTO BAD_QUERY.Sucursales
SELECT DISTINCT FAC_SUCURSAL_DIRECCION, FAC_SUCURSAL_CIUDAD, FAC_SUCURSAL_TELEFONO,SUCURSAL_MAIL
FROM GD2C2020.gd_esquema.Maestra
WHERE FAC_SUCURSAL_DIRECCION IS NOT NULL AND FAC_SUCURSAL_DIRECCION NOT IN (SELECT sucursal_direccion FROM BAD_QUERY.Sucursales)*/
--

-- Datos de tipo auto
INSERT INTO BAD_QUERY.Tipos_auto
SELECT DISTINCT TIPO_AUTO_CODIGO, TIPO_AUTO_DESC
FROM GD2C2020.gd_esquema.Maestra
WHERE TIPO_AUTO_CODIGO IS NOT NULL
--

-- Datos de tipo caja
INSERT INTO BAD_QUERY.Tipos_caja
SELECT DISTINCT TIPO_CAJA_CODIGO, TIPO_CAJA_DESC
FROM GD2C2020.gd_esquema.Maestra
WHERE TIPO_CAJA_CODIGO IS NOT NULL
--

-- Datos de tipo transmision
INSERT INTO BAD_QUERY.Tipos_transmision
SELECT DISTINCT TIPO_TRANSMISION_CODIGO, TIPO_TRANSMISION_DESC
FROM GD2C2020.gd_esquema.Maestra
WHERE TIPO_TRANSMISION_CODIGO IS NOT NULL
--

-- Datos de tipo motor
INSERT INTO BAD_QUERY.Tipos_motor
SELECT DISTINCT TIPO_MOTOR_CODIGO, NULL
FROM GD2C2020.gd_esquema.Maestra
WHERE TIPO_TRANSMISION_CODIGO IS NOT NULL
--

-- Datos de modelo
INSERT INTO BAD_QUERY.Modelos
SELECT DISTINCT MODELO_CODIGO, MODELO_NOMBRE, MODELO_POTENCIA, FABRICANTE_NOMBRE, TIPO_AUTO_CODIGO, TIPO_CAJA_CODIGO, TIPO_TRANSMISION_CODIGO, TIPO_MOTOR_CODIGO
FROM GD2C2020.gd_esquema.Maestra
WHERE MODELO_CODIGO IS NOT NULL 
AND TIPO_AUTO_CODIGO IS NOT NULL
AND TIPO_CAJA_CODIGO IS NOT NULL
AND TIPO_TRANSMISION_CODIGO IS NOT NULL
AND TIPO_MOTOR_CODIGO IS NOT NULL 
--

-- Datos de autoparte
INSERT INTO BAD_QUERY.Autopartes
SELECT DISTINCT AUTO_PARTE_CODIGO, AUTO_PARTE_DESCRIPCION, MODELO_CODIGO, NULL 
FROM GD2C2020.gd_esquema.Maestra
WHERE AUTO_PARTE_CODIGO IS NOT NULL 
--

-- Datos de automoviles
INSERT INTO BAD_QUERY.Automoviles
SELECT DISTINCT AUTO_NRO_CHASIS, AUTO_NRO_MOTOR, AUTO_PATENTE, AUTO_FECHA_ALTA, AUTO_CANT_KMS, MODELO_CODIGO
FROM GD2C2020.gd_esquema.Maestra
WHERE AUTO_PATENTE IS NOT NULL 
--

-- Datos de compras automoviles
INSERT INTO BAD_QUERY.Compras_automoviles
SELECT DISTINCT COMPRA_NRO, COMPRA_FECHA, COMPRA_PRECIO, sucursal_id, automovil_id, cliente_id
FROM GD2C2020.gd_esquema.Maestra
INNER JOIN GD2C2020.BAD_QUERY.Sucursales ON GD2C2020.BAD_QUERY.Sucursales.sucursal_direccion = GD2C2020.gd_esquema.Maestra.SUCURSAL_DIRECCION
INNER JOIN GD2C2020.BAD_QUERY.Automoviles ON GD2C2020.BAD_QUERY.Automoviles.automovil_patente = GD2C2020.gd_esquema.Maestra.AUTO_PATENTE
INNER JOIN GD2C2020.BAD_QUERY.Clientes ON GD2C2020.BAD_QUERY.Clientes.cliente_dni = GD2C2020.gd_esquema.Maestra.CLIENTE_DNI
								  AND GD2C2020.BAD_QUERY.Clientes.cliente_direccion = GD2C2020.gd_esquema.Maestra.CLIENTE_DIRECCION
WHERE COMPRA_NRO IS NOT NULL 
--

-- Datos de facturas automoviles
INSERT INTO BAD_QUERY.Facturas_automoviles
SELECT DISTINCT FACTURA_NRO, FACTURA_FECHA, PRECIO_FACTURADO, sucursal_id, automovil_id, cliente_id
FROM GD2C2020.gd_esquema.Maestra
INNER JOIN GD2C2020.BAD_QUERY.Sucursales ON GD2C2020.BAD_QUERY.Sucursales.sucursal_direccion = GD2C2020.gd_esquema.Maestra.FAC_SUCURSAL_DIRECCION
INNER JOIN GD2C2020.BAD_QUERY.Automoviles ON GD2C2020.BAD_QUERY.Automoviles.automovil_patente = GD2C2020.gd_esquema.Maestra.AUTO_PATENTE
INNER JOIN GD2C2020.BAD_QUERY.Clientes ON GD2C2020.BAD_QUERY.Clientes.cliente_dni = GD2C2020.gd_esquema.Maestra.FAC_CLIENTE_DNI
								  AND GD2C2020.BAD_QUERY.Clientes.cliente_direccion = GD2C2020.gd_esquema.Maestra.FAC_CLIENTE_DIRECCION
WHERE FACTURA_NRO IS NOT NULL 
--

-- Datos de compras autopartes
INSERT INTO BAD_QUERY.Compras_autopartes
SELECT DISTINCT COMPRA_NRO, COMPRA_FECHA, sucursal_id, cliente_id
FROM GD2C2020.gd_esquema.Maestra
INNER JOIN GD2C2020.BAD_QUERY.Sucursales ON GD2C2020.BAD_QUERY.Sucursales.sucursal_direccion = GD2C2020.gd_esquema.Maestra.SUCURSAL_DIRECCION
INNER JOIN GD2C2020.BAD_QUERY.Clientes ON GD2C2020.BAD_QUERY.Clientes.cliente_dni = GD2C2020.gd_esquema.Maestra.CLIENTE_DNI
								  AND GD2C2020.BAD_QUERY.Clientes.cliente_direccion = GD2C2020.gd_esquema.Maestra.CLIENTE_DIRECCION
WHERE COMPRA_NRO IS NOT NULL AND AUTO_PARTE_CODIGO IS NOT NULL
--

-- Datos de facturas autopartes
INSERT INTO BAD_QUERY.Facturas_autopartes
SELECT DISTINCT FACTURA_NRO, FACTURA_FECHA, sucursal_id, cliente_id
FROM GD2C2020.gd_esquema.Maestra
INNER JOIN GD2C2020.BAD_QUERY.Sucursales ON GD2C2020.BAD_QUERY.Sucursales.sucursal_direccion = GD2C2020.gd_esquema.Maestra.FAC_SUCURSAL_DIRECCION
INNER JOIN GD2C2020.BAD_QUERY.Clientes ON GD2C2020.BAD_QUERY.Clientes.cliente_dni = GD2C2020.gd_esquema.Maestra.FAC_CLIENTE_DNI
								  AND GD2C2020.BAD_QUERY.Clientes.cliente_direccion = GD2C2020.gd_esquema.Maestra.FAC_CLIENTE_DIRECCION
WHERE FACTURA_NRO IS NOT NULL AND AUTO_PARTE_CODIGO IS NOT NULL
--

-- Datos de compras x autopartes
INSERT INTO BAD_QUERY.Compra_X_autoparte
SELECT COMPRA_NRO, AUTO_PARTE_CODIGO, COMPRA_CANT, COMPRA_PRECIO
FROM GD2C2020.gd_esquema.Maestra
WHERE COMPRA_NRO IS NOT NULL AND AUTO_PARTE_CODIGO IS NOT NULL
--

-- Datos de factura x autopartes
INSERT INTO BAD_QUERY.Factura_X_autoparte
SELECT FACTURA_NRO, AUTO_PARTE_CODIGO, CANT_FACTURADA, PRECIO_FACTURADO
FROM GD2C2020.gd_esquema.Maestra
WHERE FACTURA_NRO IS NOT NULL AND AUTO_PARTE_CODIGO IS NOT NULL
--
END
GO


CREATE TRIGGER BAD_QUERY.tr_log_nuevas_compras ON BAD_QUERY.Compras_automoviles AFTER INSERT
AS
BEGIN
	INSERT INTO BAD_QUERY.Logs values ('Se han agregado nuevas compras de automoviles', GETDATE(), CURRENT_USER)
END
GO

EXECUTE BAD_QUERY.sp_migrar_datos;
GO

--Pruebas
/*
EXECUTE BAD_QUERY.sp_registrar_compra_automovil
@id_sucursal=2,
@nro_chasis='QWERTY',
@nro_motor='92195192', 
@patente='AQWE-214', 
@kilometraje=1234, 
@modelo=15,
@numero_compra=12345678,
@fecha_alta = '2018-06-18 00:00:00.000',
@precio_automovil=250000
GO*/



