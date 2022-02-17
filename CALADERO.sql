CREATE TABLE BARCOS
(
	matricula VARCHAR2(50),
	nombre VARCHAR2(50),
	clase VARCHAR2(50),
	armador VARCHAR2(50),
	capacidad NUMBER(8),
	nacionalidad VARCHAR2(50),
	CONSTRAINT pk_matricula PRIMARY KEY (matricula),
	CONSTRAINT ch_matricula CHECK(regexp_like(matricula,'[A-Z]{2}[-][0-9]{3}'))
	);

CREATE TABLE ESPECIE
(
	codigo VARCHAR2(30),
	nombre VARCHAR2(30),
	tipo VARCHAR2(20),
	cupoporbarco VARCHAR2(20),
	caladero_principal VARCHAR2(30),
	CONSTRAINT pk_codigo PRIMARY KEY (codigo)
	);

CREATE TABLE LOTES
(
	codigo VARCHAR2(50),
	matricula VARCHAR2(50),
	num_kilos NUMBER(8),
	precio_kilosalida NUMBER(8),
	precio_kiloadjudicado NUMBER(8),
	fecha_venta NUMBER(8) NOT NULL,
	cod_especie VARCHAR2(50),
	CONSTRAINT pk_codigo PRIMARY KEY (codigo),
	CONSTRAINT fk_matricula FOREIGN KEY (matricula) REFERENCES BARCOS(matricula) ON DELETE CASCADE,
	CONSTRAINT fk_cod_especie FOREIGN KEY (cod_especie) REFERENCES ESPECIE(codigo) ON DELETE CASCADE,
	CONSTRAINT ck_precio_kilo CHECK (precio_kiloadjudicado > precio_kilosalida),
	CONSTRAINT ck_num CHECK (num_kilos, precio_kiloadjudicado, precio_kilosalida > 0)
	);



CREATE TABLE CALADERO
(
	codigo VARCHAR2(30),
	nombre VARCHAR2(30),
	ubicacion VARCHAR2(50),
	especie_principal VARCHAR2(30),
	CONSTRAINT pk_codigo PRIMARY KEY (codigo),
	CONSTRAINT fk_especie_principal FOREIGN KEY (especie_principal) REFERENCES ESPECIE(codigo),
	CONSTRAINT ck_mayuscula CHECK (nombre, ubicacion '[A-Z]')
	);

ALTER TABLE ESPECIE ADD CONSTRAINT fk_caladero_principal FOREIGN KEY (caladero_principal) REFERENCES CALADERO(codigo);

CREATE TABLE FECHAS_CAPTURAS_PERMITIDAS
(
	cod_especie VARCHAR2(30),
	cod_caladero VARCHAR2(30),
	fecha_inicial DATE,
	fecha_final DATE,
	CONSTRAINT pk_codigo_capturas PRIMARY KEY (cod_especie, cod_caladero),
	CONSTRAINT fk_cod_especie FOREIGN KEY cod_especie REFERENCES ESPECIE(codigo),
	CONSTRAINT fk_cod_caladero FOREIGN KEY cod_caladero REFERENCES CALADERO(codigo),
	);

ALTER TABLE FECHAS_CAPTURAS_PERMITIDAS Fecha > TO_CHAR(fecha inicial, '02/02') (fecha_final, '03/28'); 

ALTER TABLE CALADERO ADD nombre_cientifico;
ALTER TABLE BARCOS DROP COLUMN armador;

DROP TABLE BARCOS CASCADE CONSTRAINTS;
DROP TABLE ESPECIE CASCADE CONSTRAINTS;
DROP TABLE LOTES CASCADE CONSTRAINTS;
DROP TABLE CALADERO CASCADE CONSTRAINTS;
DROP TABLE FECHAS_CAPTURAS_PERMITIDAS CASCADE CONSTRAINTS;




--Para convertir la fecha de cadena a fecha--
--Le decimos que nos muestre una fecha mayor que la fecha que hemos puesto ahí-- 
Fecha > TO_date('01/02/2022','DD/MM/YYYY')
--Para la fecha inicial y fecha que termina--
TO_CHAR(fecha inicial, 'mm/dd')
