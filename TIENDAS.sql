CREATE TABLE TIENDAS
(
	nif VARCHAR2 (8) NOT NULL,
	nombre VARCHAR2(20),
	direccion VARCHAR2(20),
	poblacion VARCHAR2(20),
	provincia VARCHAR2(20),
	codpostal NUMBER(5),
	CONSTRAINT pk_nif PRIMARY KEY (nif),
	CONSTRAINT ck_provincia CHECK (UPPER = provincia )
	);

CREATE TABLE FABRICANTES
(
	cod_fabricante NUMBER(3),
	nombre VARCHAR2(15),
	pais VARCHAR2(15),
	CONSTRAINT pk_cod_fabricante PRIMARY KEY (cod_fabricante),
	CONSTRAINT ck_mayusc CHECK (nombre, pais '[A-Z]')
	);

CREATE TABLE ARTICULOS
(
	articulo VARCHAR2(20) NOT NULL,
	cod_fabricante NUMBER(3) NOT NULL,
	peso NUMBER(3) NOT NULL,
	categoria VARCHAR2(10) NOT NULL,
	precio_venta NUMBER(6),
	precio_costo NUMBER(6),
	existencias NUMBER(5),
	CONSTRAINT pk_articulos PRIMARY KEY (articulo, cod_fabricante, peso, categoria),
	CONSTRAINT fk_cod_fabricante FOREIGN KEY (cod_fabricante) REFERENCES FABRICANTES(cod_fabricante),
	CONSTRAINT ck_articulos CHECK (precio_venta, precio_costo, peso > 0),
	CONSTRAINT ck_articulos1 CHECK (categoria IN('primera' 'segunda' 'tercera''[A-Z]'))
	);

CREATE TABLE PEDIDOS
(
	nif VARCHAR2(10) NOT NULL,
	articulo VARCHAR2(20) NOT NULL,
	cod_fabricante NUMBER(3) NOT NULL,
	peso NUMBER(3) NOT NULL,
	categoria VARCHAR2(10) NOT NULL,
	fecha_pedido DATE NOT NULL,
	unidades_pedidas NUMBER(4),
	CONSTRAINT pk_pedidos PRIMARY KEY (nif, articulo, cod_fabricante, peso, categoria, fecha_pedido),
	CONSTRAINT fk_cod_fabricante FOREIGN KEY (cod_fabricante) REFERENCES FABRICANTES(cod_fabricante),
	CONSTRAINT ck_unidades_pedidas CHECK (unidades_pedidas > 0),
	CONSTRAINT fk_pedidos FOREIGN KEY (articulo) REFERENCES ARTICULOS(articulo) ON DELETE CASCADE,
	CONSTRAINT fk_pedidos1 FOREIGN KEY (cod_fabricante) REFERENCES ARTICULOS(cod_fabricante) ON DELETE CASCADE,
	CONSTRAINT fk_pedidos2 FOREIGN KEY (peso) REFERENCES ARTICULOS(peso) ON DELETE CASCADE,
	CONSTRAINT fk_pedidos3 FOREIGN KEY (categoria) REFERENCES ARTICULOS(categoria) ON DELETE CASCADE,
	CONSTRAINT fk_pedidos4 FOREIGN KEY (nif) REFERENCES TIENDAS(nif)
	);

CREATE TABLE VENTAS
(
	nif VARCHAR2(10) NOT NULL,
	articulo VARCHAR2(20) NOT NULL,
	cod_fabricante NUMBER(3) NOT NULL,
	peso NUMBER(3) NOT NULL,
	categoria VARCHAR2(10) NOT NULL,
	fecha_venta DATE TIME NOT NULL,
	unidades_vendidas NUMBER(4),
	CONSTRAINT pk_ventas PRIMARY KEY (nif, articulo, cod_fabricante, peso, categoria, fecha_venta),
	CONSTRAINT fk_ventas FOREIGN KEY (cod_fabricante) REFERENCES FABRICANTES(cod_fabricante),
	CONSTRAINT ck_ventas CHECK (unidades_vendidas > 0),
	CONSTRAINT fk_ventas1 FOREIGN KEY (articulo) REFERENCES ARTICULOS(articulo) ON DELETE CASCADE,
	CONSTRAINT fk_ventas2 FOREIGN KEY (cod_fabricante) REFERENCES ARTICULOS(cod_fabricante) ON DELETE CASCADE,
	CONSTRAINT fk_ventas3 FOREIGN KEY (categoria) REFERENCES ARTICULOS(categoria) ON DELETE CASCADE,
	CONSTRAINT fk_ventas4 FOREIGN KEY (peso) REFERENCES ARTICULOS(peso) ON DELETE CASCADE,
	CONSTRAINT fk_ventas5 FOREIGN KEY (nif) REFERENCES TIENDAS(nif)
	);

ALTER TABLE VENTAS ADD unidades_pedidos NUMBER(6);
ALTER TABLE VENTAS ADD unidades_vendidas NUMBER(6);
ALTER TABLE PEDIDOS ADD unidades_pedidos NUMBER(6);
ALTER TABLE PEDIDOS ADD unidades_vendidas NUMBER(6);
ALTER TABLE PEDIDOS ADD pvp_articulo;
ALTER TABLE VENTAS ADD pvp_articulo;
ALTER TABLE FABRICANTE DROP COLUMN pais;
ALTER TABLE VENTAS (unidades_vendidas > 100);
ALTER TABLE VENTAS CHECK (unidades_vendidas >100);

DROP TABLE ARTICULOS CASCADE CONSTRAINTS;
DROP TABLE TIENDAS CASCADE CONSTRAINTS;
DROP TABLE FABRICANTES CASCADE CONSTRAINTS;
DROP TABLE PEDIDOS CASCADE CONSTRAINTS;
DROP TABLE VENTAS CASCADE CONSTRAINTS;
