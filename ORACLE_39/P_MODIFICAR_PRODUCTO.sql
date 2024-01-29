CREATE OR REPLACE PROCEDURE P_MODIFICAR_PRODUCTO (
	p_id_producto IN NUMBER,
	p_descripcionCorta VARCHAR2,
	p_descriptionLarga VARCHAR2,
	p_precioCompra NUMBER,
	p_precioVenta NUMBER,
	p_tasaImpuesto NUMBER,
	p_descuento NUMBER,
	p_error_number OUT NUMBER
) AS

	var_n_registros					NUMBER;
	exception_producto_inexistente	EXCEPTION;
	exception_datos_incorrectos		EXCEPTION;
	
BEGIN
	p_error_number := 0;

	IF (p_precioCompra <= 0) OR (p_precioVenta <= 0) OR (p_tasaImpuesto < 0) OR (p_descuento < 0) THEN
		RAISE exception_datos_incorrectos;
	END IF;

	SELECT COUNT(*) INTO var_n_registros
		FROM PRODUCTO
		WHERE idproducto = p_id_producto;
	
	IF (var_n_registros = 0) THEN
		RAISE exception_producto_inexistente;
	END IF;

	UPDATE PRODUCTO SET
		DESCRIPCIONCORTA = p_descripcionCorta,
		DESCRIPCIONLARGA = p_descriptionLarga,
		PRECIOCOMPRA = p_precioCompra,
		PRECIOVENTA = p_precioVenta,
		TASAIMPUESTO = p_tasaImpuesto,
		DESCUENTO = p_descuento,
		ULTIMAMODIFICACION = SYSDATE
	WHERE IDPRODUCTO = p_id_producto;

	registrar_log(SQLCODE, 'Se ha modificado el producto exitosamente');
	COMMIT;

	EXCEPTION
		WHEN exception_datos_incorrectos THEN
			registrar_log(4904, 'Los datos suministrados para el producto son incorrectos');
			ROLLBACK;
			p_error_number := 4904;
		WHEN exception_producto_inexistente THEN
			registrar_log(4905, 'Se ha intentado modificar un producto inexistente');
			ROLLBACK;
			p_error_number := 4905;
		WHEN OTHERS THEN
			registrar_log(SQLCODE, SQLERRM);
			ROLLBACK;
			p_error_number := SQLCODE;
	
END P_MODIFICAR_PRODUCTO;



DECLARE
	p_id_producto		NUMBER;
	var_numero_error	NUMBER;

BEGIN
	p_id_producto := 26;
	P_MODIFICAR_PRODUCTO(p_id_producto, 'Folios', 'Folios', 3, 5, 20, 0, var_numero_error);
	IF (var_numero_error <> 0) THEN
		dbms_output.put_line('Se ha presentado el error ' || var_numero_error);
	ELSE
		dbms_output.put_line('Se ha modificado el producto con código ' || p_id_producto);
	END IF;
END;