-- Creado en la parte 27
CREATE OR REPLACE FUNCTION F_VALIDA_DOCUMENTO (
	p_id_cliente IN NUMBER,
	p_tipo_doc IN CHAR,
	p_nro_doc IN VARCHAR2
) RETURN NUMBER AS

	var_n_registros	NUMBER;

BEGIN
	SELECT COUNT(*) INTO var_n_registros
		FROM CLIENTES
		WHERE  IDCLIENTE <> p_id_cliente
		AND TIPODOCUMENTO = p_tipo_doc
		AND NRODOCUMENTO = p_nro_doc;
	
	RETURN var_n_registros;
	
END F_VALIDA_DOCUMENTO;


SELECT F_VALIDA_DOCUMENTO(0, '1', '123456') FROM dual; 

-- Creado en la parte 27
CREATE OR REPLACE FUNCTION F_VALIDA_TELEFONO (
	p_id_cliente IN NUMBER,
	p_telefono IN VARCHAR2
) RETURN NUMBER AS

	var_n_registros	NUMBER;

BEGIN
	SELECT COUNT(*) INTO var_n_registros
		FROM CLIENTES
		WHERE IDCLIENTE <> p_id_cliente
		AND TELEFONO = p_telefono;
	
	RETURN var_n_registros;
	
END F_VALIDA_TELEFONO;

SELECT F_VALIDA_TELEFONO(0, '123456') FROM dual;