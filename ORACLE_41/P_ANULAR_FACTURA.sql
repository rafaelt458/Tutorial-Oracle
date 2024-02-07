CREATE OR REPLACE PROCEDURE P_ANULAR_FACTURA (
    p_factura_id IN NUMBER,
	p_error_number OUT NUMBER
) AS

    v_num_facturas NUMBER;
    exception_factura_inexistente	EXCEPTION;
    v_montocompra NUMBER;
    v_cliente_id NUMBER;
    CURSOR cur_compra IS
		SELECT	L.idproducto, L.cantidad, L.precionormal, L.precioaplicado
			FROM	LINEAFACTURA L
			WHERE 	idfactura = p_factura_id;
    
BEGIN
    p_error_number := 0;
    v_montocompra := 0;
    
    SELECT COUNT(*) INTO v_num_facturas
        FROM    FACTURA
        WHERE   idfactura = p_factura_id;
    
    IF v_num_facturas = 0 THEN
        RAISE exception_factura_inexistente;
    END IF;
    
    UPDATE FACTURA SET
        ANULADA = '1'
    WHERE idfactura = p_factura_id;
    
    FOR reg IN cur_compra LOOP
        UPDATE PRODUCTO SET
            inventario = inventario + reg.cantidad,
            unidadesvendidas = unidadesvendidas - reg.cantidad,
            montovendido = montovendido - reg.precionormal,
            ultimamodificacion = SYSDATE
        WHERE idproducto = reg.idproducto;
        
        v_montocompra := v_montocompra + reg.precioaplicado;
    END LOOP;
    
    SELECT idcliente INTO v_cliente_id
        FROM    FACTURA
        WHERE   idfactura = p_factura_id;
    
    UPDATE CLIENTES SET
        nrocompras = nrocompras - 1,
        montocompras = montocompras - v_montocompra,
        ultimamodificacion = SYSDATE
    WHERE idcliente = v_cliente_id;
   
    COMMIT;
	registrar_log(SQLCODE, 'Se ha anulado la factura exitosamente');
    
    EXCEPTION
		WHEN exception_factura_inexistente THEN
			registrar_log(4909, 'Se ha intentado anular una factura inexistente');
			ROLLBACK;
			p_error_number := 4909;
		WHEN OTHERS THEN
			registrar_log(SQLCODE, SQLERRM);
			ROLLBACK;
			p_error_number := SQLCODE;
    
END P_ANULAR_FACTURA;


DECLARE
    p_factura_id		NUMBER;
	var_numero_error	NUMBER;

BEGIN
    p_factura_id := 31;
	P_ANULAR_FACTURA(p_factura_id, var_numero_error);
	IF (var_numero_error <> 0) THEN
		dbms_output.put_line('Se ha presentado el error ' || var_numero_error);
	ELSE
		dbms_output.put_line('Se ha anulado la factura con id ' ||  p_factura_id);
	END IF;
END;