DECLARE
	CURSOR cursor_clientes is
		SELECT	c.idcliente,
				c.nombre,
				f.fechaventa
			FROM CLIENTES c INNER JOIN FACTURA f ON
					c.IDCLIENTE = f.IDFACTURA
			ORDER BY f.FECHAVENTA ASC
	FOR UPDATE;
	
	v_idcliente		clientes.idcliente%TYPE;
	v_nombre		clientes.nombre%TYPE;
	v_fechaventa	DATE;

BEGIN
	
	OPEN cursor_clientes;

	LOOP
		FETCH cursor_clientes INTO v_idcliente, v_nombre, v_fechaventa;
		EXIT WHEN cursor_clientes%NOTFOUND;
	
		UPDATE CLIENTES SET
			ULTIMACOMPRA = v_fechaventa
		WHERE idcliente = v_idcliente;
	
		DBMS_OUTPUT.PUT_LINE('El cliente con codigo ' || v_idcliente || ' se llama ' || v_nombre || ' y su ultima compra fue el ' ||  v_fechaventa);
	END LOOP;
	

	CLOSE cursor_clientes;

	EXCEPTION
		WHEN OTHERS THEN
			dbms_output.put_line('Ha ocurrido un error desconocido manipulando el cursor ' || SQLCODE);
END;