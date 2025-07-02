select  *
    from    facturas_backup
    where   DBMS_LOB.INSTR(json_factura, 'F0026') > 0;