DECLARE
	CURSOR c1 IS
		SELECT	*
			FROM	clientes
			ORDER BY idcliente;
	cliente CLIENTES%rowtype;

BEGIN
	
	OPEN c1;

	LOOP
		FETCH c1 INTO cliente;
		EXIT WHEN c1%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('El cliente con codigo ' || cliente.idcliente || ' se llama ' || cliente.nombre || ' y vive en ' || cliente.direccion);
	END LOOP;

	CLOSE c1;

	EXCEPTION
		WHEN OTHERS THEN
			dbms_output.put_line('Ha ocurrido un error desconocido manipulando el cursor');
	
END;