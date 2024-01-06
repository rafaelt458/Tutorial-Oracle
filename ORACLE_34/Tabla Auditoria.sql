CREATE TABLE auditoria (
    id        NUMBER NOT NULL,
    usuario   VARCHAR2(50 CHAR) NOT NULL,
    tabla     VARCHAR2(50 CHAR) NOT NULL,
    operacion VARCHAR2(20 CHAR) NOT NULL,
    codigo    NUMBER NOT NULL,
    fecha     DATE NOT NULL
);

ALTER TABLE auditoria ADD CONSTRAINT auditoria_pk PRIMARY KEY ( id );

CREATE SEQUENCE auditoria_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER auditoria_id_trg BEFORE
    INSERT ON auditoria
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := auditoria_id_seq.nextval;
END;