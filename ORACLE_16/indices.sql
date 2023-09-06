create index nombre_cliente_idx on clientes (
	nombre ASC
);

create index descripcion_producto_idx on producto (
	descripcioncorta ASC
);


-- Ver todos los índices que existen en el esquema
select *
	from all_indexes
	WHERE OWNER = 'LABORATORIO';
	


-- Monitorizar el uso de un índice
ALTER INDEX descripcion_producto_idx MONITORING USAGE;

SELECT *
	FROM  CLIENTES 
	WHERE NOMBRE  = 'Jorge';

SELECT *
	FROM  PRODUCTO p  
	WHERE DESCRIPCIONCORTA  = 'Lápiz';
	
SELECT	do.owner,
		t.name table_name,
		io.name index_name,
		decode(bitand(i.flags, 65536), 0, 'NO', 'YES') monitoring,
		decode(bitand(ou.flags, 1), 0, 'NO', 'YES') used,
		ou.start_monitoring,
		ou.end_monitoring
		FROM	sys.obj$ io, sys.obj$ t, sys.ind$ i, sys.object_usage ou, dba_objects do
		WHERE	i.obj# = ou.obj#
		AND		io.obj# = ou.obj#
		AND		t.obj# = i.bo#
		AND		i.obj# = do.object_id
		ORDER BY 1, 2, 3;
		
ALTER INDEX descripcion_producto_idx NOMONITORING USAGE;


DROP INDEX nombre_cliente_idx;