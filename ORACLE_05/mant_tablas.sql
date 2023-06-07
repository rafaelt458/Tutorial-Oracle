ALTER TABLE LINEAFACTURA 
	RENAME COLUMN factura_idfactura TO idfactura;
	
ALTER TABLE PRODUCTO
	DROP CONSTRAINT producto_lineafactura_fk;
	
alter TABLE producto
	DROP COLUMN lineafactura_idlineafactura;
	
ALTER TABLE LINEAFACTURA
	ADD idproducto NUMBER NOT NULL;
	
ALTER TABLE LINEAFACTURA 
	ADD CONSTRAINT lineafactura_producto_fk FOREIGN KEY (idproducto)
	REFERENCES producto (idproducto);