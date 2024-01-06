CREATE OR REPLACE TRIGGER cliente_delete
AFTER DELETE
ON clientes
FOR EACH ROW 

BEGIN
	
	dbms_output.put_line('Ejecutando el trigger DELETE para el cliente ' || :OLD.nombre);
	
	INSERT INTO AUDITORIA
	(USUARIO, TABLA, OPERACION, CODIGO, FECHA)
	VALUES
	(user, 'CLIENTES', 'DELETE', :OLD.idcliente, SYSDATE);
	
END cliente_delete;

-- Viene de la parte 32
DECLARE
	var_id_cliente		NUMBER;
	var_numero_error	NUMBER;

BEGIN
	P_ELIMINAR_CLIENTE(32, var_numero_error);
	IF (var_numero_error <> 0) THEN
		dbms_output.put_line('Se ha presentado el error ' || var_numero_error);
	ELSE
		dbms_output.put_line('Se ha eliminado el cliente');
	END IF;
END;
