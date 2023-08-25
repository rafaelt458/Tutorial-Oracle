CREATE TABLE ComprasCliente (
	idcliente NUMBER NOT NULL,
	nombre VARCHAR2(60 CHAR) NOT NULL,
	telefono VARCHAR2(25 CHAR),
	nrocompras NUMBER NOT NULL,
	numerofactura VARCHAR2(20 CHAR) NOT NULL,
	montoneto NUMBER(10, 2) NOT NULL,
    fechaventa DATE NOT NULL
);
ALTER TABLE ComprasCliente ADD CONSTRAINT ComprasCliente_PK PRIMARY KEY(idcliente,numerofactura);