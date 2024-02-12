create or replace PACKAGE BODY FACTURACION_PKG IS
    FUNCTION F_VALIDA_PRODUCTO (p_sesion IN	VARCHAR2, p_producto_id IN NUMBER, p_cantidad IN NUMBER) RETURN NUMBER;
    
    -- ***************************************************
    -- Implementación del procedimiento P_INSERTAR_CARRITO
    -- ***************************************************
    PROCEDURE P_INSERTAR_CARRITO (
        p_sesion IN VARCHAR2,
        p_producto_id IN NUMBER,
        p_cantidad IN NUMBER,
        p_error_number OUT NUMBER
    ) AS
    
        v_resultado NUMBER;
        v_n_registros NUMBER;
        exception_producto_inexistente EXCEPTION;
    
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
        registrar_log(SQLCODE, 'Se ha agregado el producto al carrito exitosamente');
    
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
    
    -- *****************************************************
    -- Implementación del procedimiento P_QUITAR_DEL_CARRITO
    -- *****************************************************
    PROCEDURE P_QUITAR_DEL_CARRITO (
        p_sesion IN VARCHAR2,
        p_producto_id IN NUMBER,
        p_cantidad IN NUMBER,
        p_error_number OUT NUMBER
    ) AS
    
        item_carrito carrito%rowtype;
        resto NUMBER;
    
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
       registrar_log(SQLCODE, 'Se ha quitado la cantidad indicada del producto del carrito');
    
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
    
    -- ************************************************
    -- Implementación del procedimiento P_CREAR_FACTURA
    -- ************************************************
    PROCEDURE P_CREAR_FACTURA (
        p_numero_factura IN VARCHAR2,
        p_cliente_id IN NUMBER,
        p_sesion IN VARCHAR2,
        p_error_number OUT NUMBER
    ) AS
    
        v_num_clientes NUMBER;
        v_num_facturas NUMBER;
        exception_cliente_inexistente	EXCEPTION;
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
    
    -- *************************************************
    -- Implementación del procedimiento P_ANULAR_FACTURA
    -- *************************************************
    PROCEDURE P_ANULAR_FACTURA (
        p_factura_id IN NUMBER,
        p_error_number OUT NUMBER
    ) AS
    
        v_num_facturas NUMBER;
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
    
    -- **********************************************
    -- Implementación de la función F_VALIDA_PRODUCTO
    -- **********************************************
    FUNCTION F_VALIDA_PRODUCTO (
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

END FACTURACION_PKG; 