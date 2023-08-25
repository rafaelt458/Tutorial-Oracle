insert into comprascliente 
(idcliente, nombre, telefono, nrocompras, numerofactura, montoneto, fechaventa)
select	c.idcliente,
		c.nombre,
		c.telefono,
		c.nrocompras,
		f.numerofactura,
		f.montoneto,
		f.fechaventa 
	from clientes c inner join factura f on
			c.idcliente = f.idcliente
	where f.anulada = '0';