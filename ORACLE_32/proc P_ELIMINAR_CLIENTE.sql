CREATE OR REPLACE PROCEDURE P_ELIMINAR_CLIENTE (
	p_codigo IN NUMBER,
	p_error_number OUT NUMBER
) AS 

	v_num_clientes NUMBER;
	exception_cliente_inexistente	EXCEPTION;
	exception_cliente_tiene_facturas EXCEPTION;
  	PRAGMA EXCEPTION_INIT(exception_cliente_tiene_facturas, -2292);

BEGIN
	p_error_number := 0;
	
	SELECT COUNT(*) INTO v_num_clientes
		FROM CLIENTES
		WHERE idcliente = p_codigo;
	
	IF (v_num_clientes = 0) THEN
		RAISE exception_cliente_inexistente;
	END IF;

	DELETE 
		FROM CLIENTES
		WHERE idcliente = p_codigo;
	
	COMMIT;
	registrar_log(SQLCODE, 'Se ha eliminado el cliente exitosamente');

	EXCEPTION
		WHEN exception_cliente_inexistente THEN
			registrar_log(4903, 'Se ha intentado eliminar un cliente inexistente');
			ROLLBACK;
			p_error_number := 4903;
		WHEN exception_cliente_tiene_facturas THEN
			registrar_log(SQLCODE, SQLERRM);
			ROLLBACK;
			p_error_number := SQLCODE;
		WHEN OTHERS THEN
			registrar_log(SQLCODE, SQLERRM);
			ROLLBACK;
			p_error_number := SQLCODE;
	
END P_ELIMINAR_CLIENTE;



DECLARE
	var_id_cliente		NUMBER;
	var_numero_error	NUMBER;

BEGIN
	P_ELIMINAR_CLIENTE(28, var_numero_error);
	IF (var_numero_error <> 0) THEN
		dbms_output.put_line('Se ha presentado el error ' || var_numero_error);
	ELSE
		dbms_output.put_line('Se ha eliminado el cliente con código');
	END IF;
END;
