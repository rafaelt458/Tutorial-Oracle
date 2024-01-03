-- Ejemplo tabla indexada
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
		
	TYPE TABLA_CLIENTES IS TABLE OF DATOS_CLIENTE INDEX BY BINARY_INTEGER;

	mi_tabla TABLA_CLIENTES;

	j NUMBER;

BEGIN
	
	j := 1;

	OPEN cur;

	LOOP
		FETCH cur INTO cliente;
			EXIT WHEN cur%NOTFOUND;
		mi_tabla(j) := cliente;
		j := j + 1;
	END LOOP;

	CLOSE cur;

	FOR i IN mi_tabla.FIRST .. mi_tabla.LAST
	LOOP
		DBMS_OUTPUT.PUT_LINE('El cliente ' || mi_tabla(i).nombre_cliente || ' vive en ' || mi_tabla(i).direccion_cliente || ' y su teléfono es ' || mi_tabla(i).telefono_cliente);
	END LOOP;

	EXCEPTION
		WHEN OTHERS THEN
			dbms_output.put_line('Ha ocurrido un error desconocido: ' || SQLERRM);
		
END;