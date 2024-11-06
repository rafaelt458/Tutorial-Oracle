DECLARE
    json_str CLOB := '';
    linea VARCHAR2(1024);
    archivo UTL_FILE.FILE_TYPE;
    terminado BOOLEAN := FALSE;
    contador NUMBER;
    
    CURSOR cur_factura (registro CLOB) IS
        select numero_factura, idcliente, lineasFactura
            from JSON_TABLE (registro, '$[*]' 
            COLUMNS (   
                numero_factura  VARCHAR2(20)    PATH '$.numeroFactura',
                idcliente       NUMBER          PATH '$.idCliente',
                lineasFactura   format json     PATH '$.lineasFactura')
           );
           
    CURSOR cur_linea (registro CLOB) IS
        select idProducto, cantidad
                from JSON_TABLE (registro, '$[*]' 
                COLUMNS (   
                        idProducto NUMBER   PATH '$.idProducto',
                        Cantidad   NUMBER   PATH '$.Cantidad') 
                );

BEGIN

    dbms_output.put_line('Iniciando programa');
    
    dbms_output.put_line('Abriendo el archivo factura.json');
    archivo := UTL_FILE.FOPEN('RUTA_JSON', 'factura.json', 'r');
    
    dbms_output.put_line('Leyendo el contenido del archivo factura.json');
    LOOP
        BEGIN
            UTL_FILE.GET_LINE(archivo, linea);
            json_str := json_str || TRIM(linea);
            
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    terminado := TRUE;
        END;
        
        EXIT WHEN terminado;
    END LOOP;
    
    UTL_FILE.FCLOSE(archivo);
    dbms_output.put_line('Contenido del fichero: ' || json_Str);
    
    -- json_str := '{"numeroFactura": "F0026", "idCliente": 17, "lineasFactura" :[{"idProducto": 1, "Cantidad": 3},  {"idProducto": 2, "Cantidad": 2}, {"idProducto": 3 , "Cantidad": 1}]}';
    
    dbms_output.put_line('Procesando factura');
    FOR reg IN cur_factura(json_str) LOOP
        dbms_output.put_line('Numero de factura: ' || reg.numero_factura);
        dbms_output.put_line('Identificador del cliente: ' || reg.idcliente);
        dbms_output.put_line('Lineas de factura: ' || reg.lineasFactura);
        
        contador := 0;
        dbms_output.put_line('Procesando las lineas de factura');        
        FOR linea IN cur_linea(reg.lineasFactura) LOOP
            contador := contador + 1;
            dbms_output.put_line('Procesando linea: ' || contador);        
            dbms_output.put_line('Identificador del producto: ' || linea.idProducto);
            dbms_output.put_line('Cantidad comprada: ' || linea.Cantidad);
        END LOOP;
    END LOOP;

END;