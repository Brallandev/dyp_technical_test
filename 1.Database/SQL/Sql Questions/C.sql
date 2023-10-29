-- SOLVE FOR C

/* C. Generar el valor acumulado y nombre del cliente al que más se le vendió en el departamento de SANTANDER durante el primer trimestre de 2006 y 2005 */

WITH Q1_Sales AS (
    SELECT
        c.nombre AS client_name,
        c.cedula AS client_cedula,
        SUM(f.valor) AS total_sales
    FROM Cliente c
    JOIN Factura f ON c.cedula = f.cedula
    JOIN Ciudad ci ON c.cod_ciudad = ci.cod_ciudad
    JOIN Departamento d ON ci.cod_departamento = d.cod_departamento
    WHERE EXTRACT(YEAR FROM f.fecha_factura) IN (2005, 2006)
      AND EXTRACT(MONTH FROM f.fecha_factura) BETWEEN 1 AND 3
      AND d.cod_departamento = 'SAN'
    GROUP BY c.nombre, c.cedula
    ORDER BY total_sales DESC
    LIMIT 1
)

SELECT client_name AS Nombre, total_sales AS Valor
FROM Q1_Sales;