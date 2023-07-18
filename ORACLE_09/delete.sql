DELETE
	FROM LINEAFACTURA
	WHERE IDFACTURA = 1;

DELETE 
	FROM FACTURA
	WHERE IDFACTURA = 1;
	
UPDATE clientes SET
	nrocompras = nrocompras - 1,
	montocompras = montocompras - 6,
	ultimamodificacion = SYSDATE 
WHERE idcliente = 1;

UPDATE producto SET
	unidadesvendidas = unidadesvendidas - 1,
	montovendido = montovendido - 2,
	ultimamodificacion = SYSDATE 
WHERE idproducto = 1;

UPDATE producto SET
	unidadesvendidas = unidadesvendidas - 1,
	montovendido = montovendido - 3,
	ultimamodificacion = SYSDATE 
WHERE idproducto = 2;