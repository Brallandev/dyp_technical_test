CREATE OR REPLACE PROCEDURE tb_prueba_incrementa_valor(
    departamento_id VARCHAR(3),
    incremento NUMERIC,
    OUT records_updated INT
) LANGUAGE plpgsql AS $$
DECLARE
    max_percentage NUMERIC := 30;
BEGIN
    IF percentage_increase > max_percentage THEN
        records_updated := 0; -- No se modifico ningún registro.
        RAISE EXCEPTION 'El porcetanje no puede ser superior al 30%', incremento USING HINT = 'Revise el porcentaje y vuelva a intentarlo';
    ELSE
        UPDATE Factura
        SET valor = valor * (1 + (percentage_increase / 100))
        WHERE cedula IN (
            SELECT cedula
            FROM Cliente c
            JOIN Ciudad ci ON c.cod_ciudad = ci.cod_ciudad
            WHERE ci.cod_departamento = departamento_id
        );
        
        GET DIAGNOSTICS records_updated = ROW_COUNT;
    END IF;
END;
$$;