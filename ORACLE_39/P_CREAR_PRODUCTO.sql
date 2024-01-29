CREATE OR REPLACE PROCEDURE P_CREAR_PRODUCTO (
	p_descripcionCorta VARCHAR2,
	p_descriptionLarga VARCHAR2,
	p_inventario NUMBER,
	p_precioCompra NUMBER,
	p_precioVenta NUMBER,
	p_tasaImpuesto NUMBER,
	p_descuento NUMBER,
	p_id_producto OUT NUMBER,
	p_error_number OUT NUMBER
) AS

	exception_datos_incorrectos EXCEPTION;

BEGIN
	p_error_number := 0;
	p_id_producto := 0;

	IF (p_inventario < 0) OR (p_precioCompra <= 0) OR (p_precioVenta <= 0) OR (p_tasaImpuesto < 0) OR (p_descuento < 0) THEN
		RAISE exception_datos_incorrectos;
	END IF;

	INSERT INTO PRODUCTO (
		DESCRIPCIONCORTA, DESCRIPCIONLARGA, INVENTARIO, PRECIOCOMPRA, PRECIOVENTA, TASAIMPUESTO, DESCUENTO
	) VALUES(
		p_descripcionCorta, p_descriptionLarga, p_inventario, p_precioCompra, p_precioVenta, p_tasaImpuesto, p_descuento
	) RETURNING IDPRODUCTO INTO p_id_producto;

	registrar_log(SQLCODE, 'Se ha registrado el producto exitosamente');
	COMMIT;
	
	EXCEPTION
		WHEN exception_datos_incorrectos THEN
			registrar_log(4904, 'Los datos suministrados para el producto son incorrectos');
			ROLLBACK;
			p_error_number := 4904;
		WHEN OTHERS THEN
			registrar_log(SQLCODE, SQLERRM);
			ROLLBACK;
			p_error_number := SQLCODE;
	
END P_CREAR_PRODUCTO;


DECLARE
	var_id_producto		NUMBER;
	var_numero_error	NUMBER;

BEGIN
	P_CREAR_PRODUCTO('Oleo', 'Oleo por unidades', 10, 4, 6.5, 20, 0, var_id_producto, var_numero_error);
	IF (var_numero_error <> 0) THEN
		dbms_output.put_line('Se ha presentado el error ' || var_numero_error);
	ELSE
		dbms_output.put_line('Se ha creado el producto con código ' || var_id_producto);
	END IF;
END;