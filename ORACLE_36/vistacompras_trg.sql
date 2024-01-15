CREATE OR REPLACE TRIGGER vistacompras_trg
	INSTEAD OF INSERT OR UPDATE OR DELETE
	ON vistacompras

BEGIN
	IF inserting THEN
		DBMS_OUTPUT.PUT_LINE('Operación de inserción personalizada');
		DBMS_OUTPUT.PUT_LINE('Nuevo nombre: ' || :new.nombre);
		DBMS_OUTPUT.PUT_LINE('Nuevo teléfono: ' || :new.telefono);
	ELSIF updating THEN
		DBMS_OUTPUT.PUT_LINE('Operación de actualización personalizada');
		DBMS_OUTPUT.PUT_LINE('Id del cliente: ' || :old.idcliente);
		DBMS_OUTPUT.PUT_LINE('Nombre del cliente: ' || :old.nombre);
		DBMS_OUTPUT.PUT_LINE('Monto neto: ' || :old.montoneto);
		DBMS_OUTPUT.PUT_LINE('Nuevo nombre: ' || :new.nombre);
		DBMS_OUTPUT.PUT_LINE('Nuevo teléfono: ' || :new.telefono);
		UPDATE CLIENTES SET 
			nombre = :new.nombre
		WHERE idcliente = :old.idcliente;
	ELSE
		DBMS_OUTPUT.PUT_LINE('Operación de eliminación personalizada');
		DBMS_OUTPUT.PUT_LINE('Id del cliente: ' || :old.idcliente);
		DBMS_OUTPUT.PUT_LINE('Nombre del cliente: ' || :old.nombre);
		DBMS_OUTPUT.PUT_LINE('Monto neto: ' || :old.montoneto);
	END IF;
	
END vistacompras_trg;


INSERT INTO VISTACOMPRAS
(IDCLIENTE, NOMBRE, TELEFONO, DIRECCION, NROCOMPRAS, ULTIMACOMPRA, NUMEROFACTURA, MONTONETO, IMPUESTO, FECHAVENTA)
VALUES
(0, 'Hola', 'TELEFONO', '', 0, '', '', 0, 0, '');

UPDATE VISTACOMPRAS SET
	IDCLIENTE=0,
	NOMBRE='María Isabel',
	TELEFONO='ABCD',
	DIRECCION='',
	NROCOMPRAS=0,
	ULTIMACOMPRA='',
	NUMEROFACTURA='',
	MONTONETO=0,
	IMPUESTO=0,
	FECHAVENTA=''
WHERE MONTONETO  > 10;

DELETE
	FROM	VISTACOMPRAS
	WHERE 	montoneto <= 5;