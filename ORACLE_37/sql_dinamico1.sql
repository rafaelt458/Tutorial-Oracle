DECLARE
	num_registros NUMBER;
	query VARCHAR2(500);

BEGIN
	
	query := 'UPDATE FACTURA SET anulada = ''0''';

	EXECUTE IMMEDIATE query;

	num_registros := SQL%ROWCOUNT;

	dbms_output.put_line('Número de registros afectados: ' || num_registros);

	COMMIT;
	
END;


DECLARE
	num_registros NUMBER;
	valor CHAR(1);
	idfactura NUMBER;
	query VARCHAR2(500);

BEGIN
	
	valor := '0';
	idfactura := 7;
	query := 'UPDATE FACTURA SET anulada = :valor WHERE idfactura = :idfactura';

	EXECUTE IMMEDIATE query USING valor, idfactura;

	num_registros := SQL%ROWCOUNT;

	dbms_output.put_line('Número de registros afectados: ' || num_registros);

	COMMIT;
	
END;