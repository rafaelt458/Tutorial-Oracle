-- Clientes que han hecho alguna compra

select	*
	from 	clientes c
	where 	exists (
		select 	*
			from 	factura f 
			where 	f.idcliente = c.idcliente
	);
	
select *
	from 	clientes c
	where 	nrocompras > 0;

select	DISTINCT(c.IDCLIENTE), c.*
	from 	clientes c inner join factura f on
		c.idcliente = f.idcliente ;
		

-- Clientes que no han hecho ninguna compra

select	*
	from 	clientes c 
	where 	not exists (
		select 	*
			from 	factura f 
			where 	f.idcliente = c.idcliente
	);
	
select *
	from 	clientes c
	where 	nrocompras = 0;
	
select	c.*, f.*
	from 	clientes c left join factura f on
		c.idcliente = f.idcliente
	where f.IDFACTURA is null;

-- Productos que se han vendido alguna vez
select 	*
	from 	producto p 
	where exists	(
		select 	*
			from 	lineafactura l 
			where 	l.idproducto = p.idproducto 
	);

-- Productos que no se han vendido ninguna vez
select 	*
	from 	producto p 
	where not exists	(
		select 	*
			from 	lineafactura l 
			where 	l.idproducto = p.idproducto 
	);