USE BI
GO

IF OBJECT_ID('operaciones_autopartes', 'U') IS NOT NULL 
  DROP TABLE operaciones_autopartes;
IF OBJECT_ID('operaciones_automoviles', 'U') IS NOT NULL 
  DROP TABLE operaciones_automoviles;
IF OBJECT_ID('fechas_operaciones', 'U') IS NOT NULL 
  DROP TABLE fechas_operaciones;
IF OBJECT_ID('clientes', 'U') IS NOT NULL 
  DROP TABLE clientes;
IF OBJECT_ID('sucursales', 'U') IS NOT NULL 
  DROP TABLE sucursales;
IF OBJECT_ID('autopartes', 'U') IS NOT NULL 
  DROP TABLE autopartes;
IF OBJECT_ID('automoviles', 'U') IS NOT NULL 
  DROP TABLE automoviles;
IF EXISTS(SELECT name FROM sys.objects WHERE type_desc LIKE '%fun%' AND name LIKE 'f_calcular_rango_etario')
  DROP FUNCTION f_calcular_rango_etario
IF EXISTS(SELECT name FROM sys.objects WHERE type_desc LIKE '%fun%' AND name LIKE 'f_calcular_rango_potencia')
  DROP FUNCTION f_calcular_rango_potencia
IF EXISTS(SELECT name FROM sys.objects WHERE type_desc LIKE '%fun%' AND name LIKE 'f_stock_al_anio')
  DROP FUNCTION f_stock_al_anio
IF OBJECT_ID('vw_automoviles_vendidos_y_comprados', 'V') IS NOT NULL 
  DROP VIEW vw_automoviles_vendidos_y_comprados;
IF OBJECT_ID('vw_precio_promedio_de_automoviles', 'V') IS NOT NULL 
  DROP VIEW vw_precio_promedio_de_automoviles;
IF OBJECT_ID('vw_ganancias_de_automoviles_por_sucursal', 'V') IS NOT NULL 
  DROP VIEW vw_ganancias_de_automoviles_por_sucursal;
IF OBJECT_ID('vw_promedio_stock_modelo', 'V') IS NOT NULL 
  DROP VIEW vw_promedio_stock_modelo;
IF OBJECT_ID('vw_precio_promedio_por_autoparte', 'V') IS NOT NULL 
  DROP VIEW vw_precio_promedio_por_autoparte;
IF OBJECT_ID('vw_precio_promedio_global_de_autopartes', 'V') IS NOT NULL 
  DROP VIEW vw_precio_promedio_global_de_autopartes;
IF OBJECT_ID('vw_ganancias_de_autopartes_por_sucursal', 'V') IS NOT NULL 
  DROP VIEW vw_ganancias_de_autopartes_por_sucursal;
IF OBJECT_ID('vw_maximo_stock_anual_por_sucursal', 'V') IS NOT NULL 
  DROP VIEW vw_maximo_stock_anual_por_sucursal;


CREATE TABLE fechas_operaciones(
	fecha_codigo INT IDENTITY,
	fecha_numero_mes INT,
	fecha_descripcion_mes NVARCHAR(255),
	fecha_numero_anio INT,

	PRIMARY KEY(fecha_codigo)
)

CREATE TABLE clientes(
	cliente_id INT,
	cliente_sexo NVARCHAR(255), /*Quedaria en NULL porque no tenemos info del sexo en el modelo*/
	/*cod_rango_etario INT, Tiene sentido ponerle un codigo?*/
	cliente_rango_etario NVARCHAR(255), /*Lo ponemos como un string?*/

	PRIMARY KEY(cliente_id)
)

CREATE TABLE sucursales(
	sucursal_id INT,
	sucursal_direccion NVARCHAR(255),
	sucursal_ciudad NVARCHAR(255),
	sucursal_telefono DECIMAL(18,0),
	sucursal_mail NVARCHAR(255)

	PRIMARY KEY(sucursal_id)
)

CREATE TABLE autopartes(
	autoparte_codigo DECIMAL(18,0),
	autoparte_descripcion NVARCHAR(255),
	autoparte_fabricante NVARCHAR(255),
	autoparte_rubro NVARCHAR(255),

	PRIMARY KEY(autoparte_codigo)
)

CREATE TABLE automoviles(
	automovil_id INT,
	automovil_modelo NVARCHAR(255),
	automovil_fabricante NVARCHAR(255),
	automovil_tipo_auto NVARCHAR(255), /*¿Aca ponemos directamente la descripcion no? Mucho no nos dice el ID*/
	automovil_tipo_caja NVARCHAR(255),
	automovil_tipo_motor NVARCHAR(255),
	automovil_tipo_transmision NVARCHAR(255),
	automovil_potencia NVARCHAR(255), /*¿Vale la pena ponerle un codigo como esta en el DER? En realidad seria un rango mas que un decimal, ¿un string?*/

	automovil_cantidad_cambios INT, /*Este campo va a estar en NULL porque no tenemos esta info en el modelo relacional*/
		
	PRIMARY KEY(automovil_id)

)

CREATE TABLE operaciones_autopartes(
	operacion_id INT IDENTITY,
	operacion_cliente INT FOREIGN KEY REFERENCES clientes(cliente_id),
	operacion_tipo VARCHAR(255),
	operacion_autoparte DECIMAL(18,0) FOREIGN KEY REFERENCES autopartes(autoparte_codigo),
	operacion_fecha INT FOREIGN KEY REFERENCES fechas_operaciones(fecha_codigo),
	operacion_sucursal INT FOREIGN KEY REFERENCES sucursales(sucursal_id),
	operacion_monto_unitario DECIMAL(18,2),
	operacion_cantidad DECIMAL(18,2)

	PRIMARY KEY(operacion_id)
)

CREATE TABLE operaciones_automoviles(
	operacion_cliente INT FOREIGN KEY REFERENCES clientes(cliente_id),
	operacion_tipo VARCHAR(255),
	operacion_automovil INT FOREIGN KEY REFERENCES automoviles(automovil_id),
	operacion_fecha INT FOREIGN KEY REFERENCES fechas_operaciones(fecha_codigo),
	operacion_sucursal INT FOREIGN KEY REFERENCES sucursales(sucursal_id),
	operacion_monto DECIMAL(18,2),

	PRIMARY KEY(operacion_cliente,operacion_tipo,operacion_automovil,operacion_fecha,operacion_sucursal)
)
GO


							/* CLIENTES */
/*-------------------------------------------------------------------------*/
CREATE FUNCTION f_calcular_rango_etario(@fecha_nacimiento DATETIME2)
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

INSERT INTO clientes 
SELECT cliente_id, NULL, dbo.f_calcular_rango_etario(cliente_fecha_nacimiento)
FROM GD2C2020.BAD_QUERY.Clientes

/*-------------------------------------------------------------------------*/


							/* SUCURSALES */
/*-------------------------------------------------------------------------*/
INSERT INTO sucursales 
SELECT * FROM GD2C2020.BAD_QUERY.Sucursales
/*-------------------------------------------------------------------------*/


							/* AUTOPARTES */
/*-------------------------------------------------------------------------*/
INSERT INTO autopartes 
SELECT autoparte_codigo, autoparte_descripcion, modelo_fabricante, autoparte_categoria FROM GD2C2020.BAD_QUERY.Autopartes
INNER JOIN GD2C2020.BAD_QUERY.Modelos ON modelo_codigo=autoparte_modelo_auto
GO
/*-------------------------------------------------------------------------*/

							/* AUTOMOVILES */
/*-------------------------------------------------------------------------*/

CREATE FUNCTION f_calcular_rango_potencia(@potencia decimal(18,0))
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

INSERT INTO automoviles 
SELECT automovil_id, modelo_nombre, modelo_fabricante, tipo_auto_descripcion,tipo_caja_descripcion,
tipo_motor_descripcion,tipo_transmision_descripcion, dbo.f_calcular_rango_potencia(modelo_potencia), NULL
FROM GD2C2020.BAD_QUERY.Automoviles
INNER JOIN GD2C2020.BAD_QUERY.Modelos ON modelo_codigo=automovil_modelo
INNER JOIN GD2C2020.BAD_QUERY.Tipos_auto ON modelo_tipo_auto=tipo_auto_codigo
INNER JOIN GD2C2020.BAD_QUERY.Tipos_caja ON modelo_tipo_caja=tipo_caja_codigo
INNER JOIN GD2C2020.BAD_QUERY.Tipos_motor ON modelo_tipo_motor=tipo_motor_codigo
INNER JOIN GD2C2020.BAD_QUERY.Tipos_transmision ON modelo_tipo_transmision=tipo_transmision_codigo
GO
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

INSERT INTO fechas_operaciones
SELECT DISTINCT MONTH(fecha), DATENAME(MONTH, fecha),YEAR(fecha)
FROM #fechasexistentes

DROP TABLE #fechasexistentes
GO
/*-------------------------------------------------------------------------*/



							/* OPERACIONES AUTOMOVILES */
/*-------------------------------------------------------------------------*/
INSERT INTO operaciones_automoviles
SELECT compra_automovil_cliente, 'COMPRA', compra_automovil_automovil, fecha_codigo, compra_automovil_sucursal, compra_automovil_precio
FROM GD2C2020.BAD_QUERY.Compras_automoviles
INNER JOIN fechas_operaciones ON YEAR(compra_automovil_fecha)=fecha_numero_anio AND MONTH(compra_automovil_fecha)=fecha_numero_mes
UNION
SELECT factura_automovil_cliente, 'VENTA', factura_automovil_automovil, fecha_codigo, factura_automovil_sucursal, factura_automovil_precio
FROM GD2C2020.BAD_QUERY.Facturas_automoviles
INNER JOIN fechas_operaciones ON YEAR(factura_automovil_fecha)=fecha_numero_anio AND MONTH(factura_automovil_fecha)=fecha_numero_mes
/*-------------------------------------------------------------------------*/


							/* OPERACIONES AUTOPARTES */
/*-------------------------------------------------------------------------*/
INSERT INTO operaciones_autopartes
SELECT compra_autopartes_cliente, 'COMPRA', autoparte, fecha_codigo, compra_autopartes_sucursal, precio, cantidad
FROM GD2C2020.BAD_QUERY.Compras_autopartes
INNER JOIN fechas_operaciones ON YEAR(compra_autopartes_fecha)=fecha_numero_anio AND MONTH(compra_autopartes_fecha)=fecha_numero_mes
INNER JOIN GD2C2020.BAD_QUERY.Compra_X_autoparte ON compra_autopartes=compra_autopartes_numero
UNION
SELECT factura_autopartes_cliente, 'VENTA', autoparte, fecha_codigo, factura_autopartes_sucursal, precio, cantidad
FROM GD2C2020.BAD_QUERY.Facturas_autopartes
INNER JOIN fechas_operaciones ON YEAR(factura_autopartes_fecha)=fecha_numero_anio AND MONTH(factura_autopartes_fecha)=fecha_numero_mes
INNER JOIN GD2C2020.BAD_QUERY.Factura_X_autoparte ON factura_autopartes=factura_autopartes_numero
/*-------------------------------------------------------------------------*/
GO



/*VISTAS*/

/*Cantidad de automoviles vendidos y comprados por sucursal y mes*/

CREATE VIEW vw_automoviles_vendidos_y_comprados AS
SELECT sucursal_direccion AS [Dirección de la sucursal], fecha_descripcion_mes AS [Mes],
COUNT(CASE operacion_tipo WHEN 'COMPRA' THEN 1 ELSE NULL END) AS [Automoviles comprados], 
COUNT(CASE operacion_tipo WHEN 'VENTA' THEN 1 ELSE NULL END) AS [Automoviles vendidos]
FROM operaciones_automoviles
INNER JOIN sucursales ON sucursal_id=operacion_sucursal
INNER JOIN fechas_operaciones ON operacion_fecha = fecha_codigo
GROUP BY sucursal_direccion, fecha_descripcion_mes
GO


/*Precio promedio de automóviles, vendidos y comprados.*/
CREATE VIEW vw_precio_promedio_de_automoviles AS
SELECT
AVG(CASE operacion_tipo WHEN 'COMPRA' THEN operacion_monto ELSE NULL END) AS [Precio promedio de automoviles comprados],
AVG(CASE operacion_tipo WHEN 'VENTA' THEN operacion_monto ELSE NULL END) AS [Precio promedio de automoviles vendidos]
FROM operaciones_automoviles
GO


/*Ganancias (precio de venta – precio de compra) x Sucursal x mes por ventas de automoviles*/
CREATE VIEW vw_ganancias_de_automoviles_por_sucursal AS
SELECT sucursal_direccion AS [Dirección de la sucursal], fecha_descripcion_mes AS [Mes],
(SUM(CASE operacion_tipo WHEN 'VENTA' THEN operacion_monto ELSE NULL END) - SUM(CASE operacion_tipo WHEN 'COMPRA' THEN operacion_monto ELSE NULL END))
AS [Ganancias por automoviles]
FROM operaciones_automoviles
INNER JOIN sucursales ON sucursal_id=operacion_sucursal
INNER JOIN fechas_operaciones ON operacion_fecha = fecha_codigo
GROUP BY sucursal_direccion, fecha_descripcion_mes
GO


/*Promedio de tiempo en stock de cada modelo de automóvil.*/
CREATE VIEW vw_promedio_stock_modelo AS
SELECT Modelo, AVG((Fecha_anio_venta-Fecha_anio_compra)*12+(Fecha_mes_venta-Fecha_mes_compra)) AS [Promedio de meses en stock]
FROM 
	(select ope1.operacion_automovil AS Automovil, automovil_modelo AS Modelo, 
	fechacompra.fecha_numero_anio AS [Fecha_anio_compra], 
	fechacompra.fecha_numero_mes AS [Fecha_mes_compra],
	ISNULL(fechaventa.fecha_numero_anio, YEAR(GETDATE())) AS [Fecha_anio_venta],
	ISNULL(fechaventa.fecha_numero_mes,MONTH(GETDATE())) AS [Fecha_mes_venta]
	FROM operaciones_automoviles ope1
	INNER JOIN automoviles ON automovil_id=operacion_automovil
	LEFT JOIN operaciones_automoviles ope2 ON ope1.operacion_automovil = ope2.operacion_automovil AND ope2.operacion_tipo!=ope1.operacion_tipo
	INNER JOIN fechas_operaciones fechacompra ON fechacompra.fecha_codigo=ope1.operacion_fecha
	LEFT JOIN fechas_operaciones fechaventa ON fechaventa.fecha_codigo=ope2.operacion_fecha
	WHERE ope1.operacion_tipo='COMPRA'
	) fechasdecompraventa
GROUP BY Modelo
GO

/*Precio promedio de cada autoparte, vendida y comprada.*/
CREATE VIEW vw_precio_promedio_por_autoparte AS
SELECT
operacion_autoparte AS Autoparte,
AVG(CASE operacion_tipo WHEN 'COMPRA' THEN operacion_monto_unitario ELSE NULL END) AS [Precio promedio de compra],
AVG(CASE operacion_tipo WHEN 'VENTA' THEN operacion_monto_unitario ELSE NULL END) AS [Precio promedio de venta]
FROM operaciones_autopartes
GROUP BY operacion_autoparte
GO


CREATE VIEW vw_precio_promedio_global_de_autopartes AS
SELECT
AVG(CASE operacion_tipo WHEN 'COMPRA' THEN operacion_monto_unitario ELSE NULL END) AS [Precio promedio de autopartes compradas],
AVG(CASE operacion_tipo WHEN 'VENTA' THEN operacion_monto_unitario ELSE NULL END) AS [Precio promedio de autopartes vendidas]
FROM operaciones_autopartes
GO

/*Ganancias (precio de venta – precio de compra) x Sucursal x mes por ventas de autopartes*/
CREATE VIEW vw_ganancias_de_autopartes_por_sucursal AS
SELECT sucursal_direccion AS [Dirección de la sucursal], fecha_descripcion_mes AS [Mes],
(SUM(CASE operacion_tipo WHEN 'VENTA' THEN (operacion_monto_unitario*operacion_cantidad) ELSE NULL END) - SUM(CASE operacion_tipo WHEN 'COMPRA' THEN (operacion_monto_unitario*operacion_cantidad) ELSE NULL END))
AS [Ganancias por autopartes]
FROM operaciones_autopartes
INNER JOIN sucursales ON sucursal_id=operacion_sucursal
INNER JOIN fechas_operaciones ON operacion_fecha = fecha_codigo
GROUP BY sucursal_direccion, fecha_descripcion_mes
GO

/*Máxima cantidad de stock de autopartes por cada sucursal (anual)*/
CREATE FUNCTION f_stock_al_anio(@anio INT, @sucursal INT)
RETURNS INT
AS
BEGIN
	RETURN(
	SELECT 
	SUM(CASE operacion_tipo WHEN 'COMPRA' THEN operacion_cantidad ELSE 0 END)-SUM(CASE operacion_tipo WHEN 'VENTA' THEN operacion_cantidad ELSE 0 END)
	FROM operaciones_autopartes 
	INNER JOIN fechas_operaciones ON operacion_fecha = fecha_codigo
	WHERE operacion_sucursal=@sucursal 
	AND fecha_numero_anio*12 + fecha_numero_mes <= @anio*12 + 12
	)
END
GO

CREATE VIEW vw_maximo_stock_anual_por_sucursal AS
SELECT sucursal_direccion AS Sucursal, fecha_numero_anio AS Año, 
dbo.f_stock_al_anio(fecha_numero_anio,operacion_sucursal) AS Stock
FROM operaciones_autopartes
INNER JOIN fechas_operaciones ON operacion_fecha = fecha_codigo
INNER JOIN sucursales ON sucursal_id=operacion_sucursal
GROUP BY sucursal_direccion,operacion_sucursal, fecha_numero_anio


