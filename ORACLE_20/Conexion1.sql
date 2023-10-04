BEGIN

select *
	from factura;

-- Factura al cliente con ID 14 y producto con ID 12
INSERT INTO factura
(idcliente, numerofactura, montobruto, descuento, impuesto, montoneto, fechaventa, anulada)
VALUES
(14, 'F0016', 5, 0, 1, 6, SYSDATE, '0');

select *
	from factura;

select *
	from lineafactura;

INSERT INTO LINEAFACTURA
(cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado, idfactura, idproducto)
VALUES
(1, 5, 0, 1, 20, 6, 23, 12);

select *
	from lineafactura;

select *
	from clientes
	where idcliente = 14;

UPDATE clientes SET
	nrocompras = nrocompras + 1,
	montocompras = montocompras + 6,
	ultimacompra = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idcliente = 14;

select *
	from clientes
	where idcliente = 14;

select *
	from producto
	where idproducto  = 12;

UPDATE producto SET
	unidadesvendidas = unidadesvendidas + 1,
	montovendido = montovendido + 5,
	inventario = inventario - 1, 
	ultimaventa = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idproducto = 12;

select *
	from producto
	where idproducto  = 12;


rollback;

commit;