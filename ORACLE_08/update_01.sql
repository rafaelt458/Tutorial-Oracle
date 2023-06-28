UPDATE clientes SET 
	tipodocumento = '1',
	nrodocumento = '259874',
	telefono = '259874',
	direccion = 'Murcia'
WHERE idcliente = 2;

UPDATE clientes SET 
	tipodocumento = '1',
	nrodocumento = '295874',
	telefono = '295874',
	direccion = 'Madrid'
WHERE idcliente = 3;

UPDATE clientes SET 
	direccion = 'Valladolid'
WHERE idcliente = 6;

UPDATE clientes SET 
	direccion = 'Málaga'
WHERE idcliente = 11;

UPDATE producto SET
	descripcioncorta = 'Compás',
	descripcionlarga = 'Compás'
WHERE idproducto = 7;

UPDATE producto SET
	descripcioncorta = 'Escalímetro',
	descripcionlarga = 'Escalímetro'
WHERE idproducto = 11;