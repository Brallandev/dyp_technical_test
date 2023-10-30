CREATE OR REPLACE PROCEDURE tb_prueba_actualiza_estado(
    cliente_id INTEGER,
    nuevo_estado estados_cliente
) LANGUAGE plpgsql AS $$
BEGIN
IF(nuevo_estado = 'A' or nuevo_estado = 'I')
	THEN
	IF((SELECT COUNT(*) FROM cliente WHERE cedula=cliente_id)=1)
		THEN IF((SELECT COUNT(*) FROM cliente WHERE cedula=cliente_id AND estado_cliente = nuevo_estado)=1)
			THEN
			RAISE EXCEPTION 'El cliente ya se encuentra en este estado';
		ELSE
			UPDATE cliente SET estado_cliente = nuevo_estado;
			RAISE INFO 'Cliente actualizado';
		END IF;
	ELSE
		RAISE EXCEPTION 'El cliente no existe';
	END IF;
ELSE
RAISE EXCEPTION 'El estado del cliente no aplica. Debe ser Activo o Inactivo';
END IF;
END;
$$;


-- Query for execute procedure
CALL tb_prueba_actualiza_estado(1,'A');

