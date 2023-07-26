-- Factura al cliente con ID 2 y producto con ID 6
INSERT INTO factura
(idcliente, numerofactura, montobruto, descuento, impuesto, montoneto, fechaventa, anulada)
VALUES
(2, 'F0003', 6, 0, 1.2, 7.2, SYSDATE, '0');

INSERT INTO LINEAFACTURA
(cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado, idfactura, idproducto)
VALUES
(2, 6, 0, 1.2, 20, 7.2, 3, 6);

UPDATE clientes SET
	nrocompras = nrocompras + 1,
	montocompras = montocompras + 7.2,
	ultimacompra = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idcliente = 2;

UPDATE producto SET
	unidadesvendidas = unidadesvendidas + 2,
	montovendido = montovendido + 6,
	ultimaventa = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idproducto = 6;

-- Factura al cliente con ID 3 y producto con ID 7
INSERT INTO factura
(idcliente, numerofactura, montobruto, descuento, impuesto, montoneto, fechaventa, anulada)
VALUES
(3, 'F0004', 8, 0, 1.6, 9.6, SYSDATE, '0');

INSERT INTO LINEAFACTURA
(cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado, idfactura, idproducto)
VALUES
(1, 8, 0, 1.6, 20, 9.6, 4, 7);

UPDATE clientes SET
	nrocompras = nrocompras + 1,
	montocompras = montocompras + 9.6,
	ultimacompra = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idcliente = 3;

UPDATE producto SET
	unidadesvendidas = unidadesvendidas + 1,
	montovendido = montovendido + 8,
	ultimaventa = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idproducto = 7;

-- Factura al cliente con ID 4 y producto con ID 8
INSERT INTO factura
(idcliente, numerofactura, montobruto, descuento, impuesto, montoneto, fechaventa, anulada)
VALUES
(4, 'F0005', 2, 0, 0.4, 2.4, SYSDATE, '0');

INSERT INTO LINEAFACTURA
(cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado, idfactura, idproducto)
VALUES
(1, 2, 0, 0.4, 20, 2.4, 5, 8);

UPDATE clientes SET
	nrocompras = nrocompras + 1,
	montocompras = montocompras + 2.4,
	ultimacompra = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idcliente = 4;

UPDATE producto SET
	unidadesvendidas = unidadesvendidas + 1,
	montovendido = montovendido + 2,
	ultimaventa = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idproducto = 8;

-- Factura al cliente con ID 5 y producto con ID 7
INSERT INTO factura
(idcliente, numerofactura, montobruto, descuento, impuesto, montoneto, fechaventa, anulada)
VALUES
(5, 'F0006', 16, 0, 3.2, 19.2, SYSDATE, '0');

INSERT INTO LINEAFACTURA
(cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado, idfactura, idproducto)
VALUES
(2, 16, 0, 3.2, 20, 19.2, 6, 7);

UPDATE clientes SET
	nrocompras = nrocompras + 1,
	montocompras = montocompras + 19.2,
	ultimacompra = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idcliente = 4;

UPDATE producto SET
	unidadesvendidas = unidadesvendidas + 2,
	montovendido = montovendido + 16,
	ultimaventa = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idproducto = 7;

-- Factura al cliente con ID 1 y producto con ID 9
INSERT INTO factura
(idcliente, numerofactura, montobruto, descuento, impuesto, montoneto, fechaventa, anulada)
VALUES
(1, 'F0007', 4, 0, 0.8, 4.8, SYSDATE, '0');

INSERT INTO LINEAFACTURA
(cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado, idfactura, idproducto)
VALUES
(2, 4, 0, 0.8, 20, 4.8, 7, 9);

UPDATE clientes SET
	nrocompras = nrocompras + 1,
	montocompras = montocompras + 4.8,
	ultimacompra = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idcliente = 1;

UPDATE producto SET
	unidadesvendidas = unidadesvendidas + 2,
	montovendido = montovendido + 4,
	ultimaventa = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idproducto = 9;

-- Factura al cliente con ID 2 y producto con ID 11
INSERT INTO factura
(idcliente, numerofactura, montobruto, descuento, impuesto, montoneto, fechaventa, anulada)
VALUES
(2, 'F0008', 6, 0, 1.2, 7.2, SYSDATE, '0');

INSERT INTO LINEAFACTURA
(cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado, idfactura, idproducto)
VALUES
(1, 6, 0, 1.2, 20, 7.2, 8, 11);

UPDATE clientes SET
	nrocompras = nrocompras + 1,
	montocompras = montocompras + 7.2,
	ultimacompra = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idcliente = 2;

UPDATE producto SET
	unidadesvendidas = unidadesvendidas + 1,
	montovendido = montovendido + 6,
	ultimaventa = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idproducto = 11;