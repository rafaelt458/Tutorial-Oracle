DECLARE
	var_sesion			VARCHAR2(10);
	var_producto_id		NUMBER;
	var_cantidad		NUMBER;
	var_numero_error	NUMBER;

BEGIN
	var_sesion := 'S000000004';
	var_producto_id := 1;
	var_cantidad := 5;
	FACTURACION_PKG.P_INSERTAR_CARRITO(var_sesion, var_producto_id, var_cantidad, var_numero_error);
	IF (var_numero_error <> 0) THEN
		dbms_output.put_line('Se ha presentado el error ' || var_numero_error);
	ELSE
		dbms_output.put_line('Se ha insertado el producto con código ' || var_producto_id);
	END IF;
END;





DECLARE
	var_sesion			VARCHAR2(10);
	var_producto_id		NUMBER;
	var_cantidad		NUMBER;
	var_numero_error	NUMBER;

BEGIN
	var_sesion := 'S000000004';
	var_producto_id := 1;
	var_cantidad := 5;
	FACTURACION_PKG.P_QUITAR_DEL_CARRITO(var_sesion, var_producto_id, var_cantidad, var_numero_error);
	IF (var_numero_error <> 0) THEN
		dbms_output.put_line('Se ha presentado el error ' || var_numero_error);
	ELSE
		dbms_output.put_line('Se ha quitado una cantidad del producto con código ' || var_producto_id);
	END IF;
END;
