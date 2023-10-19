SELECT FACTURA_IDFACTURA_SEQ.currval FROM dual;

CREATE SEQUENCE FACTURA_NUMERO_FACTURA_SEQ
	INCREMENT BY 1
	START WITH 17
	NOCYCLE
	NOCACHE
	ORDER;

-- Generar un número de factura con el formato que hemos venido usando
SELECT LPAD('17', 4, '0') FROM dual;
SELECT 'F' || LPAD('17', 4, '0') FROM dual;


-- Factura al cliente con ID 9 y producto con ID 12
INSERT INTO factura
(idcliente, numerofactura, montobruto, descuento, impuesto, montoneto, fechaventa, anulada)
VALUES
(9, 'F' || LPAD(FACTURA_NUMERO_FACTURA_SEQ.NEXTVAL, 4, '0'), 5, 0, 1, 6, SYSDATE, '0');

INSERT INTO LINEAFACTURA
(cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado, idfactura, idproducto)
VALUES
(1, 5, 0, 1, 20, 6, 23, 12);

UPDATE clientes SET
	nrocompras = nrocompras + 1,
	montocompras = montocompras + 6,
	ultimacompra = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idcliente = 9;

UPDATE producto SET
	unidadesvendidas = unidadesvendidas + 1,
	montovendido = montovendido + 5,
	inventario = inventario - 1, 
	ultimaventa = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idproducto = 12;

SELECT FACTURA_IDFACTURA_SEQ.currval FROM dual;