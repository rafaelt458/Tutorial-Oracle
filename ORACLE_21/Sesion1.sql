/* Tipos de tablas temporales */
CREATE GLOBAL TEMPORARY TABLE tabla1 (
campo1 int,
campo2 varchar(10)
) ON COMMIT DELETE ROWS ;

CREATE GLOBAL TEMPORARY TABLE tabla2 (
	campo1 int,
	campo2 varchar(10)
) ON COMMIT PRESERVE ROWS;

insert into tabla1 (campo1, campo2) values (1, 'texto 1');
insert into tabla1 (campo1, campo2) values (2, 'texto 2');
insert into tabla1 (campo1, campo2) values (1, 'texto 3');

insert into tabla2 (campo1, campo2) values (1, 'texto 1');
insert into tabla2 (campo1, campo2) values (2, 'texto 2');
insert into tabla2 (campo1, campo2) values (2, 'texto 3');


select *
	from  tabla1;

select *
	from  tabla2;

commit;


select *
	from  tabla1;

select *
	from  tabla2;
	
DROP TABLE TABLA1;
DROP TABLE TABLA2;