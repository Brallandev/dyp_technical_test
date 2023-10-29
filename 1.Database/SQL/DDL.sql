/*DDL SQL Staments following relational    */


--CREATE DATABASE dyp_test;

CREATE TABLE Departamento (
	cod_departamento VARCHAR(3) PRIMARY KEY,
	nom_departamento VARCHAR(60) NOT NULL
);

CREATE TABLE Ciudad (
	cod_ciudad SMALLINT PRIMARY KEY,
	nom_ciudad VARCHAR(60) NOT NULL,
	cod_departamento VARCHAR(3) REFERENCES Departamento(cod_departamento)
);

CREATE TYPE estados_cliente AS ENUM('A','I');

CREATE TABLE Cliente (
	cedula INTEGER PRIMARY KEY,
	nombre VARCHAR(60) NOT NULL,
	telefono VARCHAR(20),
	cod_ciudad SMALLINT REFERENCES Ciudad(cod_ciudad),
	estado_cliente estados_clientes NOT NULL DEFAULT 'I',
	img_cliente VARCHAR(500)
);

CREATE TABLE Factura (
	nro_factura INTEGER PRIMARY KEY,
	cedula INTEGER REFERENCES CLiente(cedula),
	fecha_factura DATE NOT NULL DEFAULT CURRENT_DATE,
	valor NUMERIC(12,2)
);