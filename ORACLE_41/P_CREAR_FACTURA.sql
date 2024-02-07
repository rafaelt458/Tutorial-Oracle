CREATE OR REPLACE PROCEDURE P_CREAR_FACTURA (
    p_numero_factura IN VARCHAR2,
    p_cliente_id IN NUMBER,
    p_sesion IN VARCHAR2,
	p_error_number OUT NUMBER
) AS

    v_num_clientes NUMBER;
    v_num_facturas NUMBER;
    exception_cliente_inexistente	EXCEPTION;
    exception_inventario_insuficiente EXCEPTION;
    exception_factura_existente	EXCEPTION;
    v_precionormal NUMBER;
    v_idfactura NUMBER;
    v_impuesto NUMBER;
    v_descuento NUMBER;
    v_monto_bruto NUMBER;
    v_impuesto_total NUMBER;
    v_descuento_total NUMBER;
    v_monto_neto NUMBER;
    CURSOR cur_carrito(par_cliente varchar) IS
		SELECT	C.idproducto, C.cantidad, P.inventario, P.precioventa, P.tasaimpuesto, P.descuento
			FROM	CARRITO C INNER JOIN PRODUCTO P ON
                        c.idproducto = p.idproducto
			WHERE 	sesion = par_cliente;

BEGIN
    p_error_number := 0;
    v_monto_bruto := 0;
    v_impuesto_total := 0;
    v_descuento_total := 0;
    v_monto_neto := 0;
    
   -- Verificar la existencia del cliente
    SELECT COUNT(*) INTO v_num_clientes
		FROM CLIENTES
		WHERE idcliente = p_cliente_id;
	
	IF (v_num_clientes = 0) THEN
		RAISE exception_cliente_inexistente;
	END IF;
    
    SELECT COUNT(*) INTO v_num_facturas
		FROM FACTURA
		WHERE numerofactura = p_numero_factura;
	
	IF (v_num_facturas > 0) THEN
		RAISE exception_factura_existente;
	END IF;
    
    INSERT INTO FACTURA (
        IDCLIENTE, NUMEROFACTURA, MONTOBRUTO, DESCUENTO, IMPUESTO, MONTONETO, FECHAVENTA, ANULADA
    ) VALUES (
        p_cliente_id, p_numero_factura, 0, 0, 0, 0, SYSDATE, '0'
    ) RETURNING IDFACTURA INTO v_idfactura;
    
    FOR reg IN cur_carrito(p_sesion) LOOP
        IF reg.inventario < reg.cantidad THEN
            RAISE exception_inventario_insuficiente;
        END IF;
        
        v_precionormal := reg.cantidad * reg.precioventa;
        v_impuesto := v_precionormal * reg.tasaimpuesto / 100;
        v_descuento := v_precionormal * reg.descuento / 100;
        
        INSERT INTO LINEAFACTURA (
            CANTIDAD, PRECIONORMAL, DESCUENTO, IMPUESTO, TASAIMPUESTO, PRECIOAPLICADO, IDFACTURA, IDPRODUCTO
        ) VALUES(
            reg.cantidad,
            v_precionormal,
            v_impuesto,
            v_descuento,
            reg.tasaimpuesto,
            v_precionormal + v_impuesto - v_descuento,
            v_idfactura,
            reg.idproducto
        );
        
        v_monto_bruto := v_monto_bruto + v_precionormal;
        v_impuesto_total := v_impuesto_total + v_impuesto;
        v_descuento_total := v_descuento_total + v_descuento;
        v_monto_neto := v_monto_neto + v_precionormal + v_impuesto - v_descuento;
        
        UPDATE PRODUCTO SET
            inventario = inventario - reg.cantidad,
            unidadesvendidas = unidadesvendidas + reg.cantidad,
            montovendido = montovendido + v_precionormal,
            ultimaventa = SYSDATE,
            ultimamodificacion = SYSDATE 
        WHERE   idproducto = reg.idproducto;
        
    END LOOP;
    
    UPDATE FACTURA SET
        montobruto = v_monto_bruto,
        descuento = v_descuento_total,
        impuesto = v_impuesto_total,
        montoneto = v_monto_neto
    WHERE   idfactura = v_idfactura;
    
    UPDATE CLIENTES SET
        nrocompras = nrocompras + 1,
        montocompras = montocompras + v_monto_neto,
        ultimacompra = SYSDATE,
        ultimamodificacion = SYSDATE 
    WHERE idcliente = p_cliente_id;
   
    DELETE
    	FROM	CARRITO
    	WHERE	sesion = p_sesion;
    
    COMMIT;
	registrar_log(SQLCODE, 'Se ha creado la factura exitosamente');

	EXCEPTION
		WHEN exception_cliente_inexistente THEN
			registrar_log(4903, 'Se ha intentado crear una factura a un cliente inexistente');
			ROLLBACK;
			p_error_number := 4903;
		WHEN exception_inventario_insuficiente THEN
			registrar_log(4906, 'Inventario insuficiente para un producto en el carrito');
			ROLLBACK;
			p_error_number := 4906;
        WHEN exception_factura_existente THEN
			registrar_log(4908, 'Se ha intentado crear una factura con número ya usado');
			ROLLBACK;
			p_error_number := 4908;
		WHEN OTHERS THEN
			registrar_log(SQLCODE, SQLERRM);
			ROLLBACK;
			p_error_number := SQLCODE;

END P_CREAR_FACTURA;



DECLARE
	p_numero_factura	VARCHAR2(20);
    p_cliente_id		NUMBER;
	var_sesion			VARCHAR2(10);
	var_numero_error	NUMBER;

BEGIN
	p_numero_factura := 'F0025';
    p_cliente_id := 6;
	var_sesion := 'S000000003';
	P_CREAR_FACTURA(p_numero_factura, p_cliente_id, var_sesion, var_numero_error);
	IF (var_numero_error <> 0) THEN
		dbms_output.put_line('Se ha presentado el error ' || var_numero_error);
	ELSE
		dbms_output.put_line('Se ha creado la factura número ' || p_numero_factura);
	END IF;
END;