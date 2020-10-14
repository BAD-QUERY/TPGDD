USE GD2C2020
GO

/*IF OBJECT_ID('Migracion.dbo.Compra_X_autoparte', 'U') IS NOT NULL 
  DROP TABLE Migracion.dbo.Compra_X_autoparte;
IF OBJECT_ID('Migracion.dbo.Factura_X_autoparte', 'U') IS NOT NULL 
  DROP TABLE Migracion.dbo.Factura_X_autoparte;
IF OBJECT_ID('Migracion.dbo.Autopartes', 'U') IS NOT NULL 
  DROP TABLE Migracion.dbo.Autopartes;
IF OBJECT_ID('Migracion.dbo.Compras_automoviles', 'U') IS NOT NULL 
  DROP TABLE Migracion.dbo.Compras_automoviles;
IF OBJECT_ID('Migracion.dbo.Facturas_automoviles', 'U') IS NOT NULL 
  DROP TABLE Migracion.dbo.Facturas_automoviles;
IF OBJECT_ID('Migracion.dbo.Automoviles', 'U') IS NOT NULL 
  DROP TABLE Migracion.dbo.Automoviles;
IF OBJECT_ID('Migracion.dbo.Compras_autopartes', 'U') IS NOT NULL 
  DROP TABLE Migracion.dbo.Compras_autopartes;
IF OBJECT_ID('Migracion.dbo.Facturas_autopartes', 'U') IS NOT NULL 
  DROP TABLE Migracion.dbo.Facturas_autopartes;
IF OBJECT_ID('Migracion.dbo.Compras_automoviles', 'U') IS NOT NULL 
  DROP TABLE Migracion.dbo.Compras_automoviles;
IF OBJECT_ID('Migracion.dbo.Clientes', 'U') IS NOT NULL 
  DROP TABLE Migracion.dbo.Clientes;
IF OBJECT_ID('Migracion.dbo.Sucursales', 'U') IS NOT NULL 
  DROP TABLE Migracion.dbo.Sucursales;
IF OBJECT_ID('Migracion.dbo.Modelos', 'U') IS NOT NULL 
  DROP TABLE Migracion.dbo.Modelos;
IF OBJECT_ID('Migracion.dbo.Tipos_auto', 'U') IS NOT NULL 
  DROP TABLE Migracion.dbo.Tipos_auto;
IF OBJECT_ID('Migracion.dbo.Tipos_caja', 'U') IS NOT NULL 
  DROP TABLE Migracion.dbo.Tipos_caja;
IF OBJECT_ID('Migracion.dbo.Tipos_transmision', 'U') IS NOT NULL 
  DROP TABLE Migracion.dbo.Tipos_transmision;
IF OBJECT_ID('dbo.sp_migrar_datos', 'P') IS NOT NULL 
  DROP PROCEDURE dbo.sp_migrar_datos

GO*/



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
IF OBJECT_ID('BAD_QUERY.sp_migrar_datos', 'P') IS NOT NULL 
  DROP PROCEDURE BAD_QUERY.sp_migrar_datos
GO


-- TODO - Agregar validación de que exista
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

CREATE TABLE BAD_QUERY.Modelos (
	modelo_codigo decimal(18,0) PRIMARY KEY,
	modelo_nombre nvarchar(255),
	modelo_potencia decimal(18,0),
	modelo_tipo_motor decimal(18,0),
	modelo_fabricante nvarchar(255),
	modelo_tipo_auto decimal(18,0) FOREIGN KEY REFERENCES BAD_QUERY.Tipos_auto(tipo_auto_codigo),
	modelo_tipo_caja decimal(18,0) FOREIGN KEY REFERENCES BAD_QUERY.Tipos_caja(tipo_caja_codigo), 
	modelo_tipo_transmision decimal(18,0) FOREIGN KEY REFERENCES BAD_QUERY.Tipos_transmision(tipo_transmision_codigo)
) 
CREATE INDEX indice_modelos ON BAD_QUERY.Modelos(modelo_tipo_auto,modelo_tipo_caja,modelo_tipo_transmision)

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
	compra_autopartes decimal(18,0) FOREIGN KEY REFERENCES BAD_QUERY.Compras_autopartes(compra_autopartes_numero),
	autoparte decimal(18,0) FOREIGN KEY REFERENCES BAD_QUERY.Autopartes(autoparte_codigo),
	cantidad decimal(18,0),
	precio decimal(18,2)
	--PRIMARY KEY(compra_autopartes,autoparte)
)

CREATE TABLE BAD_QUERY.Facturas_autopartes(
	factura_autopartes_numero decimal(18,0) PRIMARY KEY,
	factura_autopartes_fecha datetime2(3),
	factura_autopartes_sucursal int FOREIGN KEY REFERENCES BAD_QUERY.Sucursales(sucursal_id),
	factura_autopartes_cliente int FOREIGN KEY REFERENCES BAD_QUERY.Clientes(cliente_id),
)

CREATE TABLE BAD_QUERY.Factura_X_autoparte(
	factura_autopartes decimal(18,0) FOREIGN KEY REFERENCES BAD_QUERY.Facturas_autopartes(factura_autopartes_numero),
	autoparte decimal(18,0) FOREIGN KEY REFERENCES BAD_QUERY.Autopartes(autoparte_codigo),
	cantidad decimal(18,0),
	precio decimal(18,2)
	--PRIMARY KEY(factura_autopartes,autoparte)
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

INSERT INTO BAD_QUERY.Sucursales
SELECT DISTINCT FAC_SUCURSAL_DIRECCION, FAC_SUCURSAL_CIUDAD, FAC_SUCURSAL_TELEFONO,SUCURSAL_MAIL
FROM GD2C2020.gd_esquema.Maestra
WHERE FAC_SUCURSAL_DIRECCION IS NOT NULL AND FAC_SUCURSAL_DIRECCION NOT IN (SELECT sucursal_direccion FROM BAD_QUERY.Sucursales)
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

-- Datos de modelo
INSERT INTO BAD_QUERY.Modelos
SELECT DISTINCT MODELO_CODIGO, MODELO_NOMBRE, MODELO_POTENCIA, TIPO_MOTOR_CODIGO, FABRICANTE_NOMBRE, TIPO_AUTO_CODIGO, TIPO_CAJA_CODIGO, TIPO_TRANSMISION_CODIGO
FROM GD2C2020.gd_esquema.Maestra
WHERE MODELO_CODIGO IS NOT NULL 
AND TIPO_MOTOR_CODIGO IS NOT NULL 
AND TIPO_AUTO_CODIGO IS NOT NULL
AND TIPO_CAJA_CODIGO IS NOT NULL
AND TIPO_TRANSMISION_CODIGO IS NOT NULL
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
--127131


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


EXECUTE BAD_QUERY.sp_migrar_datos;
