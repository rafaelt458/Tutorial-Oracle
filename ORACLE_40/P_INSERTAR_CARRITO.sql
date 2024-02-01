CREATE OR REPLACE PROCEDURE P_INSERTAR_CARRITO (
	p_sesion		VARCHAR2,
    p_producto_id	NUMBER,
    p_cantidad		NUMBER,
    p_error_number OUT NUMBER
) AS

	v_resultado NUMBER;
    v_n_registros NUMBER;
	exception_producto_inexistente EXCEPTION;
	exception_inventario_insuficiente EXCEPTION;

BEGIN
	p_error_number := 0;

	v_resultado := F_VALIDA_PRODUCTO(p_sesion, p_producto_id, p_cantidad);
	IF v_resultado <> 1 THEN
		IF v_resultado = -1 THEN
			RAISE exception_producto_inexistente;
		ELSE
			RAISE exception_inventario_insuficiente;
		END IF;
	END IF;

    SELECT  COUNT(*) INTO v_n_registros
        FROM    carrito
        WHERE   sesion = p_sesion
        AND     idproducto = p_producto_id;

	IF v_n_registros > 0 THEN

		UPDATE carrito SET 
			cantidad = cantidad + p_cantidad
		WHERE 	sesion = p_sesion
				AND idproducto = p_producto_id;
	
	ELSE
	
		INSERT INTO CARRITO
			(SESION, IDPRODUCTO, CANTIDAD)
		VALUES
			(p_sesion, p_producto_id, p_cantidad);
	
	END IF;

	COMMIT;

	EXCEPTION
		WHEN exception_producto_inexistente THEN
			registrar_log(4905, 'Se ha intentado agregar un producto inexistente al carrito');
			ROLLBACK;
			p_error_number := 4905;
		WHEN exception_inventario_insuficiente THEN
			registrar_log(4906, 'Inventario insuficiente para el producto agregado al carrito');
			ROLLBACK;
			p_error_number := 4906;
		WHEN OTHERS THEN
			registrar_log(SQLCODE, SQLERRM);
			ROLLBACK;
			p_error_number := SQLCODE;
END P_INSERTAR_CARRITO;



DECLARE
	var_sesion			VARCHAR2(10);
	var_producto_id		NUMBER;
	var_cantidad		NUMBER;
	var_numero_error	NUMBER;

BEGIN
	var_sesion := 'S000000001';
	var_producto_id := 10;
	var_cantidad := 1;
	P_INSERTAR_CARRITO(var_sesion, var_producto_id, var_cantidad, var_numero_error);
	IF (var_numero_error <> 0) THEN
		dbms_output.put_line('Se ha presentado el error ' || var_numero_error);
	ELSE
		dbms_output.put_line('Se ha insertado el producto con código ' || var_producto_id);
	END IF;
END;