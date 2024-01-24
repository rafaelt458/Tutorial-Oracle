DECLARE
	cadena VARCHAR2(200);
	pos NUMBER;
	subcadena VARCHAR2(200);
	cadena2 VARCHAR2(200);
	
BEGIN
	cadena := 'Hoy es 6 de enero';

	-- LENGTH y INSTR
	dbms_output.put_line('La longitud de la cadena es: ' || LENGTH(cadena));

	pos := INSTR(cadena, 'febrero');
	dbms_output.put_line('La posición de febrero es: ' || pos);
	pos := INSTR(cadena, 'enero');
	dbms_output.put_line('La posición de enero es: ' || pos);

	-- SUBSTR, REPLACE
	subcadena := SUBSTR(cadena, 1, 3);
	dbms_output.put_line('La subcadena es: ' || subcadena);
	subcadena := SUBSTR(cadena, pos, 5);
	dbms_output.put_line('La subcadena es: ' || subcadena);

	cadena2 := REPLACE(cadena, 'enero', 'febrero');
	dbms_output.put_line('La cadena con reemplazo es: ' || cadena2);

	-- UPPER, LOWER
	cadena2 := UPPER(REPLACE(cadena, 'enero', 'febrero'));
	dbms_output.put_line('La cadena con reemplazo en mayúsculas: ' || cadena2);
	dbms_output.put_line('La cadena con reemplazo en minúsculas: ' || LOWER(cadena2));
END;


SELECT	RPAD(NOMBRE , 60, '-'),
		LPAD(MONTOCOMPRAS, 20, '0')
	FROM clientes;



SELECT	IDCLIENTE,
		DIRECCION,
		DECODE(DIRECCION, 'Madrid', 20, 'Barcelona', 15, 'Sevilla', 18, 14) AS descuento
	FROM CLIENTES;