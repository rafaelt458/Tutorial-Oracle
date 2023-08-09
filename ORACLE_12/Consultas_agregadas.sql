select MAX(montoneto)
	from factura;

select MIN(montoneto)
	from factura;

select	MAX(montoneto) AS maximo,
		MIN(montoneto) AS minimo
	from factura;

select	SUM(montobruto) as MontoBruto,
		sum(descuento) as Descuento,
		sum(impuesto) as Impuesto,
		SUM(montoneto) as MontoNeto
	from factura;

select count(*)
	from clientes
	where tipodocumento = 1;

select	SUM(unidadesvendidas),
		AVG(unidadesvendidas)
	from producto
	where unidadesvendidas > 0;
	
select	direccion,
		count(*)
		from clientes
		group by direccion
		order by 2 DESC;
		
select	fechaventa,
		count(*),
		sum(montoneto)
		from factura
		group by fechaventa;
	
select	TRUNC(fechaventa),
		count(*),
		sum(montoneto)
		from factura
		group by TRUNC(fechaventa);

select	TRUNC(fechaventa),
		count(*),
		sum(montoneto)
		from factura
		group by TRUNC(fechaventa)
		having sum(montoneto) > 10;

select	TRUNC(fechaventa),
		count(*),
		sum(montoneto)
		from factura
		group by TRUNC(fechaventa)
		having sum(montoneto) <= 7;
	
select	TRUNC(fechaventa),
		count(*),
		sum(montoneto)
		from factura
		group by TRUNC(fechaventa)
		having count(*) > 1;