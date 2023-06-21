-- Inserción de CLIENTES

INSERT INTO clientes (nombre, tipodocumento, nrodocumento, telefono, direccion, nrocompras, montocompras, fecharegistro, ultimacompra, ultimamodificacion)
VALUES
('Arturo', '1', '123456', '123456', 'Madrid', 0, 0, TO_DATE('15-04-2023', 'DD-MM-YYYY'), SYSDATE, SYSDATE);

INSERT INTO clientes (nombre) VALUES ('Jorge');

INSERT INTO clientes (nombre) VALUES ('Luis');

INSERT INTO clientes (nombre, tipodocumento, nrodocumento, telefono)
VALUES
('María', '1', '123466', '123466');

insert into clientes (nombre, tipodocumento, nrodocumento, telefono, direccion, nrocompras, montocompras, fecharegistro, ultimamodificacion)
values
('Isabel', 1, '223457', '237561', 'Segovia', 0, 0, TO_DATE('2022-09-03', 'YYYY-MM-DD'), TO_DATE('2022-09-03', 'YYYY-MM-DD'));

insert into clientes (nombre, tipodocumento, nrodocumento, telefono, direccion, nrocompras, montocompras, fecharegistro, ultimamodificacion)
values
('Carlos', 2, '2123456', '334567', 'Madrid', 0, 0, TO_DATE('2022-09-17', 'YYYY-MM-DD'), TO_DATE('2022-09-17', 'YYYY-MM-DD'));

insert into clientes (nombre, tipodocumento, nrodocumento, telefono, direccion, nrocompras, montocompras, fecharegistro, ultimamodificacion)
values
('Vicente', 3, '2144456', '434567', 'Murcia', 0, 0, TO_DATE('2022-09-17', 'YYYY-MM-DD'), TO_DATE('2022-09-17', 'YYYY-MM-DD'));

insert into clientes (nombre, tipodocumento, nrodocumento, telefono, direccion, nrocompras, montocompras, fecharegistro, ultimamodificacion)
values
('Alejandro', 1, '3223456', '333667', 'Barcelona', 0, 0, TO_DATE('2022-09-17', 'YYYY-MM-DD'), TO_DATE('2022-09-17', 'YYYY-MM-DD'));

insert into clientes (nombre, tipodocumento, nrodocumento, telefono, direccion, nrocompras, montocompras, fecharegistro, ultimamodificacion)
values
('Alberto', 1, '2523456', '334337', 'Málaga', 0, 0, TO_DATE('2022-09-17', 'YYYY-MM-DD'), TO_DATE('2022-09-17', 'YYYY-MM-DD'));

insert into clientes (nombre, tipodocumento, nrodocumento, telefono, direccion, nrocompras, montocompras, fecharegistro, ultimamodificacion)
values
('Carmen', 2, '2553456', '534567', 'Sevilla', 0, 0, TO_DATE('2022-09-17', 'YYYY-MM-DD'), TO_DATE('2022-09-17', 'YYYY-MM-DD'));

insert into clientes (nombre, tipodocumento, nrodocumento, telefono, direccion, nrocompras, montocompras, fecharegistro, ultimamodificacion)
values
('Natalia', 1, '6653456', '564567', 'Cadiz', 0, 0, TO_DATE('2022-09-17', 'YYYY-MM-DD'), TO_DATE('2022-09-17', 'YYYY-MM-DD'));

insert into clientes (nombre, tipodocumento, nrodocumento, telefono, direccion, nrocompras, montocompras, fecharegistro, ultimamodificacion)
values
('Olga', 2, '7553456', '834567', 'Asturias', 0, 0, TO_DATE('2022-09-17', 'YYYY-MM-DD'), TO_DATE('2022-09-17', 'YYYY-MM-DD'));

insert into clientes (nombre, tipodocumento, nrodocumento, telefono, direccion, nrocompras, montocompras, fecharegistro, ultimamodificacion)
values
('Samuel', 3, '9153456', '784567', 'Madrid', 0, 0, TO_DATE('2022-09-17', 'YYYY-MM-DD'), TO_DATE('2022-09-17', 'YYYY-MM-DD'));

insert into clientes (nombre, tipodocumento, nrodocumento, telefono, direccion, nrocompras, montocompras, fecharegistro, ultimamodificacion)
values
('Alfonso', 1, '1253478', '531167', 'Sevilla', 0, 0, TO_DATE('2022-09-17', 'YYYY-MM-DD'), TO_DATE('2022-09-17', 'YYYY-MM-DD'));

insert into clientes (nombre, tipodocumento, nrodocumento, telefono, direccion, nrocompras, montocompras, fecharegistro, ultimamodificacion)
values
('Fernando', 2, '8763456', '789567', 'Alicante', 0, 0, TO_DATE('2022-09-17', 'YYYY-MM-DD'), TO_DATE('2022-09-17', 'YYYY-MM-DD'));

insert into clientes (nombre, tipodocumento, nrodocumento, telefono, direccion, nrocompras, montocompras, fecharegistro, ultimamodificacion)
values
('Pedro', 1, '2558956', '534997', 'Cuenca', 0, 0, TO_DATE('2022-09-17', 'YYYY-MM-DD'), TO_DATE('2022-09-17', 'YYYY-MM-DD'));

insert into clientes (nombre, tipodocumento, nrodocumento, telefono, direccion, nrocompras, montocompras, fecharegistro, ultimamodificacion)
values
('David', 2, '2557756', '537587', 'Albacete', 0, 0, TO_DATE('2022-09-17', 'YYYY-MM-DD'), TO_DATE('2022-09-17', 'YYYY-MM-DD'));

insert into clientes (nombre, tipodocumento, nrodocumento, telefono, direccion, nrocompras, montocompras, fecharegistro, ultimamodificacion)
values
('Yolanda', 1, '2593478', '349067', 'Valladolid', 0, 0, TO_DATE('2022-09-17', 'YYYY-MM-DD'), TO_DATE('2022-09-17', 'YYYY-MM-DD'));

-- Inserción de PRODUCTOS

INSERT INTO PRODUCTO (descripcioncorta, inventario, preciocompra, precioventa, tasaimpuesto, descuento)
VALUES
('Lápiz', '50', '1', '2', '20', '0');

INSERT INTO PRODUCTO (descripcioncorta, inventario, preciocompra, precioventa, tasaimpuesto, descuento, descripcionlarga)
VALUES
('Bolígrafo', '30', '2', '3', '20', '0', 'Descripción de mi bolígrafo' );

insert into producto (descripcioncorta, descripcionlarga, inventario, preciocompra, precioventa, tasaimpuesto, descuento, fechacreacion, ultimamodificacion)
values (
'Pincel', 'Pincel por unidades', 20, 1.2, 2.1, '20', '0', TO_DATE('2022-09-03', 'YYYY-MM-DD'), TO_DATE('2022-09-03', 'YYYY-MM-DD'));

insert into producto (descripcioncorta, descripcionlarga, inventario, preciocompra, precioventa, tasaimpuesto, descuento, fechacreacion, ultimamodificacion)
values (
'Sacapuntas', 'Sacapuntas por unidades', 15, 2, 3, '20', '0', TO_DATE('2022-09-03', 'YYYY-MM-DD'), TO_DATE('2022-09-03', 'YYYY-MM-DD'));

insert into producto (descripcioncorta, descripcionlarga, inventario, preciocompra, precioventa, tasaimpuesto, descuento, fechacreacion, ultimamodificacion)
values (
'Borrador', 'Borrador por unidades', 40, 1.4, 2.5, '20', '0', TO_DATE('2022-09-03', 'YYYY-MM-DD'), TO_DATE('2022-09-03', 'YYYY-MM-DD'));

insert into producto (descripcioncorta, descripcionlarga, inventario, preciocompra, precioventa, tasaimpuesto, descuento, fechacreacion, ultimamodificacion)
values (
'Cuaderno', 'Cuadernos por unidades', 7, 2, 3, '20', '0', TO_DATE('2022-09-17', 'YYYY-MM-DD'), TO_DATE('2022-09-17', 'YYYY-MM-DD'));

insert into producto (descripcioncorta, descripcionlarga, inventario, preciocompra, precioventa, tasaimpuesto, descuento, fechacreacion, ultimamodificacion)
values (
'Compás', 'Compás', 12, 5, 8, '20', '0', TO_DATE('2022-09-17', 'YYYY-MM-DD'), TO_DATE('2022-09-17', 'YYYY-MM-DD'));

insert into producto (descripcioncorta, descripcionlarga, inventario, preciocompra, precioventa, tasaimpuesto, descuento, fechacreacion, ultimamodificacion)
values (
'Regla', 'Reglass por unidades', 5, 1, 2, '20', '0', TO_DATE('2022-09-17', 'YYYY-MM-DD'), TO_DATE('2022-09-17', 'YYYY-MM-DD'));

insert into producto (descripcioncorta, descripcionlarga, inventario, preciocompra, precioventa, tasaimpuesto, descuento, fechacreacion, ultimamodificacion)
values (
'Escuadra', 'Escuadra', 18, 1, 2, '20', '0', TO_DATE('2022-09-17', 'YYYY-MM-DD'), TO_DATE('2022-09-17', 'YYYY-MM-DD'));

insert into producto (descripcioncorta, descripcionlarga, inventario, preciocompra, precioventa, tasaimpuesto, descuento, fechacreacion, ultimamodificacion)
values (
'Transportador', 'Transportador', 14, 1, 2, '20', '0', TO_DATE('2022-09-17', 'YYYY-MM-DD'), TO_DATE('2022-09-17', 'YYYY-MM-DD'));

insert into producto (descripcioncorta, descripcionlarga, inventario, preciocompra, precioventa, tasaimpuesto, descuento, fechacreacion, ultimamodificacion)
values (
'Escalímetro', 'Escalímetro', 4, 4, 6, '20', '0', TO_DATE('2022-09-17', 'YYYY-MM-DD'), TO_DATE('2022-09-17', 'YYYY-MM-DD'));

insert into producto (descripcioncorta, descripcionlarga, inventario, preciocompra, precioventa, tasaimpuesto, descuento, fechacreacion, ultimamodificacion)
values (
'Portaminas', 'Portaminas', 23, 3, 5, '20', '0', TO_DATE('2022-09-17', 'YYYY-MM-DD'), TO_DATE('2022-09-17', 'YYYY-MM-DD'));

insert into producto (descripcioncorta, descripcionlarga, inventario, preciocompra, precioventa, tasaimpuesto, descuento, fechacreacion, ultimamodificacion)
values (
'Chinchetas', 'Paquete de chinchetas', 7, 1, 2, '20', '0', TO_DATE('2022-09-17', 'YYYY-MM-DD'), TO_DATE('2022-09-17', 'YYYY-MM-DD'));

insert into producto (descripcioncorta, descripcionlarga, inventario, preciocompra, precioventa, tasaimpuesto, descuento, fechacreacion, ultimamodificacion)
values (
'Tijeras', 'Tijeras', 18, 2, 3, '20', '0', TO_DATE('2022-09-17', 'YYYY-MM-DD'), TO_DATE('2022-09-17', 'YYYY-MM-DD'));

insert into producto (descripcioncorta, descripcionlarga, inventario, preciocompra, precioventa, tasaimpuesto, descuento, fechacreacion, ultimamodificacion)
values (
'Cinta adhesiva', 'Cinta adhesiva', 18, 1, 2, '20', '0', TO_DATE('2022-09-17', 'YYYY-MM-DD'), TO_DATE('2022-09-17', 'YYYY-MM-DD'));