CREATE OR REPLACE PROCEDURE P_ACTUALIZAR_INVENTARIO (
	p_id_producto IN NUMBER,
	p_inventario NUMBER,
	p_error_number OUT NUMBER
) AS 

	var_n_registros					NUMBER;
	exception_producto_inexistente	EXCEPTION;
	exception_datos_incorrectos		EXCEPTION;
	operacion						VARCHAR2(512);

BEGIN
	p_error_number := 0;

	IF (p_inventario = 0) THEN
		RAISE exception_datos_incorrectos;
	END IF;

	SELECT COUNT(*) INTO var_n_registros
		FROM PRODUCTO
		WHERE idproducto = p_id_producto;
	
	IF (var_n_registros = 0) THEN
		RAISE exception_producto_inexistente;
	END IF;

	UPDATE PRODUCTO SET
		INVENTARIO  = INVENTARIO + p_inventario,
		ULTIMAMODIFICACION = SYSDATE
	WHERE IDPRODUCTO = p_id_producto;

	operacion := 'Inventario del producto con código ' ||  p_id_producto || ' actualizado en ' || p_inventario || ' unidades';
	registrar_log(SQLCODE, operacion);
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
	
END P_ACTUALIZAR_INVENTARIO;


DECLARE
	p_id_producto		NUMBER;
	var_numero_error	NUMBER;

BEGIN
	p_id_producto := 26;
	P_ACTUALIZAR_INVENTARIO(p_id_producto, 10, var_numero_error);
	IF (var_numero_error <> 0) THEN
		dbms_output.put_line('Se ha presentado el error ' || var_numero_error);
	ELSE
		dbms_output.put_line('Se ha actualizado el inventario del producto con código ' || p_id_producto);
	END IF;
END;