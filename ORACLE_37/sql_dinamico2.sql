DECLARE
	num_registros NUMBER;
	nombre VARCHAR2(60);
	query VARCHAR2(500);
	idcliente NUMBER;
	
BEGIN
	
	query := 'SELECT COUNT(*) FROM FACTURA';

	EXECUTE IMMEDIATE query INTO num_registros;

	dbms_output.put_line('Número de registros recuperados: ' || num_registros);

	idcliente := 7;
	query := 'SELECT nombre FROM Clientes WHERE idcliente = :idcliente';
	EXECUTE IMMEDIATE query INTO nombre USING idcliente;

	dbms_output.put_line('El nombre del cliente es: ' || nombre);
	
END;


DECLARE
	TYPE TIPO_CURSOR IS REF CURSOR;
	facturas TIPO_CURSOR;
	registro factura%ROWTYPE;
	query VARCHAR2(500);
	montoneto NUMBER;
	
BEGIN
	
	montoneto := 5;
	query := 'SELECT * FROM factura WHERE montoneto <= :montoneto';
	
	OPEN facturas FOR query USING montoneto;

	LOOP
		FETCH facturas INTO registro;
		EXIT WHEN facturas%NOTFOUND;
		dbms_output.put_line('Número de factura: ' || registro.numerofactura);
	END LOOP;

	CLOSE facturas;
	
END;
