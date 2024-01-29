CREATE OR REPLACE PROCEDURE P_ELIMINAR_PRODUCTO (
	p_codigo IN NUMBER,
	p_error_number OUT NUMBER
) AS


	v_num_productos NUMBER;
	exception_producto_inexistente	EXCEPTION;
	exception_producto_con_ventas	EXCEPTION;
  	PRAGMA EXCEPTION_INIT(exception_producto_con_ventas, -2292);
  	
 BEGIN
	 p_error_number := 0;
	 
	SELECT COUNT(*) INTO v_num_productos
		FROM	PRODUCTO
		WHERE 	idproducto = p_codigo;
	
	IF (v_num_productos = 0) THEN
		RAISE exception_producto_inexistente;
	END IF;

	DELETE
		FROM 	PRODUCTO
		WHERE	idproducto = p_codigo;

	registrar_log(SQLCODE, 'Se ha eliminado el producto exitosamente');
	COMMIT;

	EXCEPTION
		WHEN exception_producto_inexistente THEN
			registrar_log(4905, 'Se ha intentado eliminar un producto inexistente');
			ROLLBACK;
			p_error_number := 4905;
		WHEN exception_producto_con_ventas THEN
			registrar_log(SQLCODE, SQLERRM);
			ROLLBACK;
			p_error_number := SQLCODE;
		WHEN OTHERS THEN
			registrar_log(SQLCODE, SQLERRM);
			ROLLBACK;
			p_error_number := SQLCODE;
	
END P_ELIMINAR_PRODUCTO;
 

DECLARE
	var_id_producto		NUMBER;
	var_numero_error	NUMBER;

BEGIN
	var_id_producto := 28;
	P_ELIMINAR_PRODUCTO(var_id_producto, var_numero_error);
	IF (var_numero_error <> 0) THEN
		dbms_output.put_line('Se ha presentado el error ' || var_numero_error);
	ELSE
		dbms_output.put_line('Se ha eliminado el producto con código ' || var_id_producto);
	END IF;
END;