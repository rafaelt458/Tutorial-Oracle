DECLARE
	nro_factura number;
	id_cliente	number;
	id_producto	number;
	
BEGIN
	
	id_cliente := 16;
	id_producto := 12;
	nro_factura := FACTURA_NUMERO_FACTURA_SEQ.NEXTVAL;

	INSERT INTO factura
	(idcliente, numerofactura, montobruto, descuento, impuesto, montoneto, fechaventa, anulada)
	VALUES
	(id_cliente, 'F' || LPAD(nro_factura, 4, '0'), 5, 0, 1, 6, SYSDATE, '0');

	INSERT INTO LINEAFACTURA
	(cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado, idfactura, idproducto)
	VALUES
	(1, 5, 0, 1, 20, 6, 23, id_producto);

	UPDATE clientes SET
		nrocompras = nrocompras + 1,
		montocompras = montocompras + 6,
		ultimacompra = SYSDATE,
		ultimamodificacion = SYSDATE 
	WHERE idcliente = id_cliente;

	UPDATE producto SET
		unidadesvendidas = unidadesvendidas + 1,
		montovendido = montovendido + 5,
		inventario = inventario - 1, 
		ultimaventa = SYSDATE,
		ultimamodificacion = SYSDATE 
	WHERE idproducto = id_producto;
	
END;