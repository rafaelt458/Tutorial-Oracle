CREATE OR REPLACE TRIGGER AUDITORIA_CLIENTES
AFTER INSERT OR UPDATE OR DELETE
ON CLIENTES
FOR EACH ROW 

DECLARE
	VAR_CODIGO NUMBER;
	VAR_OPERACION VARCHAR2(20);

BEGIN
	
	dbms_output.put_line('Ejecutando el trigger de AUDITORIA');

	IF INSERTING THEN 
		VAR_CODIGO := :NEW.idcliente;
		VAR_OPERACION := 'INSERT';
	ELSIF DELETING THEN
		VAR_CODIGO := :OLD.idcliente;
		VAR_OPERACION := 'DELETE';
	ELSE
		VAR_CODIGO := :NEW.idcliente;
		VAR_OPERACION := 'UPDATE';
	END IF;

	INSERT INTO AUDITORIA
	(USUARIO, TABLA, OPERACION, CODIGO, FECHA)
	VALUES
	(user, 'CLIENTES', VAR_OPERACION, VAR_CODIGO, SYSDATE);
	
END AUDITORIA_CLIENTES;