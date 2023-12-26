CREATE TABLE log_comercio (
    idlog         NUMBER NOT NULL,
    codigo_error  NUMBER NOT NULL,
    mensaje_error VARCHAR2(512 CHAR) NOT NULL,
    momento_error DATE DEFAULT sysdate NOT NULL
);

ALTER TABLE log_comercio ADD CONSTRAINT log_comercio_pk PRIMARY KEY ( idlog );

CREATE SEQUENCE log_comercio_idlog_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER log_comercio_idlog_trg BEFORE
    INSERT ON log_comercio
    FOR EACH ROW
    WHEN ( new.idlog IS NULL )
BEGIN
    :new.idlog := log_comercio_idlog_seq.nextval;
END;