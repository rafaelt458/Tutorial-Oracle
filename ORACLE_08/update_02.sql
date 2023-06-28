INSERT INTO factura
(idcliente, numerofactura, montobruto, descuento, impuesto, montoneto, fechaventa, anulada)
VALUES
(1, 'F0001', 5, 0, 1, 6, SYSDATE, '0');

INSERT INTO LINEAFACTURA
(cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado, idfactura, idproducto)
VALUES
(1, 2, 0, 0.4, 20, 2.4, 1, 1);

INSERT INTO LINEAFACTURA
(cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado, idfactura, idproducto)
VALUES
(1, 3, 0, 0.6, 20, 3.6, 1, 2);

UPDATE clientes SET
	nrocompras = nrocompras + 1,
	montocompras = montocompras + 6,
	ultimacompra = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idcliente = 1;

UPDATE producto SET
	unidadesvendidas = unidadesvendidas + 1,
	montovendido = montovendido + 2,
	ultimaventa = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idproducto = 1;

UPDATE producto SET
	unidadesvendidas = unidadesvendidas + 1,
	montovendido = montovendido + 3,
	ultimaventa = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idproducto = 2;