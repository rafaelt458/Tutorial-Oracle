ALTER TABLE CLIENTES 
ADD CONSTRAINT UN_DOCUMENTO_CLIENTE UNIQUE (TIPODOCUMENTO, NRODOCUMENTO);

ALTER TABLE CLIENTES 
ADD CONSTRAINT CK_TIPO_DOCUMENTO CHECK (TIPODOCUMENTO IN ('1', '2', '3'));

ALTER TABLE clientes ADD CONSTRAINT ck_nro_compras CHECK ( nrocompras >= 0 );

ALTER TABLE clientes ADD CONSTRAINT ck_monto_compras CHECK ( montocompras >= 0 );

ALTER TABLE clientes ADD CONSTRAINT un_telefono UNIQUE ( telefono );

ALTER TABLE factura
    ADD CONSTRAINT ck_anulada CHECK ( anulada IN ( '0', '1' ) );

ALTER TABLE factura ADD CONSTRAINT un_nro_factura UNIQUE ( numerofactura );

ALTER TABLE producto ADD CONSTRAINT ck_inventario CHECK ( inventario >= 0 );

ALTER TABLE producto ADD CONSTRAINT ck_precio_compra CHECK ( preciocompra >= 0 );

ALTER TABLE producto ADD CONSTRAINT ck_precio_venta CHECK ( precioventa >= 0 );

ALTER TABLE producto ADD CONSTRAINT ck_tasa_impuesto CHECK ( tasaimpuesto >= 0 );

ALTER TABLE producto ADD CONSTRAINT ck_descuento CHECK ( descuento >= 0 );

ALTER TABLE producto ADD CONSTRAINT ck_unidades_vendidas CHECK ( unidadesvendidas >= 0 );

ALTER TABLE producto ADD CONSTRAINT ck_monto_vendido CHECK ( montovendido >= 0 );