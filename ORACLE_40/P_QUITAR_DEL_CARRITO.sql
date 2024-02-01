CREATE OR REPLACE PROCEDURE P_QUITAR_DEL_CARRITO (
	p_sesion		VARCHAR2,
    p_producto_id	NUMBER,
    p_cantidad		NUMBER,
    p_error_number OUT NUMBER
) AS

	item_carrito carrito%rowtype;
	resto NUMBER;
	exception_cantidad_invalida	EXCEPTION;

BEGIN
	p_error_number := 0;
	
	SELECT * INTO item_carrito
		FROM	CARRITO
		WHERE   sesion = p_sesion
        AND     idproducto = p_producto_id;
       
    resto := item_carrito.cantidad - p_cantidad;
   	IF resto < 0 THEN
   		RAISE exception_cantidad_invalida;
   	ELSIF resto > 0 THEN

   		UPDATE CARRITO SET 
   			cantidad = cantidad - p_cantidad
   		WHERE   sesion = p_sesion
        AND     idproducto = p_producto_id;

    ELSE
    
    	DELETE
    		FROM CARRITO
    		WHERE   sesion = p_sesion
        	AND     idproducto = p_producto_id;
   	
   	END IF;
   
   COMMIT;
       
    EXCEPTION
		WHEN NO_DATA_FOUND THEN
			registrar_log(SQLCODE, 'Se ha intentado quitar un producto inexistente al carrito');
			ROLLBACK;
			p_error_number := SQLCODE;
		WHEN exception_cantidad_invalida THEN
			registrar_log(4907, 'Se ha intentado quitar una cantidad inválida de un producto del carrito');
			ROLLBACK;
			p_error_number := 4907;
		WHEN OTHERS THEN
			registrar_log(SQLCODE, SQLERRM);
			ROLLBACK;
			p_error_number := SQLCODE;
	
END P_QUITAR_DEL_CARRITO;


DECLARE
	var_sesion			VARCHAR2(10);
	var_producto_id		NUMBER;
	var_cantidad		NUMBER;
	var_numero_error	NUMBER;

BEGIN
	var_sesion := 'S000000001';
	var_producto_id := 10;
	var_cantidad := 1;
	P_QUITAR_DEL_CARRITO(var_sesion, var_producto_id, var_cantidad, var_numero_error);
	IF (var_numero_error <> 0) THEN
		dbms_output.put_line('Se ha presentado el error ' || var_numero_error);
	ELSE
		dbms_output.put_line('Se ha quitado una cantidad del producto con código ' || var_producto_id);
	END IF;
END;
