select *
	from  tabla1;

select *
	from  tabla2;
	
CREATE GLOBAL TEMPORARY TABLE tabla1 (
campo1 int,
campo2 varchar(10)
) ON COMMIT DELETE ROWS ;

DROP TABLE TABLA1;