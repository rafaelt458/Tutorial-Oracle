SELECT '{"numeroFactura": "F0026", "idCliente": 17,"lineasFactura" :[{"idProducto": 1, "Cantidad": 3},{"idProducto": 2, "Cantidad": 2},{"idProducto": 3 , "Cantidad": 1}]}' FROM DUAL;
    
select Factura.*
    from JSON_TABLE ((SELECT '{"numeroFactura": "F0026", "idCliente": 17,"lineasFactura" :[{"idProducto": 1, "Cantidad": 3},{"idProducto": 2, "Cantidad": 2},{"idProducto": 3 , "Cantidad": 1}]}' FROM DUAL), '$[*]' 
            COLUMNS (   
                        numero_factura  VARCHAR2(20)    PATH '$.numeroFactura',
                        idcliente       NUMBER          PATH '$.idCliente',
                        lineasFactura   format json     PATH '$.lineasFactura')
           ) AS Factura;


select Lineas.*
    from JSON_TABLE ((SELECT '{"numeroFactura": "F0026", "idCliente": 17,"lineasFactura" :[{"idProducto": 1, "Cantidad": 3},{"idProducto": 2, "Cantidad": 2},{"idProducto": 3 , "Cantidad": 1}]}' FROM DUAL), '$.lineasFactura[*]' 
            COLUMNS (   
                        idProducto NUMBER   PATH '$.idProducto',
                        Cantidad   NUMBER   PATH '$.Cantidad') 
           )AS Lineas;