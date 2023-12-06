DECLARE
	CURSOR c1(p_ciudad varchar) IS
		SELECT	IDCLIENTE, NOMBRE, NROCOMPRAS
			FROM	clientes
			WHERE 	LOWER(DIRECCION) LIKE '%' || LOWER(p_ciudad) || '%'
			ORDER BY idcliente;
	v_idcliente		clientes.idcliente%TYPE;
	v_nombre		clientes.nombre%TYPE;
	v_nrocompras	clientes.nrocompras%TYPE;

BEGIN
	
	dbms_output.put_line('Iniciando programa');
	
	OPEN c1('madrid');

	IF c1%ISOPEN THEN
		dbms_output.put_line('El cursor está abierto');
	ELSE
		dbms_output.put_line('El cursor está cerrado');
	END IF;

	FETCH c1 INTO v_idcliente, v_nombre, v_nrocompras;

	WHILE c1%FOUND LOOP
		DBMS_OUTPUT.PUT_LINE(c1%ROWCOUNT || '- El cliente con codigo ' || v_idcliente || ' se llama ' || v_nombre || ' y ha hecho ' ||  v_nrocompras || ' compras.');
		FETCH c1 INTO v_idcliente, v_nombre, v_nrocompras;
	END LOOP;

	CLOSE c1;

	IF c1%ISOPEN THEN
		dbms_output.put_line('El cursor está abierto');
	ELSE
		dbms_output.put_line('El cursor está cerrado');
	END IF;

	EXCEPTION
		WHEN OTHERS THEN
			dbms_output.put_line('Ha ocurrido un error desconocido manipulando el cursor');
	
END;