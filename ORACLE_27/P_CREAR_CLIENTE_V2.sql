CREATE OR REPLACE PROCEDURE P_CREAR_CLIENTE (
	p_nombre IN VARCHAR2,
	p_tipo_doc IN CHAR,
	p_nro_doc IN VARCHAR2,
	p_telefono IN VARCHAR2,
	p_direccion IN VARCHAR2,
	p_id_cliente OUT NUMBER,
	p_error_number OUT NUMBER
) AS
 
	var_n_registros				NUMBER;
	exception_documento_unico	EXCEPTION;
	exception_telefono_unico	EXCEPTION;

BEGIN
	p_error_number := 0;
	p_id_cliente := 0;
	
	var_n_registros := F_VALIDA_DOCUMENTO(p_tipo_doc, p_nro_doc);
	IF (var_n_registros > 0) THEN
		RAISE exception_documento_unico; 
	END IF;

	var_n_registros := F_VALIDA_TELEFONO(p_telefono);
	IF (var_n_registros > 0) THEN
		RAISE exception_telefono_unico; 
	END IF;

	INSERT INTO CLIENTES (
		NOMBRE, TIPODOCUMENTO, NRODOCUMENTO, TELEFONO, DIRECCION)
	VALUES(
		p_nombre, p_tipo_doc, p_nro_doc, p_telefono, p_direccion
	)   RETURNING IDCLIENTE INTO p_id_cliente;

	COMMIT;

	EXCEPTION
		WHEN exception_documento_unico THEN
			ROLLBACK;
			p_error_number := 4901;
			dbms_output.put_line('Ya existe una persona con el documento suministrado');
		WHEN exception_telefono_unico THEN
			ROLLBACK;
			p_error_number := 4902;
			dbms_output.put_line('Ya existe una persona con el teléfono suministrado');
		WHEN OTHERS THEN
			ROLLBACK;
			p_error_number := SQLCODE;
			dbms_output.put_line('Ha ocurrido un error desconocido');

END P_CREAR_CLIENTE;


DECLARE
	var_id_cliente		NUMBER;
	var_numero_error	NUMBER;

BEGIN
	P_CREAR_CLIENTE('Alexis', '1', '23461890', '678321462', 'Córdoba', var_id_cliente, var_numero_error);
	IF (var_numero_error <> 0) THEN
		dbms_output.put_line('Se ha presentado el error ' || var_numero_error);
	ELSE
		dbms_output.put_line('Se ha creado el cliente con código ' || var_id_cliente);
	END IF;
END;
