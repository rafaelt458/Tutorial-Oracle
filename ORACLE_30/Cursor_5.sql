DECLARE
	CURSOR cursor_facturas is
		SELECT	*
			FROM PRODUCTO
	FOR UPDATE;
	
	reg		PRODUCTO%ROWTYPE;

BEGIN
	
	OPEN cursor_facturas;

	LOOP
		FETCH cursor_facturas INTO reg;
		EXIT WHEN cursor_facturas%NOTFOUND;
	
		UPDATE PRODUCTO SET
			PRECIOVENTA = PRECIOVENTA * 1.1,
			ULTIMAMODIFICACION = SYSDATE
		WHERE CURRENT OF cursor_facturas;
	
		DBMS_OUTPUT.PUT_LINE('Actualizando el producto con codigo ' || reg.idproducto || ' con nombre ' || reg.descripcioncorta);
	END LOOP;
	

	CLOSE cursor_facturas;

	EXCEPTION
		WHEN OTHERS THEN
			dbms_output.put_line('Ha ocurrido un error desconocido manipulando el cursor ' || SQLCODE);
END;