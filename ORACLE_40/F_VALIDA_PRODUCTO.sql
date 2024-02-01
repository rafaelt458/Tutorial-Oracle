CREATE OR REPLACE FUNCTION F_VALIDA_PRODUCTO (
	p_sesion IN	VARCHAR2,
	p_producto_id IN NUMBER,
	p_cantidad IN NUMBER
) RETURN NUMBER AS

	v_existencia	NUMBER;
	v_en_carrito	NUMBER;
	v_total_comprado NUMBER;
	v_n_registros	NUMBER;
	
-- Función que verifica la existencia de un producto y su inventario
-- Retorna -1 si el producto pasado por parámetro no exite
-- Retorna 0 si no hay inventario para el producto pasado por parámetro
-- Retorna 1 si el producto supera ambas validaciones
BEGIN
	SELECT inventario INTO  v_existencia
		FROM PRODUCTO
		WHERE idproducto = p_producto_id;
	
	SELECT  COUNT(*) INTO v_n_registros
        FROM    carrito
        WHERE   sesion = p_sesion
        AND     idproducto = p_producto_id;

    v_total_comprado := p_cantidad;
	IF v_n_registros > 0 THEN
		SELECT cantidad INTO v_en_carrito
			FROM	 carrito
			WHERE   sesion = p_sesion
        	AND     idproducto = p_producto_id;
        
        v_total_comprado := p_cantidad + v_en_carrito;
	END IF;
	
	IF (v_existencia < v_total_comprado) THEN
		RETURN 0;
	ELSE
		RETURN 1;
	END IF;

	

	EXCEPTION
		WHEN OTHERS THEN
			RETURN -1;	
	
END F_VALIDA_PRODUCTO;


SELECT F_VALIDA_PRODUCTO('S000000001', 10, 10)
	FROM dual;