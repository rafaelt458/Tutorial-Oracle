-- Consulta del cliente con más compras
SELECT	*
	FROM factura
	WHERE IDCLIENTE = 1;

/* Desarrollo de programa PL/SQL donde ponemos en práctica el uso de variables
   con los atributos %TYPE y %ROWTYPE. También mostramos el uso de cursores
   implícitos y algunas otras características del lenguaje */
DECLARE
	factura1 factura%rowtype;
	factura2 factura%rowtype;
	factura3 factura%rowtype;
	total factura.montoneto%type;
	impuestos factura.impuesto%type;
	nombre_cliente clientes.nombre%type;
	direccion_cliente clientes.direccion%type;
	telefono_cliente clientes.telefono%type;

BEGIN
	
	dbms_output.put_line(' ');

	-- Carga de los datos de las facturas
	SELECT * INTO factura1
		FROM FACTURA
		WHERE IDFACTURA = 2;
	
	dbms_output.put_line('El monto neto 1: ' || factura1.montoneto);
	
	SELECT * INTO factura2
		FROM FACTURA
		WHERE IDFACTURA = 9;
	
	dbms_output.put_line('El monto neto 2: ' || factura2.montoneto);
	
	SELECT * INTO factura3
		FROM FACTURA
		WHERE IDFACTURA = 11;
	
	dbms_output.put_line('El monto neto 3: ' || factura3.montoneto);

	-- Carga de los datos del cliente
	SELECT	nombre, direccion, telefono
			INTO nombre_cliente, direccion_cliente, telefono_cliente
		FROM	CLIENTES
		WHERE	IDCLIENTE = 1;
	
	-- Cálculos
	total := factura1.montoneto + factura2.montoneto + factura3.montoneto;
	impuestos := factura1.impuesto + factura2.impuesto + factura3.impuesto;

	
	dbms_output.put_line(' ');
	dbms_output.put_line('El monto neto de la compra del cliente ' || nombre_cliente || ' es: ' || total);
	dbms_output.put_line('De los cuales ' || impuestos || ' son impuestos');
	dbms_output.put_line('La dirección de la entrega es: ' || direccion_cliente);
	dbms_output.put_line('El teléfono del cliente es: ' || telefono_cliente);
	
END;