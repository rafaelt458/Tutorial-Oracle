select 	*
	from clientes c 
	where c.idcliente in (
		select f.idcliente 
			from factura f 
			where TRUNC(f.fechaventa) = TO_DATE('29-07-2023', 'DD-MM-YYYY')
	);

select 	*
	from 	producto p
	where	p.idproducto in (
		select lf.idproducto 
			from lineafactura lf inner join factura f on
					lf.idfactura = f.idfactura 
			where TRUNC(f.fechaventa) = TO_DATE('29-07-2023', 'DD-MM-YYYY')
	);
	
select 	f.numerofactura,
		f.montoneto,
		(select		c.nombre 
			from	clientes c
			where 	c.idcliente = f.idcliente) as cliente 
	from factura f ;

update CLIENTES set
	ultimacompra = TO_DATE('29-07-2023', 'DD-MM-YYYY')
where idcliente in (
	select f.idcliente 
			from factura f 
			where TRUNC(f.fechaventa) = TO_DATE('29-07-2023', 'DD-MM-YYYY')
);

UPDATE FACTURA SET 
	DESCUENTO = 0,
	ANULADA = 0
WHERE IDCLIENTE = (
	SELECT c.IDCLIENTE
		FROM	CLIENTES c
		WHERE 	c.TELEFONO = '123466'
); 