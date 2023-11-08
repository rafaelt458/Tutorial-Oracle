DECLARE
	codcliente		NUMBER;
	datos_cliente	clientes%rowtype;
	descuento		clientes.montocompras%type;

BEGIN
	-- Cargo los datos del cliente
	codcliente := 2;

	SELECT *
		INTO	datos_cliente
		FROM	CLIENTES
		WHERE	IDCLIENTE = codcliente;
	
	IF datos_cliente.montocompras <= 5 THEN
		GOTO DESCUENTO1;
	ELSIF datos_cliente.montocompras <= 10 THEN
		GOTO DESCUENTO2;
	ELSE
		GOTO DESCUENTO3;
	END IF;

	<<DESCUENTO1>>
		dbms_output.put_line('Se otorga descuento 1');
		descuento := 0.10 * datos_cliente.montocompras;  
		GOTO CONTINUACION;
	
	<<DESCUENTO2>>
		dbms_output.put_line('Se otorga descuento 2');
		descuento := 0.15 * datos_cliente.montocompras;
		GOTO CONTINUACION;
	
	<<DESCUENTO3>>
		dbms_output.put_line('Se otorga descuento 3');
		descuento := 0.25 * datos_cliente.montocompras;
	
	<<CONTINUACION>>
		dbms_output.put_line('Se dará al cliente ' || datos_cliente.nombre || ' un descuento de ' || descuento || ' en su próxima compra');
	
END;



-- Estructuras de repetición
DECLARE
	contador	NUMBER;
	limite		NUMBER;

BEGIN
	contador := 0;
	limite := 5;
	
	dbms_output.put_line(' ');
	LOOP
		contador := contador + 1;
		dbms_output.put_line('[LOOP] El contador vale: ' || contador);
		IF (contador >= limite) THEN
			dbms_output.put_line('Saliendo del bucle LOOP!');
			EXIT;
		END IF;
	END LOOP;
	dbms_output.put_line('Ha finalizado el bucle LOOP');

	contador := 0;
	dbms_output.put_line(' ');
	WHILE (contador < limite) LOOP
		contador := contador + 1;
		dbms_output.put_line('[WHILE] El contador vale: ' || contador);
	END LOOP;
	dbms_output.put_line('Ha finalizado el bucle WHILE');

	dbms_output.put_line(' ');
	FOR contador IN 1..limite LOOP	
		dbms_output.put_line('[FOR] El contador vale: ' || contador);
	END LOOP;
	dbms_output.put_line('Ha finalizado el bucle FOR ascendente');

	dbms_output.put_line(' ');
	FOR contador IN REVERSE 1..limite LOOP	
		dbms_output.put_line('[FOR] El contador vale: ' || contador);
	END LOOP;
	dbms_output.put_line('Ha finalizado el bucle FOR descendente');

END;
