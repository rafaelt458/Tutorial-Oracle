declare
    json_clob CLOB;
    linea VARCHAR2(1024);
    archivo UTL_FILE.FILE_TYPE;
    terminado BOOLEAN := FALSE;
    longitud NUMBER;
    idclob NUMBER := 1;
    clob_factura CLOB;

begin

    dbms_output.put_line('Iniciando programa');
    
    dbms_output.put_line('Abriendo el archivo factura2.json');
    archivo := UTL_FILE.FOPEN('RUTA_JSON', 'factura2.json', 'r');
    
    dbms_output.put_line('Leyendo el contenido del archivo factura2.json');
    DBMS_LOB.CREATETEMPORARY(json_clob, TRUE);
    LOOP
        BEGIN
            UTL_FILE.GET_LINE(archivo, linea);
            DBMS_LOB.writeappend(json_clob, length(linea), linea);
            dbms_output.put_line('Se ha agregado una línea del JSON');
            
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    terminado := TRUE;
        END;
        
        EXIT WHEN terminado;
    END LOOP;
    
    UTL_FILE.FCLOSE(archivo);
    
    longitud := DBMS_LOB.GETLENGTH(json_clob);
    dbms_output.put_line('Tamaño del lob: ' || longitud);
    
    insert into facturas_backup
        (id, json_factura)
    values
        (idclob, json_clob);
    commit;
    DBMS_LOB.FREETEMPORARY(json_clob);
    
    select json_factura into clob_factura
        from facturas_backup
        where id = idclob;
    
    dbms_output.put_line('Contenido del clob: ' || clob_factura);
    
end;