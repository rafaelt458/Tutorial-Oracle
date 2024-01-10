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
	
	var_n_registros := F_VALIDA_DOCUMENTO(p_id_cliente, p_tipo_doc, p_nro_doc);
	IF (var_n_registros > 0) THEN
		RAISE exception_documento_unico; 
	END IF;

	var_n_registros := F_VALIDA_TELEFONO(p_id_cliente, p_telefono);
	IF (var_n_registros > 0) THEN
		RAISE exception_telefono_unico; 
	END IF;

	INSERT INTO CLIENTES (
		NOMBRE, TIPODOCUMENTO, NRODOCUMENTO, TELEFONO, DIRECCION)
	VALUES(
		p_nombre, p_tipo_doc, p_nro_doc, p_telefono, p_direccion
	)   RETURNING IDCLIENTE INTO p_id_cliente;

	registrar_log(SQLCODE, 'Se ha registrado el cliente exitosamente');

	COMMIT;

	EXCEPTION
		WHEN exception_documento_unico THEN
			registrar_log(4901, 'Ya existe una persona con el documento suministrado');
			ROLLBACK;
			p_error_number := 4901;
		WHEN exception_telefono_unico THEN
			registrar_log(4902, 'Ya existe una persona con el teléfono suministrado');
			ROLLBACK;
			p_error_number := 4902;
		WHEN OTHERS THEN
			registrar_log(SQLCODE, SQLERRM);
			ROLLBACK;
			p_error_number := SQLCODE;

END P_CREAR_CLIENTE;