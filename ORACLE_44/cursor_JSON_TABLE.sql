DECLARE
    json_str VARCHAR2(1024);
    contador NUMBER;
    
    CURSOR cur_factura (registro VARCHAR2) IS
        select numero_factura, idcliente, lineasFactura
            from JSON_TABLE (registro, '$[*]' 
            COLUMNS (   
                numero_factura  VARCHAR2(20)    PATH '$.numeroFactura',
                idcliente       NUMBER          PATH '$.idCliente',
                lineasFactura   format json     PATH '$.lineasFactura')
           );
           
    CURSOR cur_linea (registro VARCHAR2) IS
        select idProducto, cantidad
                from JSON_TABLE (registro, '$[*]' 
                COLUMNS (   
                        idProducto NUMBER   PATH '$.idProducto',
                        Cantidad   NUMBER   PATH '$.Cantidad') 
                );

BEGIN

    dbms_output.put_line('Iniciando programa');
    
    json_str := '{"numeroFactura": "F0026", "idCliente": 17, "lineasFactura" :[{"idProducto": 1, "Cantidad": 3},  {"idProducto": 2, "Cantidad": 2}, {"idProducto": 3 , "Cantidad": 1}]}';
    
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