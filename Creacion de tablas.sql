IF OBJECT_ID('Migracion.dbo.Compra_X_autoparte', 'U') IS NOT NULL 
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


CREATE TABLE Clientes (
	cliente_id int IDENTITY PRIMARY KEY,
	cliente_nombre nvarchar(255),
	cliente_apellido nvarchar(255),
	cliente_direccion nvarchar(255),
	cliente_dni decimal(18,0),
	cliente_fecha_nacimiento datetime2(3),
	cliente_mail nvarchar(255)
) 

CREATE TABLE Sucursales (
	sucursal_id int IDENTITY PRIMARY KEY,
	sucursal_direccion nvarchar(255),
	sucursal_ciudad nvarchar(255),
	sucursal_telefono decimal(18,0),
) 

CREATE TABLE Tipos_auto (
	tipo_auto_codigo decimal(18,0) PRIMARY KEY,
	tipo_auto_descripcion nvarchar(255)
) 

CREATE TABLE Tipos_caja (
	tipo_caja_codigo decimal(18,0) PRIMARY KEY,
	tipo_caja_descripcion nvarchar(255)
) 

CREATE TABLE Tipos_transmision (
	tipo_transmision_codigo decimal(18,0) PRIMARY KEY,
	tipo_transmision_descripcion nvarchar(255)
) 

CREATE TABLE Modelos (
	modelo_codigo decimal(18,0) PRIMARY KEY,
	modelo_nombre nvarchar(255),
	modelo_potencia decimal(18,0),
	modelo_tipo_motor decimal(18,0),
	autoparte_fabricante nvarchar(255),
	modelo_tipo_auto decimal(18,0) FOREIGN KEY REFERENCES Tipos_auto(tipo_auto_codigo),
	modelo_tipo_caja decimal(18,0) FOREIGN KEY REFERENCES Tipos_caja(tipo_caja_codigo), 
	modelo_tipo_transmision decimal(18,0) FOREIGN KEY REFERENCES Tipos_transmision(tipo_transmision_codigo)
) 

CREATE TABLE Automoviles (
	automovil_id int IDENTITY PRIMARY KEY,
	automovil_numero_chasis nvarchar(50),
	automovil_numero_motor nvarchar(50),
	automovil_patente nvarchar(50),
	automovil_fecha_alta datetime2(3),
	automovil_cantidad_km decimal(18,0),
	automovil_modelo decimal(18,0) FOREIGN KEY REFERENCES Modelos(modelo_codigo)
)

CREATE TABLE Autopartes(
	autoparte_codigo decimal(18,0) PRIMARY KEY,
	autoparte_descripcion nvarchar(255),
	autoparte_categoria nvarchar(255),
	autoparte_modelo_auto decimal(18,0) FOREIGN KEY REFERENCES Modelos(modelo_codigo)
)

CREATE TABLE Compras_autopartes(
   compra_autopartes_numero decimal(18,0) PRIMARY KEY,
   compra_autopartes_fecha datetime2(3),
   compra_autopartes_precio decimal(18,2),
   compra_autopartes_sucursal int FOREIGN KEY REFERENCES Sucursales(sucursal_id),
   compra_autopartes_cliente int FOREIGN KEY REFERENCES Clientes(cliente_id)
)

CREATE TABLE Compra_X_autoparte(
	compra_autopartes decimal(18,0) FOREIGN KEY REFERENCES Compras_autopartes(compra_autopartes_numero),
	autoparte decimal(18,0) FOREIGN KEY REFERENCES Autopartes(autoparte_codigo),
	cantidad decimal(18,0)
	PRIMARY KEY(compra_autopartes,autoparte)
)

CREATE TABLE Facturas_autopartes(
	factura_autopartes_numero decimal(18,0) PRIMARY KEY,
	factura_autopartes_fecha datetime2(3),
	factura_autopartes_precio decimal(18,2),
	factura_autopartes_sucursal int FOREIGN KEY REFERENCES Sucursales(sucursal_id),
	factura_autopartes_cliente int FOREIGN KEY REFERENCES Clientes(cliente_id),
)

CREATE TABLE Factura_X_autoparte(
	factura_autopartes decimal(18,0) FOREIGN KEY REFERENCES Facturas_autopartes(factura_autopartes_numero),
	autoparte decimal(18,0) FOREIGN KEY REFERENCES Autopartes(autoparte_codigo),
	cantidad decimal(18,0)
	PRIMARY KEY(factura_autopartes,autoparte)
)

CREATE TABLE Compras_automoviles(
	compra_automovil_numero decimal(18,0) PRIMARY KEY,
	compra_automovil_fecha datetime2(3),
	compra_automovil_precio decimal(18,2),
	compra_automovil_sucursal int FOREIGN KEY REFERENCES Sucursales(sucursal_id),
	compra_automovil_automovil int FOREIGN KEY REFERENCES Automoviles(automovil_id),
	compra_automovil_cliente int FOREIGN KEY REFERENCES Clientes(cliente_id)
)

CREATE TABLE Facturas_automoviles(
	factura_automovil_numero decimal(18,0) PRIMARY KEY,
	factura_automovil_fecha datetime2(3),
	factura_automovil_precio decimal(18,2),
	factura_automovil_sucursal int FOREIGN KEY REFERENCES Sucursales(sucursal_id),
	factura_automovil_automovil int FOREIGN KEY REFERENCES Automoviles(automovil_id),
	factura_automovil_cliente int FOREIGN KEY REFERENCES Clientes(cliente_id)
)


INSERT INTO Clientes
SELECT CLIENTE_NOMBRE, CLIENTE_APELLIDO, CLIENTE_DIRECCION, CLIENTE_DNI, CLIENTE_FECHA_NAC,CLIENTE_MAIL
FROM GD2C2020.gd_esquema.Maestra
WHERE CLIENTE_APELLIDO IS NOT NULL
