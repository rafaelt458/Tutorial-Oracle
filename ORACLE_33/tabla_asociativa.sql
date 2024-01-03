-- Ejemplo tabla asociativa
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

	TYPE TABLA_CLIENTES IS TABLE OF DATOS_CLIENTE INDEX BY VARCHAR2(60);
	
	mis_clientes TABLA_CLIENTES;

	i VARCHAR2(60);
BEGIN
  
	OPEN cur;

	LOOP
		FETCH cur INTO cliente;
			EXIT WHEN cur%NOTFOUND;
		mis_clientes(cliente.nombre_cliente) := cliente;
	END LOOP;

	CLOSE cur;

	i := mis_clientes.FIRST;
	WHILE i IS NOT NULL
	LOOP
		DBMS_OUTPUT.PUT_LINE('El cliente ' || mis_clientes(i).nombre_cliente || ' vive en ' || mis_clientes(i).direccion_cliente || ' y su teléfono es ' || mis_clientes(i).telefono_cliente);
		i := mis_clientes.NEXT(i);
	END LOOP;

	EXCEPTION
		WHEN OTHERS THEN
			dbms_output.put_line('Ha ocurrido un error desconocido: ' || SQLERRM);
	
	
END;