CREATE TABLE carrito (
    sesion     VARCHAR2(10 CHAR) NOT NULL,
    idproducto NUMBER NOT NULL,
    cantidad   NUMBER NOT NULL
);

ALTER TABLE carrito ADD CONSTRAINT carrito_pk PRIMARY KEY ( sesion,
                                                            idproducto );