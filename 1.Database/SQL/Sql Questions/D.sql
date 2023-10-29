-- SOLVE FOR D

/* D. Generar el valor y porcentaje ventas equivalentes por ciudad para el año 2005 y 2006 de los clientes que están en estado activo*/


WITH SalesData AS (
    SELECT
        ci.nom_ciudad AS Ciudad,
        SUM(f.valor) AS Valor
    FROM Cliente c
    JOIN Ciudad ci ON c.cod_ciudad = ci.cod_ciudad
    JOIN Factura f ON c.cedula = f.cedula
    WHERE EXTRACT(YEAR FROM f.fecha_factura) BETWEEN 2005 AND 2006
      AND c.estado_cliente = 'A'
    GROUP BY ci.nom_ciudad
),

TotalSales AS (
    SELECT SUM(Valor) AS total
    FROM SalesData
)

SELECT
    sd.Ciudad,
    sd.Valor,
    (sd.Valor / ts.total) * 100 AS Procentaje
FROM SalesData sd
CROSS JOIN TotalSales ts;