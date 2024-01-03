-- Ejemplo de conjunto
DECLARE
	TYPE DATOS_CLIENTE IS RECORD (
		nombre_cliente VARCHAR2(60),
		direccion_cliente VARCHAR2(200),
		telefono_cliente VARCHAR2(25)
	);

	cliente DATOS_CLIENTE;

	CURSOR cur IS
		SELECT	nombre, direccion, telefono
			FROM	clientes
			WHERE	IDCLIENTE <= 5;
		
	TYPE CONJUNTO_CLIENTES IS VARRAY(3) OF DATOS_CLIENTE;

	conjunto CONJUNTO_CLIENTES := CONJUNTO_CLIENTES(
		DATOS_CLIENTE('', '', ''),
		DATOS_CLIENTE('', '', ''),
		DATOS_CLIENTE('', '', '')
	);

	j NUMBER;

BEGIN
	
	j := 1;

	OPEN cur;

	LOOP
		FETCH cur INTO cliente;
			EXIT WHEN cur%NOTFOUND;
		conjunto(j) := cliente;
		j := j + 1;
	END LOOP;

	CLOSE cur;

	FOR i IN conjunto.FIRST .. conjunto.LAST
	LOOP
		DBMS_OUTPUT.PUT_LINE('El cliente ' || conjunto(i).nombre_cliente || ' vive en ' || conjunto(i).direccion_cliente || ' y su teléfono es ' || conjunto(i).telefono_cliente);
	END LOOP;

	EXCEPTION
		WHEN OTHERS THEN
			dbms_output.put_line('Ha ocurrido un error desconocido: ' || SQLERRM);
		
END;