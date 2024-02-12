create or replace PACKAGE FACTURACION_PKG IS

    exception_inventario_insuficiente EXCEPTION;
    exception_cantidad_invalida	EXCEPTION;
    exception_factura_existente	EXCEPTION;
    exception_factura_inexistente	EXCEPTION;

    PROCEDURE P_INSERTAR_CARRITO (p_sesion IN VARCHAR2, p_producto_id IN NUMBER, p_cantidad IN NUMBER, p_error_number OUT NUMBER);

    PROCEDURE P_QUITAR_DEL_CARRITO (p_sesion IN VARCHAR2, p_producto_id IN NUMBER, p_cantidad IN NUMBER, p_error_number OUT NUMBER);

    PROCEDURE P_CREAR_FACTURA (p_numero_factura IN VARCHAR2, p_cliente_id IN NUMBER, p_sesion IN VARCHAR2, p_error_number OUT NUMBER);

    PROCEDURE P_ANULAR_FACTURA (p_factura_id IN NUMBER, p_error_number OUT NUMBER);

END FACTURACION_PKG;