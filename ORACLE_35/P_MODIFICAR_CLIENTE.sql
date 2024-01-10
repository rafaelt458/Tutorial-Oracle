CREATE OR REPLACE PROCEDURE P_MODIFICAR_CLIENTE (
	p_id_cliente IN NUMBER,
	p_telefono IN VARCHAR2,
	p_direccion IN VARCHAR2,
	p_error_number OUT NUMBER
) AS

	var_n_registros				NUMBER;
	exception_cliente_inexistente	EXCEPTION;
	exception_telefono_unico	EXCEPTION;
	
BEGIN
	
	p_error_number := 0;

	SELECT COUNT(*) INTO var_n_registros
		FROM CLIENTES
		WHERE idcliente = p_id_cliente;
	
	IF (var_n_registros = 0) THEN
		RAISE exception_cliente_inexistente;
	END IF;

	var_n_registros := F_VALIDA_TELEFONO(p_id_cliente, p_telefono);
	IF (var_n_registros > 0) THEN
		RAISE exception_telefono_unico; 
	END IF;

	UPDATE CLIENTES SET
		TELEFONO = p_telefono,
		DIRECCION = p_direccion,
		ULTIMAMODIFICACION = SYSDATE
	WHERE IDCLIENTE = p_id_cliente;

	registrar_log(SQLCODE, 'Se ha modificado el cliente exitosamente');

	COMMIT;

	EXCEPTION
		WHEN exception_cliente_inexistente THEN
			registrar_log(4903, 'Se ha intentado modificar un cliente inexistente');
			ROLLBACK;
			p_error_number := 4903;
		WHEN exception_telefono_unico THEN
			registrar_log(4902, 'Ya existe una persona con el teléfono suministrado');
			ROLLBACK;
			p_error_number := 4902;
		WHEN OTHERS THEN
			registrar_log(SQLCODE, SQLERRM);
			ROLLBACK;
			p_error_number := SQLCODE;
	
END P_MODIFICAR_CLIENTE;



DECLARE
	var_id_cliente		NUMBER;
	var_numero_error	NUMBER;

BEGIN
	var_id_cliente := 26;
	P_MODIFICAR_CLIENTE(var_id_cliente, '678321499', 'Sevilla', var_numero_error);
	IF (var_numero_error <> 0) THEN
		dbms_output.put_line('Se ha presentado el error ' || var_numero_error);
	ELSE
		dbms_output.put_line('Se ha modificado el cliente con código ' || var_id_cliente);
	END IF;
END;