DECLARE
	fecha DATE;
	ultimacompra1 DATE;
	ultimacompra2 DATE;
	numero NUMBER;

BEGIN
	-- SYSDATE, TO_CHAR
	SELECT SYSDATE INTO fecha
		FROM DUAL;
	
	dbms_output.put_line('La fecha de hoy es: ' || fecha);
	dbms_output.put_line('La fecha de hoy es: ' || TO_CHAR(fecha, 'DD/MM/YYYY HH24:MI:SS'));
	
	-- NVL, TO_DATE
	SELECT NVL(ULTIMACOMPRA, TO_DATE('01-01-1900', 'DD-MM-YYYY')) INTO ultimacompra1
		FROM CLIENTES
		WHERE IDCLIENTE = 7;

	SELECT NVL(ULTIMACOMPRA, TO_DATE('01-01-1900', 'DD-MM-YYYY')) INTO ultimacompra2
		FROM CLIENTES
		WHERE IDCLIENTE = 20;
	
	dbms_output.put_line('Fecha de última compra cliente 7: ' || TO_CHAR(ultimacompra1, 'DD/MM/YYYY HH24:MI:SS'));
	dbms_output.put_line('Fecha de última compra cliente 20: ' || TO_CHAR(ultimacompra2, 'DD/MM/YYYY HH24:MI:SS'));

	-- TO_NUMBER, TRUNC
	numero := TO_NUMBER('10.55');
	dbms_output.put_line('Valor del número: ' || numero);	
	dbms_output.put_line('Valor del número sin decimales: ' || TRUNC(numero));

	SELECT TRUNC(SYSDATE) INTO fecha
		FROM DUAL;
	dbms_output.put_line('La fecha de hoy es: ' || TO_CHAR(fecha, 'DD/MM/YYYY HH24:MI:SS'));
END;
