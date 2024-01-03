DECLARE
	TYPE DATOS_CLIENTE IS RECORD (
		nombre_cliente clientes.nombre%TYPE,
		direccion_cliente clientes.direccion%TYPE,
		telefono_cliente clientes.telefono%type
	);

	cliente DATOS_CLIENTE;

	CURSOR cur IS
		SELECT	nombre, direccion, telefono
			FROM	clientes
			WHERE	IDCLIENTE <= 5;

BEGIN
	
	OPEN cur;

	LOOP
		FETCH cur INTO cliente;
			EXIT WHEN cur%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('El cliente ' || cliente.nombre_cliente || ' vive en ' || cliente.direccion_cliente || ' y su teléfono es ' || cliente.telefono_cliente);
	END LOOP;

	CLOSE cur;

	EXCEPTION
		WHEN OTHERS THEN
			dbms_output.put_line('Ha ocurrido un error desconocido: ' || SQLERRM);
		
END;


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

BEGIN
	
	OPEN cur;

	LOOP
		FETCH cur INTO cliente;
			EXIT WHEN cur%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('El cliente ' || cliente.nombre_cliente || ' vive en ' || cliente.direccion_cliente || ' y su teléfono es ' || cliente.telefono_cliente);
	END LOOP;

	CLOSE cur;

	EXCEPTION
		WHEN OTHERS THEN
			dbms_output.put_line('Ha ocurrido un error desconocido: ' || SQLERRM);
		
END;