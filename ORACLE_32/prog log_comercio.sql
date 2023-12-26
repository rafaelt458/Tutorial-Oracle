CREATE OR REPLACE PROCEDURE registrar_log(codigo NUMBER, descripcion VARCHAR2)
AS
PRAGMA AUTONOMOUS_TRANSACTION;

BEGIN
	INSERT INTO LOG_COMERCIO
	(codigo_error, mensaje_error)
	VALUES
	(codigo, descripcion);

	COMMIT;
END ;