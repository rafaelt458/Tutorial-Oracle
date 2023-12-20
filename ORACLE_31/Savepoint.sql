CREATE TABLE temporal (
    valor VARCHAR2(50 CHAR)
);


DECLARE
	v_filas NUMBER;

BEGIN
	v_filas := 0;

	DELETE
		FROM TEMPORAL;
	
	SAVEPOINT cero;

	INSERT INTO temporal (valor) VALUES ('primer valor');

	SAVEPOINT una;

	INSERT INTO temporal (valor) VALUES ('segundo valor');

	SAVEPOINT dos;

	INSERT INTO temporal (valor) VALUES ('tercer valor');

	SAVEPOINT tres;

	IF v_filas = 1 THEN
		ROLLBACK TO una;
	ELSIF v_filas = 2 THEN
		ROLLBACK TO dos;
	ELSIF v_filas = 3 THEN
		ROLLBACK TO tres;
	ELSE
		ROLLBACK TO cero;
	END IF;

	COMMIT WORK;

	EXCEPTION
		WHEN OTHERS THEN
			ROLLBACK;
			dbms_output.put_line('Ha ocurrido el error número: ' || SQLCODE);

END;