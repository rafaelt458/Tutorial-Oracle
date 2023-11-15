DECLARE
	var_nombre				clientes.nombre%TYPE;
	EXCEPCION_PERSONALIZADA	EXCEPTION;
	var_valor				NUMBER;

BEGIN
	
	var_valor := 15;
	
	SELECT nombre INTO var_nombre 
		FROM	CLIENTES
		WHERE	IDCLIENTE = 2;
	
	dbms_output.put_line('Nombre: ' || var_nombre);

	insert into clientes
	(nombre, tipodocumento, nrodocumento, telefono, direccion, nrocompras, montocompras, fecharegistro, ultimamodificacion)
	values
	('Mario', 1, '9874554513', '14744558824', 'Madrid', 0, 0, SYSDATE, SYSDATE);

	dbms_output.put_line('Se insertó nuevo registro!');

	IF (var_valor = 5) THEN
		RAISE EXCEPCION_PERSONALIZADA; 
	END IF;

	DELETE
		FROM CLIENTES
		WHERE IDCLIENTE = 1;
	
	EXCEPTION
		WHEN NO_DATA_FOUND  THEN
			dbms_output.put_line('No hay datos');
		WHEN TOO_MANY_ROWS THEN
			dbms_output.put_line('Hay demasiados datos');
		WHEN EXCEPCION_PERSONALIZADA THEN
			dbms_output.put_line('Mensaje de la excepción personalizada');
		WHEN DUP_VAL_ON_INDEX THEN
			dbms_output.put_line('Se intentó insertar un valor duplicado');
		WHEN OTHERS THEN
			dbms_output.put_line('Error desconocido');
END;