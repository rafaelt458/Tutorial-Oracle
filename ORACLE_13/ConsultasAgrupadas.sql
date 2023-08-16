select *
	from clientes c, factura f 
	where c.idcliente = f.idcliente ;
	
select	c.idcliente,
		c.nombre,
		c.nrocompras,
		c.montocompras,
		f.idfactura,
		f.numerofactura 
	from clientes c, factura f 
	where c.idcliente = f.idcliente ;

select	c.idcliente,
		c.nombre,
		c.nrocompras,
		c.montocompras,
		f.idfactura,
		f.numerofactura 
	from clientes c
	inner join factura f on c.idcliente = f.idcliente;

select	c.idcliente,
		c.nombre,
		c.nrocompras,
		c.montocompras,
		f.idfactura,
		f.numerofactura 
	from clientes c
	inner join factura f on c.idcliente = f.idcliente
	where c.montocompras >= 10;
	
select	c.idcliente,
		c.nombre,
		c.nrocompras,
		c.montocompras,
		f.idfactura,
		f.numerofactura 
	from clientes c
	left outer join factura f on c.idcliente = f.idcliente;

select 	p.idproducto,
		p.descripcioncorta,
		p.inventario,
		lf.cantidad,
		lf.precioaplicado 
	from lineafactura lf
	right outer join producto p on lf.idproducto = p.idproducto;
	
select	idcliente,
		nombre,
		nrocompras,
		montocompras,
		'consulta 1' as origen
	from clientes
	where direccion = 'Madrid'
union
select	idcliente,
		nombre,
		nrocompras,
		montocompras,
		'consulta 2' as origen
	from clientes
	where direccion = 'Valladolid'
order by nombre;


select	c.idcliente  AS identificador,
		c.nombre,
		c.nrocompras,
		c.montocompras,
		'consulta 1' as origen
	from clientes c
	where c.direccion = 'Madrid'
UNION
select	p.idproducto AS identificador,
		p.DESCRIPCIONCORTA AS nombre,
		p.UNIDADESVENDIDAS AS nrocompras,
		p.MONTOVENDIDO AS montocompras,
		'consulta 2' as origen
	from PRODUCTO p
ORDER BY NOMBRE;