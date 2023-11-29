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
	
	OPEN c1('madrid');

	LOOP
		FETCH c1 INTO v_idcliente, v_nombre, v_nrocompras;
		EXIT WHEN c1%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('El cliente con codigo ' || v_idcliente || ' se llama ' || v_nombre || ' y ha hecho ' ||  v_nrocompras || ' compras.');
	END LOOP;

	CLOSE c1;

	EXCEPTION
		WHEN OTHERS THEN
			dbms_output.put_line('Ha ocurrido un error desconocido manipulando el cursor');
	
END;