DECLARE
	CURSOR c1(p_ciudad varchar) IS
		SELECT	IDCLIENTE, NOMBRE, NROCOMPRAS
			FROM	clientes
			WHERE 	LOWER(DIRECCION) LIKE '%' || LOWER(p_ciudad) || '%'
			ORDER BY idcliente;

BEGIN
	
	dbms_output.put_line('Iniciando programa');
	
	IF c1%ISOPEN THEN
		dbms_output.put_line('El cursor está abierto');
	ELSE
		dbms_output.put_line('El cursor está cerrado');
	END IF;


	FOR reg IN c1('madrid') LOOP	
		IF c1%ROWCOUNT = 1 THEN
			IF c1%ISOPEN THEN
				dbms_output.put_line('El cursor está abierto');
			ELSE
				dbms_output.put_line('El cursor está cerrado');
			END IF;
		END IF;
		
		DBMS_OUTPUT.PUT_LINE(c1%ROWCOUNT || '- El cliente con codigo ' || reg.idcliente || ' se llama ' || reg.nombre || ' y ha hecho ' ||  reg.nrocompras || ' compras.');
	END LOOP;

	IF c1%ISOPEN THEN
		dbms_output.put_line('El cursor está abierto');
	ELSE
		dbms_output.put_line('El cursor está cerrado');
	END IF;

	EXCEPTION
		WHEN OTHERS THEN
			dbms_output.put_line('Ha ocurrido un error desconocido manipulando el cursor');
	
END;