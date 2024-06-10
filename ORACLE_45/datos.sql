/*==============================================================*/
/* Table: CARRERAS                                              */
/*==============================================================*/
create table CARRERAS 
(
   ID                   INTEGER              not null,
   NOMBRE               VARCHAR2(40)         not null,
   constraint PK_CARRERAS primary key (ID)
);

/*==============================================================*/
/* Table: PILOTOS                                               */
/*==============================================================*/
create table PILOTOS 
(
   ID                   INTEGER              not null,
   NOMBRE               VARCHAR2(40)         not null,
   constraint PK_PILOTOS primary key (ID)
);

/*==============================================================*/
/* Table: RESULTADOS                                            */
/*==============================================================*/
create table RESULTADOS 
(
   ID                   INTEGER              not null,
   PILOTO_ID            INTEGER              not null,
   CARRERA_ID           INTEGER              not null,
   POSICION             INTEGER              not null,
   PUNTOS               INTEGER              not null,
   constraint PK_RESULTADOS primary key (ID)
);

alter table RESULTADOS
   add constraint FK_RESULTAD_RESULTADO_CARRERAS foreign key (CARRERA_ID)
      references CARRERAS (ID);

alter table RESULTADOS
   add constraint FK_RESULTAD_RESULTADO_PILOTOS foreign key (PILOTO_ID)
      references PILOTOS (ID);


insert into Pilotos values(1, 'Giuseppe Farina');
insert into Pilotos values(2, 'Juan Manuel Fangio');
insert into Pilotos values(3, 'Luigi Villoresi');
insert into Pilotos values(4, 'José Froilán González');
insert into Pilotos values(5, ' Alberto Ascari');

insert into Carreras values(1, 'Suiza');
insert into Carreras values(2, 'Bélgica');
insert into Carreras values(3, 'Francia');
insert into Carreras values(4, 'Gran Bretaña');
insert into Carreras values(5, 'Alemania');
insert into Carreras values(6, 'Italia');
insert into Carreras values(7, 'España');

insert into Resultados values(1, 2, 1, 1, 9);
insert into Resultados values(2, 2, 2, 20, 1);
insert into Resultados values(3, 2, 3, 3, 5);
insert into Resultados values(4, 2, 4, 2, 6);
insert into Resultados values(5, 2, 5, 2, 7);
insert into Resultados values(6, 2, 6, 20, 0);
insert into Resultados values(7, 2, 7, 1, 9);

insert into Resultados values(8, 5, 1, 20, 0);
insert into Resultados values(9, 5, 2, 2, 6);
insert into Resultados values(10, 5, 3, 2, 3);
insert into Resultados values(11, 5, 4, 20, 0);
insert into Resultados values(12, 5, 5, 1, 8);
insert into Resultados values(13, 5, 6, 1, 8);
insert into Resultados values(14, 5, 7, 4, 3);

insert into Resultados values(15, 4, 1, 19, 0);
insert into Resultados values(16, 4, 2, 19, 0);
insert into Resultados values(17, 4, 3, 2, 3);
insert into Resultados values(18, 4, 4, 1, 8);
insert into Resultados values(19, 4, 5, 3, 4);
insert into Resultados values(20, 4, 6, 2, 6);
insert into Resultados values(21, 4, 7, 2, 6);

insert into Resultados values(22, 1, 1, 3, 4);
insert into Resultados values(23, 1, 2, 1, 8);
insert into Resultados values(24, 1, 3, 5, 2);
insert into Resultados values(25, 1, 4, 19, 1);
insert into Resultados values(26, 1, 5, 19, 0);
insert into Resultados values(27, 1, 6, 2, 3);
insert into Resultados values(28, 1, 7, 3, 4);

insert into Resultados values(29, 3, 1, 18, 0);
insert into Resultados values(30, 3, 2, 3, 4);
insert into Resultados values(31, 3, 3, 3, 4);
insert into Resultados values(32, 3, 4, 3, 4);
insert into Resultados values(33, 3, 5, 4, 3);
insert into Resultados values(34, 3, 6, 4, 3);
insert into Resultados values(35, 3, 7, 20, 0);
