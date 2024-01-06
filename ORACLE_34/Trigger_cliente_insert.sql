CREATE OR REPLACE TRIGGER cliente_insert
AFTER INSERT
ON clientes
FOR EACH ROW 

BEGIN
	
	dbms_output.put_line('Ejecutando el trigger INSERT para el cliente ' || :NEW.nombre);
	
	INSERT INTO AUDITORIA
	(USUARIO, TABLA, OPERACION, CODIGO, FECHA)
	VALUES
	(user, 'CLIENTES', 'INSERT', :NEW.idcliente, SYSDATE);
	
END cliente_insert;


-- Viene de la parte 27
DECLARE
	var_id_cliente		NUMBER;
	var_numero_error	NUMBER;

BEGIN
	P_CREAR_CLIENTE('Verónica', '1', '79761890', '697821462', 'Cáceres', var_id_cliente, var_numero_error);
	IF (var_numero_error <> 0) THEN
		dbms_output.put_line('Se ha presentado el error ' || var_numero_error);
	ELSE
		dbms_output.put_line('Se ha creado el cliente con código ' || var_id_cliente);
	END IF;
END;