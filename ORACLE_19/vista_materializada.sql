select * from user_sys_privs;

create MATERIALIZED VIEW ultimascompras
 BUILD DEFERRED
 REFRESH COMPLETE
AS
select c.idcliente,
		c.nombre,
		c.telefono ,
		c.nrocompras ,
		f.numerofactura ,
		f.montoneto,
		f.fechaventa 
		from clientes c inner join factura f on
			c.idcliente = f.idcliente 
		where f.anulada = '0';

BEGIN
  DBMS_MVIEW.REFRESH('ultimascompras', 'C');
END;

select c.idcliente,
		c.nombre,
		c.telefono ,
		c.nrocompras ,
		f.numerofactura ,
		f.montoneto,
		f.fechaventa 
		from clientes c inner join factura f on
			c.idcliente = f.idcliente 
		where f.anulada = '0';
		
-- Factura al cliente con ID 14 y producto con ID 12
INSERT INTO factura
(idcliente, numerofactura, montobruto, descuento, impuesto, montoneto, fechaventa, anulada)
VALUES
(14, 'F0014', 5, 0, 1, 6, SYSDATE, '0');

INSERT INTO LINEAFACTURA
(cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado, idfactura, idproducto)
VALUES
(1, 5, 0, 1, 20, 6, 17, 12);

UPDATE clientes SET
	nrocompras = nrocompras + 1,
	montocompras = montocompras + 6,
	ultimacompra = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idcliente = 14;

UPDATE producto SET
	unidadesvendidas = unidadesvendidas + 1,
	montovendido = montovendido + 5,
	inventario = inventario - 1, 
	ultimaventa = SYSDATE,
	ultimamodificacion = SYSDATE 
WHERE idproducto = 12;


-- Se hacen las consultas después de haber agregado nuevos datos

select c.idcliente,
		c.nombre,
		c.telefono ,
		c.nrocompras ,
		f.numerofactura ,
		f.montoneto,
		f.fechaventa 
		from clientes c inner join factura f on
			c.idcliente = f.idcliente 
		where f.anulada = '0';
		
SELECT *
		FROM ultimascompras;