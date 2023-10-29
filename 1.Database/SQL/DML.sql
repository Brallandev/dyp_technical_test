/*DML SQL Statements for populated tables with initial data*/

--Create registry for 32 departments of Colombia.
-- Insert data into the Departamento table
INSERT INTO departamento (cod_departamento, nom_departamento)
VALUES
    ('AMA', 'Amazonas'),
    ('ANT', 'Antioquia'),
    ('ARA', 'Arauca'),
    ('ATL', 'Atlántico'),
    ('BOL', 'Bolívar'),
    ('BOY', 'Boyacá'),
    ('CAL', 'Caldas'),
    ('CAQ', 'Caquetá'),
    ('CAS', 'Casanare'),
    ('CAU', 'Cauca'),
    ('CES', 'Cesar'),
    ('CHO', 'Chocó'),
    ('COR', 'Córdoba'),
    ('CUN', 'Cundinamarca'),
    ('GUA', 'Guainía'),
    ('GUV', 'Guaviare'),
    ('HUI', 'Huila'),
    ('GAJ', 'La Guajira'),
    ('MAG', 'Magdalena'),
    ('MET', 'Meta'),
    ('NAR', 'Nariño'),
    ('NOR', 'Norte de Santander'),
    ('PUT', 'Putumayo'),
    ('QUI', 'Quindío'),
    ('RIS', 'Risaralda'),
    ('SAP', 'San Andrés y Providencia'),
    ('SAN', 'Santander'),
    ('SUC', 'Sucre'),
    ('TOL', 'Tolima'),
    ('VAC', 'Valle del Cauca'),
    ('VAU', 'Vaupés'),
    ('VID', 'Vichada');
	
-- Insert data into the Ciudad table
INSERT INTO Ciudad (nom_ciudad, cod_departamento)
VALUES
    ('Bogotá', 'CUN'),  -- Bogotá, D.C. Cundinamarca
    ('Medellín', 'ANT'),  -- Medellín, Antioquia
    ('Cali', 'VAC'),  -- Cali, Valle del Cauca
    ('Barranquilla', 'ATL'),  -- Barranquilla, Atlántico
    ('Cartagena', 'BOL'),  -- Cartagena, Bolívar
    ('Bucaramanga', 'SAN'),  -- Bucaramanga, Santander
    ('Cúcuta', 'NOR'),  -- Cúcuta, Norte de Santander
    ('Pereira', 'RIS'),  -- Pereira, Risaralda
    ('Santa Marta', 'MAG'),  -- Santa Marta, Magdalena
    ('Villavicencio', 'MET'),  -- Villavicencio, Meta
    ('Ibagué', 'TOL'),  -- Ibagué, Tolima
    ('Pasto', 'NAR'),  -- Pasto, Nariño
    ('Manizales', 'CAL'),  -- Manizales, Caldas
    ('Neiva', 'HUI'),  -- Neiva, Huila
    ('Montería', 'COR'),  -- Montería, Córdoba
    ('Tunja', 'BOY'); -- Tunja, Boyacá

-- Insert data into the Cliente table
INSERT INTO Cliente (cedula, nombre, telefono, cod_ciudad, estado_cliente)
VALUES
    (12312314, 'Juan Pérez', '123-456-7890', 1, 'A'),
    (24535332, 'María Rodríguez', '987-654-3210', 2, 'I'),
    (33213421, 'Carlos Gómez', '555-555-5555', 3, 'A'),
    (42317685, 'Luisa Fernández', '777-888-9999', 4, 'I'),
    (59774432, 'Andrés González', '111-222-3333', 5, 'A'),
    (69723738, 'Ana Sánchez', '333-444-5555', 6, 'I'),
    (79776543, 'Diego Ramírez', '666-777-8888', 6, 'I'),
    (85668853, 'Laura Martínez', '999-000-1111', 6, 'A'),
    (94645634, 'Felipe Castro', '222-333-4444', 6, 'A'),
    (10456463, 'Sofía López', '444-555-6666', 7, 'A'),
    (11564345, 'Jorge Herrera', '777-666-5555', 8, 'A'),
    (12567574, 'Valentina Rincón', '888-777-6666', 9, 'I'),
    (13456567, 'Santiago Paredes', '333-222-1111', 10, 'I'),
    (14456345, 'Isabella Morales', '222-111-0000', 11, 'A'),
    (15934564, 'Mateo Quintero', '555-555-5555', 12, 'A'),
    (16324675, 'Camila Ochoa', '111-111-1111', 13, 'I');
	
-- Create a common table expression (CTE) to generate quarterly dates
WITH QuarterlyDates AS (
    SELECT generate_series('2005-01-01'::date, '2006-12-31'::date, '3 months') AS fecha_factura
)

-- Insert data into the Factura table for all clients with 5 invoices each
INSERT INTO Factura (nro_factura, cedula, fecha_factura, valor)
SELECT
    row_number() OVER () AS nro_factura,
    c.cedula,
    qd.fecha_factura,
    random() * 1000000 AS valor
FROM Cliente c
CROSS JOIN QuarterlyDates qd
CROSS JOIN generate_series(1, 5) AS n;  -- Generate 5 invoices per quarter