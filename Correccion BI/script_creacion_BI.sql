USE GD2C2020
GO

/*******************************/
/*     LIMPIEZA DE ENTORNO     */
/*******************************/

IF OBJECT_ID('BAD_QUERY.BI_compras_autopartes', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.BI_compras_autopartes;
IF OBJECT_ID('BAD_QUERY.BI_ventas_autopartes', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.BI_ventas_autopartes;
IF OBJECT_ID('BAD_QUERY.BI_compras_automoviles', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.BI_compras_automoviles;
IF OBJECT_ID('BAD_QUERY.BI_ventas_automoviles', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.BI_ventas_automoviles;

IF OBJECT_ID('BAD_QUERY.BI_fechas', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.BI_fechas;
IF OBJECT_ID('BAD_QUERY.BI_clientes', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.BI_clientes;
IF OBJECT_ID('BAD_QUERY.BI_sucursales', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.BI_sucursales;
IF OBJECT_ID('BAD_QUERY.BI_autopartes', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.BI_autopartes;
IF OBJECT_ID('BAD_QUERY.BI_fabricantes', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.BI_fabricantes;
IF OBJECT_ID('BAD_QUERY.BI_modelos', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.BI_modelos;
IF OBJECT_ID('BAD_QUERY.BI_rubros_autopartes', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.BI_rubros_autopartes;
IF OBJECT_ID('BAD_QUERY.BI_tipos_automovil', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.BI_tipos_automovil;
IF OBJECT_ID('BAD_QUERY.BI_tipos_caja', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.BI_tipos_caja;
IF OBJECT_ID('BAD_QUERY.BI_tipos_motor', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.BI_tipos_motor;
IF OBJECT_ID('BAD_QUERY.BI_tipos_transmision', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.BI_tipos_transmision;
IF OBJECT_ID('BAD_QUERY.BI_potencias', 'U') IS NOT NULL 
  DROP TABLE BAD_QUERY.BI_potencias;

IF EXISTS(SELECT name FROM sys.objects WHERE type_desc LIKE '%fun%' AND name LIKE 'BI_f_calcular_rango_etario')
  DROP FUNCTION BAD_QUERY.BI_f_calcular_rango_etario
IF EXISTS(SELECT name FROM sys.objects WHERE type_desc LIKE '%fun%' AND name LIKE 'BI_f_calcular_rango_potencia')
  DROP FUNCTION BAD_QUERY.BI_f_calcular_rango_potencia
IF EXISTS(SELECT name FROM sys.objects WHERE type_desc LIKE '%fun%' AND name LIKE 'BI_f_stock_al_anio')
  DROP FUNCTION BAD_QUERY.BI_f_stock_al_anio
IF EXISTS(SELECT name FROM sys.objects WHERE type_desc LIKE '%fun%' AND name LIKE 'BI_f_stock_al_mes')
  DROP FUNCTION BAD_QUERY.BI_f_stock_al_mes


IF OBJECT_ID('BAD_QUERY.BI_vw_automoviles_vendidos_y_comprados', 'V') IS NOT NULL 
  DROP VIEW BAD_QUERY.BI_vw_automoviles_vendidos_y_comprados;
IF OBJECT_ID('BAD_QUERY.BI_vw_autopartes_vendidas_y_compradas', 'V') IS NOT NULL 
  DROP VIEW BAD_QUERY.BI_vw_autopartes_vendidas_y_compradas;
IF OBJECT_ID('BAD_QUERY.BI_vw_automoviles_vendidos_y_comprados_por_mes', 'V') IS NOT NULL 
  DROP VIEW BAD_QUERY.BI_vw_automoviles_vendidos_y_comprados_por_mes;
IF OBJECT_ID('BAD_QUERY.BI_vw_automoviles_vendidos_y_comprados_por_mes_y_anio', 'V') IS NOT NULL 
  DROP VIEW BAD_QUERY.BI_vw_automoviles_vendidos_y_comprados_por_mes_y_anio;
IF OBJECT_ID('BAD_QUERY.BI_vw_precio_promedio_de_automoviles', 'V') IS NOT NULL 
  DROP VIEW BAD_QUERY.BI_vw_precio_promedio_de_automoviles;
IF OBJECT_ID('BAD_QUERY.BI_vw_ganancias_de_automoviles_por_sucursal_por_mes', 'V') IS NOT NULL 
  DROP VIEW BAD_QUERY.BI_vw_ganancias_de_automoviles_por_sucursal_por_mes;
IF OBJECT_ID('BAD_QUERY.BI_vw_ganancias_de_automoviles_por_sucursal_por_mes_y_anio', 'V') IS NOT NULL 
  DROP VIEW BAD_QUERY.BI_vw_ganancias_de_automoviles_por_sucursal_por_mes_y_anio;
IF OBJECT_ID('BAD_QUERY.BI_vw_promedio_stock_modelo', 'V') IS NOT NULL 
  DROP VIEW BAD_QUERY.BI_vw_promedio_stock_modelo;
IF OBJECT_ID('BAD_QUERY.BI_vw_precio_promedio_por_autoparte', 'V') IS NOT NULL 
  DROP VIEW BAD_QUERY.BI_vw_precio_promedio_por_autoparte;
IF OBJECT_ID('BAD_QUERY.BI_vw_precio_promedio_global_de_autopartes', 'V') IS NOT NULL 
  DROP VIEW BAD_QUERY.BI_vw_precio_promedio_global_de_autopartes;
IF OBJECT_ID('BAD_QUERY.BI_vw_ganancias_de_autopartes_por_sucursal_por_mes', 'V') IS NOT NULL 
  DROP VIEW BAD_QUERY.BI_vw_ganancias_de_autopartes_por_sucursal_por_mes;
IF OBJECT_ID('BAD_QUERY.BI_vw_ganancias_de_autopartes_por_sucursal_por_mes_y_anio', 'V') IS NOT NULL 
  DROP VIEW BAD_QUERY.BI_vw_ganancias_de_autopartes_por_sucursal_por_mes_y_anio;
IF OBJECT_ID('BAD_QUERY.BI_vw_stock_final_anual_por_sucursal', 'V') IS NOT NULL 
  DROP VIEW BAD_QUERY.BI_vw_stock_final_anual_por_sucursal;
IF OBJECT_ID('BAD_QUERY.BI_vw_maximo_stock_anual_por_sucursal', 'V') IS NOT NULL 
  DROP VIEW BAD_QUERY.BI_vw_maximo_stock_anual_por_sucursal;




/*******************************/
/*      CREACIÓN DE TABLAS     */
/*******************************/

CREATE TABLE BAD_QUERY.BI_fechas(
	fecha_id INT IDENTITY,
	fecha_numero_mes INT,
	fecha_descripcion_mes NVARCHAR(255),
	fecha_numero_anio INT,

	PRIMARY KEY(fecha_id)
)

CREATE TABLE BAD_QUERY.BI_clientes(
	cliente_id INT,
	
	cliente_sexo NVARCHAR(255), 
	cliente_rango_etario NVARCHAR(255), 

	PRIMARY KEY(cliente_id)
)

CREATE TABLE BAD_QUERY.BI_sucursales(
	sucursal_id INT,
	sucursal_direccion NVARCHAR(255),
	sucursal_ciudad NVARCHAR(255),
	sucursal_telefono DECIMAL(18,0),
	sucursal_mail NVARCHAR(255)

	PRIMARY KEY(sucursal_id)
)

CREATE TABLE BAD_QUERY.BI_fabricantes(
	fabricante_id INT IDENTITY,
	fabricante_nombre NVARCHAR(255),

	PRIMARY KEY(fabricante_id)
)

CREATE TABLE BAD_QUERY.BI_modelos(
	modelo_codigo decimal(18,0),
	modelo_nombre NVARCHAR(255),

	PRIMARY KEY(modelo_codigo)
)


CREATE TABLE BAD_QUERY.BI_autopartes(
	autoparte_codigo DECIMAL(18,0),
	autoparte_descripcion NVARCHAR(255),

	PRIMARY KEY(autoparte_codigo)
)

CREATE TABLE BAD_QUERY.BI_rubros_autopartes(
	rubro_id INT IDENTITY,
	rubro_descripcion NVARCHAR(255),

	PRIMARY KEY(rubro_id)
)


CREATE TABLE BAD_QUERY.BI_tipos_automovil(
	tipo_automovil_codigo DECIMAL(18,0),
	tipo_automovil_descripcion NVARCHAR(255),

	PRIMARY KEY(tipo_automovil_codigo)
)

CREATE TABLE BAD_QUERY.BI_tipos_caja(
	tipo_caja_codigo DECIMAL(18,0),
	tipo_caja_descripcion NVARCHAR(255),

	PRIMARY KEY(tipo_caja_codigo)
)

CREATE TABLE BAD_QUERY.BI_tipos_motor(
	tipo_motor_codigo DECIMAL(18,0),
	tipo_motor_descripcion NVARCHAR(255),

	PRIMARY KEY(tipo_motor_codigo)
)

CREATE TABLE BAD_QUERY.BI_tipos_transmision(
	tipo_transmision_codigo DECIMAL(18,0),
	tipo_transmision_descripcion NVARCHAR(255),

	PRIMARY KEY(tipo_transmision_codigo)
)


CREATE TABLE BAD_QUERY.BI_potencias(
	potencia_id INT IDENTITY,
	potencia_descripcion NVARCHAR(255),

	PRIMARY KEY(potencia_id)
)


CREATE TABLE BAD_QUERY.BI_compras_automoviles(
	compra_automovil_cliente INT FOREIGN KEY REFERENCES BAD_QUERY.BI_clientes(cliente_id),
	compra_automovil_fecha INT FOREIGN KEY REFERENCES BAD_QUERY.BI_fechas(fecha_id),
	compra_automovil_sucursal INT FOREIGN KEY REFERENCES BAD_QUERY.BI_sucursales(sucursal_id),
	compra_automovil_modelo DECIMAL(18,0) FOREIGN KEY REFERENCES BAD_QUERY.BI_modelos(modelo_codigo),
	compra_automovil_fabricante INT FOREIGN KEY REFERENCES BAD_QUERY.BI_fabricantes(fabricante_id),
	compra_automovil_tipo_automovil DECIMAL(18,0) FOREIGN KEY REFERENCES BAD_QUERY.BI_tipos_automovil(tipo_automovil_codigo),
	compra_automovil_tipo_caja DECIMAL(18,0) FOREIGN KEY REFERENCES BAD_QUERY.BI_tipos_caja(tipo_caja_codigo),
	compra_automovil_tipo_motor DECIMAL(18,0) FOREIGN KEY REFERENCES BAD_QUERY.BI_tipos_motor(tipo_motor_codigo),
	compra_automovil_tipo_transmision DECIMAL(18,0) FOREIGN KEY REFERENCES BAD_QUERY.BI_tipos_transmision(tipo_transmision_codigo),
	compra_automovil_potencia INT FOREIGN KEY REFERENCES BAD_QUERY.BI_potencias(potencia_id),
	compra_automovil_patente NVARCHAR(50),
	compra_automovil_monto DECIMAL(18,2)

	/*Podría agregarse una PK subrogada, porque no hay garantia de que los campos no se repitan*/
)

CREATE TABLE BAD_QUERY.BI_ventas_automoviles(
	venta_automovil_cliente INT FOREIGN KEY REFERENCES BAD_QUERY.BI_clientes(cliente_id),
	venta_automovil_fecha INT FOREIGN KEY REFERENCES BAD_QUERY.BI_fechas(fecha_id),
	venta_automovil_sucursal INT FOREIGN KEY REFERENCES BAD_QUERY.BI_sucursales(sucursal_id),
	venta_automovil_modelo DECIMAL(18,0) FOREIGN KEY REFERENCES BAD_QUERY.BI_modelos(modelo_codigo),
	venta_automovil_fabricante INT FOREIGN KEY REFERENCES BAD_QUERY.BI_fabricantes(fabricante_id),
	venta_automovil_tipo_automovil DECIMAL(18,0) FOREIGN KEY REFERENCES BAD_QUERY.BI_tipos_automovil(tipo_automovil_codigo),
	venta_automovil_tipo_caja DECIMAL(18,0) FOREIGN KEY REFERENCES BAD_QUERY.BI_tipos_caja(tipo_caja_codigo),
	venta_automovil_tipo_motor DECIMAL(18,0) FOREIGN KEY REFERENCES BAD_QUERY.BI_tipos_motor(tipo_motor_codigo),
	venta_automovil_tipo_transmision DECIMAL(18,0) FOREIGN KEY REFERENCES BAD_QUERY.BI_tipos_transmision(tipo_transmision_codigo),
	venta_automovil_potencia INT FOREIGN KEY REFERENCES BAD_QUERY.BI_potencias(potencia_id),
	venta_automovil_patente NVARCHAR(50),
	venta_automovil_monto DECIMAL(18,2)

	/*Podría agregarse una PK subrogada, porque no hay garantia de que los campos no se repitan*/
)


CREATE TABLE BAD_QUERY.BI_compras_autopartes(
	compra_autoparte_cliente INT FOREIGN KEY REFERENCES BAD_QUERY.BI_clientes(cliente_id),
	compra_autoparte_fecha INT FOREIGN KEY REFERENCES BAD_QUERY.BI_fechas(fecha_id),
	compra_autoparte_sucursal INT FOREIGN KEY REFERENCES BAD_QUERY.BI_sucursales(sucursal_id),
	compra_autoparte_modelo DECIMAL(18,0) FOREIGN KEY REFERENCES BAD_QUERY.BI_modelos(modelo_codigo),
	compra_autoparte_fabricante INT FOREIGN KEY REFERENCES BAD_QUERY.BI_fabricantes(fabricante_id),
	compra_autoparte_autoparte DECIMAL(18,0) FOREIGN KEY REFERENCES BAD_QUERY.BI_autopartes(autoparte_codigo),
	compra_autoparte_rubro INT FOREIGN KEY REFERENCES BAD_QUERY.BI_rubros_autopartes(rubro_id),
	compra_autoparte_monto_unitario DECIMAL(18,2),
	compra_autoparte_cantidad DECIMAL(18,2)

	/*Podría agregarse una PK subrogada, porque no hay garantia de que los campos no se repitan*/
)

CREATE TABLE BAD_QUERY.BI_ventas_autopartes(
	venta_autoparte_cliente INT FOREIGN KEY REFERENCES BAD_QUERY.BI_clientes(cliente_id),
	venta_autoparte_fecha INT FOREIGN KEY REFERENCES BAD_QUERY.BI_fechas(fecha_id),
	venta_autoparte_sucursal INT FOREIGN KEY REFERENCES BAD_QUERY.BI_sucursales(sucursal_id),
	venta_autoparte_modelo DECIMAL(18,0) FOREIGN KEY REFERENCES BAD_QUERY.BI_modelos(modelo_codigo),
	venta_autoparte_fabricante INT FOREIGN KEY REFERENCES BAD_QUERY.BI_fabricantes(fabricante_id),
	venta_autoparte_autoparte DECIMAL(18,0) FOREIGN KEY REFERENCES BAD_QUERY.BI_autopartes(autoparte_codigo),
	venta_autoparte_rubro INT FOREIGN KEY REFERENCES BAD_QUERY.BI_rubros_autopartes(rubro_id),
	venta_autoparte_monto_unitario DECIMAL(18,2),
	venta_autoparte_cantidad DECIMAL(18,2)

	/*Podría agregarse una PK subrogada, porque no hay garantia de que los campos no se repitan*/
)
GO



/*******************************/
/*        CARGA DE DATOS       */
/*******************************/

/* CLIENTES */
/*-------------------------------------------------------------------------*/
CREATE FUNCTION BAD_QUERY.BI_f_calcular_rango_etario(@fecha_nacimiento DATETIME2)
RETURNS NVARCHAR(255)
AS
BEGIN
	IF(DATEDIFF(YEAR, @fecha_nacimiento, GETDATE()) BETWEEN 18 AND 30)
	BEGIN
		RETURN '18-30'
	END 
	IF(DATEDIFF(YEAR, @fecha_nacimiento, GETDATE()) BETWEEN 31 AND 50)
	BEGIN
		RETURN '31-50'
	END
	IF(DATEDIFF(YEAR, @fecha_nacimiento, GETDATE()) > 50)
	BEGIN
		RETURN '>50'
	END

	RETURN NULL
END
GO

INSERT INTO BAD_QUERY.BI_clientes 
SELECT cliente_id, NULL, BAD_QUERY.BI_f_calcular_rango_etario(cliente_fecha_nacimiento)
FROM GD2C2020.BAD_QUERY.Clientes

/*-------------------------------------------------------------------------*/

/* FECHAS OPERACIONES */
/*-------------------------------------------------------------------------*/
/*INSERT INTO fechas*/

CREATE TABLE #fechasexistentes(
	fecha DATETIME2(3)
)
INSERT INTO #fechasexistentes
SELECT compra_automovil_fecha FROM GD2C2020.BAD_QUERY.Compras_automoviles
UNION 
SELECT compra_autopartes_fecha FROM GD2C2020.BAD_QUERY.Compras_autopartes
UNION 
SELECT factura_automovil_fecha FROM GD2C2020.BAD_QUERY.Facturas_automoviles
UNION
SELECT factura_autopartes_fecha FROM GD2C2020.BAD_QUERY.Facturas_autopartes


SET LANGUAGE 'Spanish';

INSERT INTO BAD_QUERY.BI_fechas
SELECT DISTINCT MONTH(fecha), DATENAME(MONTH, fecha),YEAR(fecha)
FROM #fechasexistentes

DROP TABLE #fechasexistentes
GO
/*-------------------------------------------------------------------------*/

/* SUCURSALES */
/*-------------------------------------------------------------------------*/
INSERT INTO BAD_QUERY.BI_sucursales 
SELECT * FROM GD2C2020.BAD_QUERY.Sucursales
/*-------------------------------------------------------------------------*/

/* AUTOPARTES */
/*-------------------------------------------------------------------------*/
INSERT INTO BAD_QUERY.BI_autopartes 
SELECT autoparte_codigo, autoparte_descripcion FROM GD2C2020.BAD_QUERY.Autopartes
/*-------------------------------------------------------------------------*/

/* FABRICANTES */
/*-------------------------------------------------------------------------*/
INSERT INTO BAD_QUERY.BI_fabricantes
SELECT DISTINCT modelo_fabricante FROM GD2C2020.BAD_QUERY.Modelos
/*-------------------------------------------------------------------------*/

/* MODELOS */
/*-------------------------------------------------------------------------*/
INSERT INTO BAD_QUERY.BI_modelos
SELECT modelo_codigo, modelo_nombre FROM GD2C2020.BAD_QUERY.Modelos
/*-------------------------------------------------------------------------*/

/* TIPOS DE AUTOMOVIL */
/*-------------------------------------------------------------------------*/
INSERT INTO BAD_QUERY.BI_tipos_automovil
SELECT tipo_auto_codigo, tipo_auto_descripcion FROM GD2C2020.BAD_QUERY.Tipos_auto
/*-------------------------------------------------------------------------*/

/* TIPOS DE CAJA */
/*-------------------------------------------------------------------------*/
INSERT INTO BAD_QUERY.BI_tipos_caja
SELECT tipo_caja_codigo, tipo_caja_descripcion FROM GD2C2020.BAD_QUERY.Tipos_caja
/*-------------------------------------------------------------------------*/

/* TIPOS DE MOTOR */
/*-------------------------------------------------------------------------*/
INSERT INTO BAD_QUERY.BI_tipos_motor
SELECT tipo_motor_codigo, tipo_motor_descripcion FROM GD2C2020.BAD_QUERY.Tipos_motor
/*-------------------------------------------------------------------------*/

/* TIPOS DE TRANSMISION */
/*-------------------------------------------------------------------------*/
INSERT INTO BAD_QUERY.BI_tipos_transmision
SELECT tipo_transmision_codigo, tipo_transmision_descripcion FROM GD2C2020.BAD_QUERY.Tipos_transmision
GO
/*-------------------------------------------------------------------------*/

/* POTENCIAS */
/*-------------------------------------------------------------------------*/
CREATE FUNCTION BAD_QUERY.BI_f_calcular_rango_potencia(@potencia decimal(18,0))
RETURNS NVARCHAR(255)
AS
BEGIN
	IF(@potencia BETWEEN 50 AND 150)
	BEGIN
		RETURN '50-150cv'
	END 
	IF(@potencia BETWEEN 151 AND 300)
	BEGIN
		RETURN '151-300cv'
	END
	IF(@potencia > 300)
	BEGIN
		RETURN '>300cv'
	END

	RETURN NULL
END
GO

INSERT INTO BAD_QUERY.BI_potencias
SELECT DISTINCT BAD_QUERY.BI_f_calcular_rango_potencia(modelo_potencia) FROM GD2C2020.BAD_QUERY.Modelos
/*-------------------------------------------------------------------------*/

/* RUBROS */
/*-------------------------------------------------------------------------*/
INSERT INTO BAD_QUERY.BI_rubros_autopartes
SELECT DISTINCT autoparte_categoria FROM GD2C2020.BAD_QUERY.Autopartes
/*-------------------------------------------------------------------------*/


/* COMPRAS AUTOMOVILES */
/*-------------------------------------------------------------------------*/
INSERT INTO BAD_QUERY.BI_compras_automoviles
SELECT compra_automovil_cliente, fecha_id, compra_automovil_sucursal, 
modelo_codigo, fabricante_id, modelo_tipo_auto, modelo_tipo_caja, modelo_tipo_motor, modelo_tipo_transmision, 
potencia_id, automovil_patente, compra_automovil_precio
FROM BAD_QUERY.Compras_automoviles
INNER JOIN BAD_QUERY.Automoviles ON compra_automovil_automovil=automovil_id
INNER JOIN BAD_QUERY.Modelos ON automovil_modelo = modelo_codigo
INNER JOIN BAD_QUERY.BI_fechas ON YEAR(compra_automovil_fecha)=fecha_numero_anio AND MONTH(compra_automovil_fecha)=fecha_numero_mes
INNER JOIN BAD_QUERY.BI_potencias ON potencia_descripcion=BAD_QUERY.BI_f_calcular_rango_potencia(modelo_potencia)
INNER JOIN BAD_QUERY.BI_fabricantes ON fabricante_nombre = modelo_fabricante

/*-------------------------------------------------------------------------*/

/* VENTAS AUTOMOVILES */
/*-------------------------------------------------------------------------*/
INSERT INTO BAD_QUERY.BI_ventas_automoviles
SELECT factura_automovil_cliente, fecha_id, factura_automovil_sucursal, 
modelo_codigo, fabricante_id, modelo_tipo_auto, modelo_tipo_caja, modelo_tipo_motor, modelo_tipo_transmision, 
potencia_id, automovil_patente, factura_automovil_precio
FROM BAD_QUERY.Facturas_automoviles
INNER JOIN BAD_QUERY.Automoviles ON factura_automovil_automovil=automovil_id
INNER JOIN BAD_QUERY.Modelos ON automovil_modelo = modelo_codigo
INNER JOIN BAD_QUERY.BI_fechas ON YEAR(factura_automovil_fecha)=fecha_numero_anio AND MONTH(factura_automovil_fecha)=fecha_numero_mes
INNER JOIN BAD_QUERY.BI_potencias ON potencia_descripcion=BAD_QUERY.BI_f_calcular_rango_potencia(modelo_potencia)
INNER JOIN BAD_QUERY.BI_fabricantes ON fabricante_nombre = modelo_fabricante
/*-------------------------------------------------------------------------*/

/* COMPRAS AUTOPARTES */
/*-------------------------------------------------------------------------*/
INSERT INTO BAD_QUERY.BI_compras_autopartes
SELECT compra_autopartes_cliente, fecha_id, compra_autopartes_sucursal, 
modelo_codigo, fabricante_id, autoparte_codigo, NULL, precio, cantidad
FROM BAD_QUERY.Compras_autopartes
INNER JOIN BAD_QUERY.Compra_X_autoparte ON compra_autopartes=compra_autopartes_numero
INNER JOIN BAD_QUERY.Autopartes ON autoparte=autoparte_codigo
INNER JOIN BAD_QUERY.Modelos ON autoparte_modelo_auto = modelo_codigo
INNER JOIN BAD_QUERY.BI_fechas ON YEAR(compra_autopartes_fecha)=fecha_numero_anio AND MONTH(compra_autopartes_fecha)=fecha_numero_mes
INNER JOIN BAD_QUERY.BI_fabricantes ON fabricante_nombre = modelo_fabricante
/*-------------------------------------------------------------------------*/

/* VENTAS AUTOPARTES */
/*-------------------------------------------------------------------------*/
INSERT INTO BAD_QUERY.BI_ventas_autopartes
SELECT factura_autopartes_cliente, fecha_id, factura_autopartes_sucursal, 
modelo_codigo, fabricante_id, autoparte_codigo, NULL, precio, cantidad
FROM BAD_QUERY.facturas_autopartes
INNER JOIN BAD_QUERY.factura_X_autoparte ON factura_autopartes=factura_autopartes_numero
INNER JOIN BAD_QUERY.Autopartes ON autoparte=autoparte_codigo
INNER JOIN BAD_QUERY.Modelos ON autoparte_modelo_auto = modelo_codigo
INNER JOIN BAD_QUERY.BI_fechas ON YEAR(factura_autopartes_fecha)=fecha_numero_anio AND MONTH(factura_autopartes_fecha)=fecha_numero_mes
INNER JOIN BAD_QUERY.BI_fabricantes ON fabricante_nombre = modelo_fabricante
GO
/*-------------------------------------------------------------------------*/






/*******************************/
/*            VISTAS           */
/*******************************/


/*Listado de las operaciones relacionadas a automoviles*/
/*-------------------------------------------------------------------------*/
CREATE VIEW BAD_QUERY.BI_vw_automoviles_vendidos_y_comprados AS
SELECT 
compra_automovil_cliente as operacion_cliente,
compra_automovil_fecha as operacion_fecha,
compra_automovil_sucursal as operacion_sucursal,
compra_automovil_modelo as operacion_modelo,
compra_automovil_fabricante as operacion_fabricante,
compra_automovil_tipo_automovil as operacion_tipo_automovil,
compra_automovil_tipo_caja as operacion_tipo_caja,
compra_automovil_tipo_motor as operacion_tipo_motor,
compra_automovil_tipo_transmision as operacion_tipo_transmision,
compra_automovil_potencia as operacion_potencia,
compra_automovil_patente as operacion_patente,
compra_automovil_monto as operacion_monto,
'Compra' AS operacion_tipo
FROM BAD_QUERY.BI_compras_automoviles 
UNION
SELECT *, 'Venta' AS operacion_tipo
FROM BAD_QUERY.BI_ventas_automoviles
GO
/*-------------------------------------------------------------------------*/


/*Listado de las operaciones relacionadas a autopartes*/
/*-------------------------------------------------------------------------*/
CREATE VIEW BAD_QUERY.BI_vw_autopartes_vendidas_y_compradas AS
SELECT 
compra_autoparte_cliente as operacion_cliente,
compra_autoparte_fecha as operacion_fecha,
compra_autoparte_sucursal as operacion_sucursal,
compra_autoparte_modelo as operacion_modelo,
compra_autoparte_fabricante as operacion_fabricante,
compra_autoparte_autoparte as operacion_autoparte,
compra_autoparte_rubro as operacion_rubro,
compra_autoparte_monto_unitario as operacion_monto_unitario,
compra_autoparte_cantidad as operacion_cantidad,
'Compra' AS operacion_tipo
FROM BAD_QUERY.BI_compras_autopartes
UNION
SELECT *, 'Venta' AS operacion_tipo
FROM BAD_QUERY.BI_ventas_autopartes
GO
/*-------------------------------------------------------------------------*/



/*Cantidad de automoviles vendidos y comprados por sucursal y mes*/
/*-------------------------------------------------------------------------*/

CREATE VIEW BAD_QUERY.BI_vw_automoviles_vendidos_y_comprados_por_mes AS
SELECT sucursal_id AS [Sucursal], sucursal_direccion AS [Dirección de la sucursal], fecha_descripcion_mes AS [Mes], 
COUNT(CASE operacion_tipo WHEN 'Compra' THEN 1 ELSE NULL END) AS [Cantidad de compras],
COUNT(CASE operacion_tipo WHEN 'Venta' THEN 1 ELSE NULL END) AS [Cantidad de ventas]
FROM BAD_QUERY.BI_vw_automoviles_vendidos_y_comprados
INNER JOIN BAD_QUERY.BI_sucursales ON sucursal_id=operacion_sucursal
INNER JOIN BAD_QUERY.BI_fechas ON fecha_id=operacion_fecha 
GROUP BY sucursal_id, sucursal_direccion, fecha_numero_mes, fecha_descripcion_mes
GO

CREATE VIEW BAD_QUERY.BI_vw_automoviles_vendidos_y_comprados_por_mes_y_anio AS
SELECT sucursal_id AS [Sucursal], sucursal_direccion AS [Dirección de la sucursal],fecha_descripcion_mes AS [Mes], fecha_numero_anio AS [Año],
COUNT(CASE operacion_tipo WHEN 'Compra' THEN 1 ELSE NULL END) AS [Cantidad de compras],
COUNT(CASE operacion_tipo WHEN 'Venta' THEN 1 ELSE NULL END) AS [Cantidad de ventas]
FROM BAD_QUERY.BI_vw_automoviles_vendidos_y_comprados
INNER JOIN BAD_QUERY.BI_sucursales ON sucursal_id=operacion_sucursal
INNER JOIN BAD_QUERY.BI_fechas ON fecha_id=operacion_fecha 
GROUP BY sucursal_id, sucursal_direccion, fecha_numero_mes,fecha_descripcion_mes, fecha_numero_anio
GO
/*-------------------------------------------------------------------------*/

/*Precio promedio de automóviles, vendidos y comprados.*/
/*-------------------------------------------------------------------------*/
CREATE VIEW BAD_QUERY.BI_vw_precio_promedio_de_automoviles AS
SELECT 
AVG(CASE operacion_tipo WHEN 'Compra' THEN operacion_monto ELSE NULL END) AS [Precio promedio de automoviles comprados],
AVG(CASE operacion_tipo WHEN 'Venta' THEN operacion_monto ELSE NULL END) AS [Precio promedio de automoviles vendidos]
FROM BAD_QUERY.BI_vw_automoviles_vendidos_y_comprados
GO
/*-------------------------------------------------------------------------*/


/*Ganancias (precio de venta – precio de compra) x Sucursal x mes por ventas de automoviles*/
/*-------------------------------------------------------------------------*/
CREATE VIEW BAD_QUERY.BI_vw_ganancias_de_automoviles_por_sucursal_por_mes AS
SELECT sucursal_id AS [Sucursal], sucursal_direccion AS [Dirección de la sucursal], fecha_descripcion_mes AS [Mes],
(SUM(CASE operacion_tipo WHEN 'Venta' THEN operacion_monto ELSE 0 END) - SUM(CASE operacion_tipo WHEN 'Compra' THEN operacion_monto ELSE 0 END))
AS [Ganancias por automoviles]
FROM BAD_QUERY.BI_vw_automoviles_vendidos_y_comprados
INNER JOIN BAD_QUERY.BI_sucursales ON sucursal_id=operacion_sucursal
INNER JOIN BAD_QUERY.BI_fechas ON operacion_fecha = fecha_id
GROUP BY sucursal_id, sucursal_direccion,  fecha_numero_mes, fecha_descripcion_mes
GO

CREATE VIEW BAD_QUERY.BI_vw_ganancias_de_automoviles_por_sucursal_por_mes_y_anio AS
SELECT sucursal_id AS [Sucursal], sucursal_direccion AS [Dirección de la sucursal], fecha_descripcion_mes AS [Mes], fecha_numero_anio as [Año],
(SUM(CASE operacion_tipo WHEN 'Venta' THEN operacion_monto ELSE 0 END) - SUM(CASE operacion_tipo WHEN 'Compra' THEN operacion_monto ELSE 0 END))
AS [Ganancias por automoviles]
FROM BAD_QUERY.BI_vw_automoviles_vendidos_y_comprados
INNER JOIN BAD_QUERY.BI_sucursales ON sucursal_id=operacion_sucursal
INNER JOIN BAD_QUERY.BI_fechas ON operacion_fecha = fecha_id
GROUP BY sucursal_id, sucursal_direccion,  fecha_numero_mes, fecha_descripcion_mes, fecha_numero_anio
GO
/*-------------------------------------------------------------------------*/


/*Promedio de tiempo en stock de cada modelo de automóvil.*/
/*-------------------------------------------------------------------------*/
CREATE VIEW BAD_QUERY.BI_vw_promedio_stock_modelo AS
SELECT Modelo, AVG((Fecha_anio_venta-Fecha_anio_compra)*12+(Fecha_mes_venta-Fecha_mes_compra)) AS [Promedio de meses en stock]
FROM 
	(SELECT operaciones1.operacion_patente AS Patente, operaciones1.operacion_modelo AS Modelo, 
	fechacompra.fecha_numero_anio AS [Fecha_anio_compra], 
	fechacompra.fecha_numero_mes AS [Fecha_mes_compra],
	ISNULL(fechaventa.fecha_numero_anio, YEAR(GETDATE())) AS [Fecha_anio_venta],
	ISNULL(fechaventa.fecha_numero_mes,MONTH(GETDATE())) AS [Fecha_mes_venta]
	FROM BAD_QUERY.BI_vw_automoviles_vendidos_y_comprados operaciones1
	LEFT JOIN BAD_QUERY.BI_vw_automoviles_vendidos_y_comprados operaciones2 
	ON operaciones1.operacion_patente = operaciones2.operacion_patente AND operaciones2.operacion_tipo!=operaciones1.operacion_tipo
	INNER JOIN BAD_QUERY.BI_fechas fechacompra ON fechacompra.fecha_id=operaciones1.operacion_fecha
	LEFT JOIN BAD_QUERY.BI_fechas fechaventa ON fechaventa.fecha_id=operaciones2.operacion_fecha
	WHERE operaciones1.operacion_tipo='Compra'
	) fechasdecompraventa
GROUP BY Modelo
GO
/*-------------------------------------------------------------------------*/


/*Precio promedio de cada autoparte, vendida y comprada.*/
/*-------------------------------------------------------------------------*/
CREATE VIEW BAD_QUERY.BI_vw_precio_promedio_por_autoparte AS
SELECT
operacion_autoparte AS Autoparte,
AVG(CASE operacion_tipo WHEN 'Compra' THEN operacion_monto_unitario ELSE NULL END) AS [Precio promedio de compra],
AVG(CASE operacion_tipo WHEN 'Venta' THEN operacion_monto_unitario ELSE NULL END) AS [Precio promedio de venta]
FROM BAD_QUERY.BI_vw_autopartes_vendidas_y_compradas
GROUP BY operacion_autoparte
GO


CREATE VIEW BAD_QUERY.BI_vw_precio_promedio_global_de_autopartes AS
SELECT
AVG(CASE operacion_tipo WHEN 'COMPRA' THEN operacion_monto_unitario ELSE NULL END) AS [Precio promedio de autopartes compradas],
AVG(CASE operacion_tipo WHEN 'VENTA' THEN operacion_monto_unitario ELSE NULL END) AS [Precio promedio de autopartes vendidas]
FROM BAD_QUERY.BI_vw_autopartes_vendidas_y_compradas
GO
/*-------------------------------------------------------------------------*/


/*Ganancias (precio de venta – precio de compra) x Sucursal x mes por ventas de autopartes*/
/*-------------------------------------------------------------------------*/
CREATE VIEW BAD_QUERY.BI_vw_ganancias_de_autopartes_por_sucursal_por_mes AS
SELECT sucursal_direccion AS [Dirección de la sucursal], fecha_descripcion_mes AS [Mes],
(SUM(CASE operacion_tipo WHEN 'Venta' THEN (operacion_monto_unitario*operacion_cantidad) ELSE 0 END) - SUM(CASE operacion_tipo WHEN 'Compra' THEN (operacion_monto_unitario*operacion_cantidad) ELSE 0 END))
AS [Ganancias por autopartes]
FROM BAD_QUERY.BI_vw_autopartes_vendidas_y_compradas
INNER JOIN BAD_QUERY.BI_sucursales ON sucursal_id=operacion_sucursal
INNER JOIN BAD_QUERY.BI_fechas ON operacion_fecha = fecha_id
GROUP BY sucursal_direccion, fecha_descripcion_mes
GO

CREATE VIEW BAD_QUERY.BI_vw_ganancias_de_autopartes_por_sucursal_por_mes_y_anio AS
SELECT sucursal_direccion AS [Dirección de la sucursal], fecha_descripcion_mes AS [Mes], fecha_numero_anio AS [Año],
(SUM(CASE operacion_tipo WHEN 'VENTA' THEN (operacion_monto_unitario*operacion_cantidad) ELSE 0 END) - SUM(CASE operacion_tipo WHEN 'COMPRA' THEN (operacion_monto_unitario*operacion_cantidad) ELSE 0 END))
AS [Ganancias por autopartes]
FROM BAD_QUERY.BI_vw_autopartes_vendidas_y_compradas
INNER JOIN BAD_QUERY.BI_sucursales ON sucursal_id=operacion_sucursal
INNER JOIN BAD_QUERY.BI_fechas ON operacion_fecha = fecha_id
GROUP BY sucursal_direccion, fecha_descripcion_mes, fecha_numero_anio
GO
/*-------------------------------------------------------------------------*/


/*Máxima cantidad de stock de autopartes por cada sucursal (anual)*/
/*-------------------------------------------------------------------------*/
CREATE FUNCTION BAD_QUERY.BI_f_stock_al_anio(@anio INT, @sucursal INT)
RETURNS INT
AS
BEGIN
	RETURN(
		SELECT 
		SUM(CASE operacion_tipo WHEN 'Compra' THEN operacion_cantidad ELSE 0 END)-SUM(CASE operacion_tipo WHEN 'Venta' THEN operacion_cantidad ELSE 0 END)
		FROM BAD_QUERY.BI_vw_autopartes_vendidas_y_compradas
		INNER JOIN BAD_QUERY.BI_fechas ON operacion_fecha = fecha_id
		WHERE operacion_sucursal=@sucursal 
		AND fecha_numero_anio*12 + fecha_numero_mes <= @anio*12 + 12
	)
END
GO

CREATE VIEW BAD_QUERY.BI_vw_stock_final_anual_por_sucursal AS
SELECT sucursal_direccion AS Sucursal, fecha_numero_anio AS Año, 
BAD_QUERY.BI_f_stock_al_anio(fecha_numero_anio,operacion_sucursal) AS Stock
FROM BAD_QUERY.BI_vw_autopartes_vendidas_y_compradas
INNER JOIN BAD_QUERY.BI_fechas ON operacion_fecha = fecha_id
INNER JOIN BAD_QUERY.BI_sucursales ON sucursal_id=operacion_sucursal
GROUP BY sucursal_direccion,operacion_sucursal, fecha_numero_anio
GO


CREATE FUNCTION BAD_QUERY.BI_f_stock_al_mes(@anio INT, @mes INT, @sucursal INT)
RETURNS INT
AS
BEGIN
	RETURN(
		SELECT 
		SUM(CASE operacion_tipo WHEN 'COMPRA' THEN operacion_cantidad ELSE 0 END)-SUM(CASE operacion_tipo WHEN 'VENTA' THEN operacion_cantidad ELSE 0 END)
		FROM BAD_QUERY.BI_vw_autopartes_vendidas_y_compradas
		INNER JOIN BAD_QUERY.BI_fechas ON operacion_fecha = fecha_id
		WHERE operacion_sucursal=@sucursal 
		AND fecha_numero_anio*12 + fecha_numero_mes <= @anio*12 + @mes
	)
END
GO


CREATE VIEW BAD_QUERY.BI_vw_maximo_stock_anual_por_sucursal AS
SELECT DISTINCT sucursal_direccion AS Sucursal, fecha_numero_anio AS Año,
MAX(BAD_QUERY.BI_f_stock_al_mes(fecha_numero_anio, fecha_numero_mes, operacion_sucursal)) OVER(PARTITION BY sucursal_direccion, fecha_numero_anio) AS Stock
FROM BAD_QUERY.BI_vw_autopartes_vendidas_y_compradas
INNER JOIN BAD_QUERY.BI_fechas ON operacion_fecha = fecha_id
INNER JOIN BAD_QUERY.BI_sucursales ON sucursal_id=operacion_sucursal
GROUP BY sucursal_direccion,operacion_sucursal, fecha_numero_anio, fecha_numero_mes
/*-------------------------------------------------------------------------*/
