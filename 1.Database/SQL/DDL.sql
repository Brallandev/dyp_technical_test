/*DDL SQL Statements following relational according test specifications*/

--CREATE DATABASE
CREATE DATABASE dyp_test;

--CREATE Departamento TABLE
CREATE TABLE Departamento (
	cod_departamento VARCHAR(3) PRIMARY KEY,
	nom_departamento VARCHAR(60) NOT NULL
);

--CREATE Ciudad TABLE
CREATE TABLE Ciudad (
	cod_ciudad SMALLINT PRIMARY KEY,
	nom_ciudad VARCHAR(60) NOT NULL,
	cod_departamento VARCHAR(3) REFERENCES Departamento(cod_departamento)
);

--CREATE estados_cliente As a enum type thought there are only two valid options A(Activo), I(Inactivo)
CREATE TYPE estados_cliente AS ENUM('A','I');

--CREATE Cliente TABLE
CREATE TABLE Cliente (
	cedula INTEGER PRIMARY KEY,
	nombre VARCHAR(60) NOT NULL,
	telefono VARCHAR(20),
	cod_ciudad SMALLINT REFERENCES Ciudad(cod_ciudad),
	estado_cliente estados_cliente NOT NULL DEFAULT 'I',
	img_cliente VARCHAR(500)
);

--CREATE Factura TABLE
CREATE TABLE Factura (
	nro_factura INTEGER PRIMARY KEY,
	cedula INTEGER REFERENCES CLiente(cedula),
	fecha_factura DATE NOT NULL DEFAULT CURRENT_DATE,
	valor NUMERIC(12,2)
);