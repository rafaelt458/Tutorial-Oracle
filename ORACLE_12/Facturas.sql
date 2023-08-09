-- Factura al cliente con ID 1 y producto con ID 1
INSERT INTO factura
(idcliente, numerofactura, montobruto, descuento, impuesto, montoneto, fechaventa, anulada)
VALUES
(1, 'F0009', 4, 0, 0.8, 4.8, SYSDATE, '0');

INSERT INTO LINEAFACTURA
(cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado, idfactura, idproducto)
VALUES
(2, 4, 0, 0.8, 20, 4.8, 11, 1);

UPDATE clientes SET
	nrocompras = nrocompras + 1,
	montocompras = montocompras + 4.8,
	ultimacompra = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idcliente = 1;

UPDATE producto SET
	unidadesvendidas = unidadesvendidas + 2,
	montovendido = montovendido + 4,
	inventario = inventario - 2, 
	ultimaventa = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idproducto = 1;

-- Factura al cliente con ID 8 y producto con ID 2
INSERT INTO factura
(idcliente, numerofactura, montobruto, descuento, impuesto, montoneto, fechaventa, anulada)
VALUES
(8, 'F0010', 6, 0, 1.2, 7.2, SYSDATE, '0');

INSERT INTO LINEAFACTURA
(cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado, idfactura, idproducto)
VALUES
(2, 6, 0, 1.2, 20, 7.2, 12, 2);

UPDATE clientes SET
	nrocompras = nrocompras + 1,
	montocompras = montocompras + 7.2,
	ultimacompra = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idcliente = 8;

UPDATE producto SET
	unidadesvendidas = unidadesvendidas + 2,
	montovendido = montovendido + 6,
	inventario = inventario - 2,
	ultimaventa = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idproducto = 2;

-- Factura al cliente con ID 10 y producto con ID 9
INSERT INTO factura
(idcliente, numerofactura, montobruto, descuento, impuesto, montoneto, fechaventa, anulada)
VALUES
(10, 'F0011', 4, 0, 0.8, 4.8, SYSDATE, '0');

INSERT INTO LINEAFACTURA
(cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado, idfactura, idproducto)
VALUES
(2, 4, 0, 0.8, 20, 4.8, 13, 9);

UPDATE clientes SET
	nrocompras = nrocompras + 1,
	montocompras = montocompras + 4.8,
	ultimacompra = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idcliente = 10;

UPDATE producto SET
	unidadesvendidas = unidadesvendidas + 2,
	montovendido = montovendido + 4,
	inventario = inventario - 2, 
	ultimaventa = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idproducto = 9;

-- Factura al cliente con ID 12 y producto con ID 10
INSERT INTO factura
(idcliente, numerofactura, montobruto, descuento, impuesto, montoneto, fechaventa, anulada)
VALUES
(12, 'F0012', 4, 0, 0.8, 4.8, SYSDATE, '0');

INSERT INTO LINEAFACTURA
(cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado, idfactura, idproducto)
VALUES
(2, 4, 0, 0.8, 20, 4.8, 14, 10);

UPDATE clientes SET
	nrocompras = nrocompras + 1,
	montocompras = montocompras + 4.8,
	ultimacompra = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idcliente = 12;

UPDATE producto SET
	unidadesvendidas = unidadesvendidas + 2,
	montovendido = montovendido + 4,
	inventario = inventario - 2, 
	ultimaventa = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idproducto = 10;

-- Factura al cliente con ID 13 y producto con ID 11
INSERT INTO factura
(idcliente, numerofactura, montobruto, descuento, impuesto, montoneto, fechaventa, anulada)
VALUES
(13, 'F0013', 6, 0, 1.2, 7.2, SYSDATE, '0');

INSERT INTO LINEAFACTURA
(cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado, idfactura, idproducto)
VALUES
(2, 6, 0, 1.2, 20, 7.2, 16, 11);

UPDATE clientes SET
	nrocompras = nrocompras + 1,
	montocompras = montocompras + 7.2,
	ultimacompra = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idcliente = 13;

UPDATE producto SET
	unidadesvendidas = unidadesvendidas + 1,
	montovendido = montovendido + 6,
	inventario = inventario - 1, 
	ultimaventa = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idproducto = 11;