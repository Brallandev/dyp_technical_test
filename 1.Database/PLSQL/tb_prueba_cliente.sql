CREATE OR REPLACE FUNCTION tb_prueba_cliente(client_cedula INTEGER)
RETURNS VARCHAR(60) AS $$
DECLARE
    client_name VARCHAR(60);
BEGIN
    SELECT nombre INTO client_name
    FROM Cliente
    WHERE cedula = client_cedula;

    IF client_name IS NULL THEN
        RAISE EXCEPTION 'El Cliente no pudo ser encontrado con ese num de cedula.  %', client_cedula;
    END IF;

    RETURN client_name;
END;
$$
LANGUAGE plpgsql;