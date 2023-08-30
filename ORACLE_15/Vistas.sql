create view vistacompras as
	select c.idcliente,
		c.nombre,
		c.telefono,
		c.direccion,
		c.nrocompras,
		c.ultimacompra,
		f.numerofactura,
		f.montoneto,
		f.impuesto,
		f.fechaventa 
		from CLIENTES c inner join factura f on
			c.idcliente = f.idcliente 
		where f.anulada = '0';


select *
	from vistacompras;
	
select *
	from vistacompras
	where montoneto > 5;

select *
	from vistacompras
	where nombre = 'Jorge';

select *
	from vistacompras
	where numerofactura = 'F0005'
		or  numerofactura = 'F0008';
		
drop view vistacompras;