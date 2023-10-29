-- SOLVE FOR A
/* A. Generar el valor promedio de ventas por cliente (mostrar el nombre cliente) para el año 2006 de los clientes que no están dentro de las ventas del 2005 */

-- Create a common table expression (CTE) to gather sales data for clients in 2006
WITH SalesData AS (
    SELECT
        c.nombre AS client_name,  -- Retrieve the client's name
        SUM(CASE WHEN EXTRACT(YEAR FROM f.fecha_factura) = 2006 THEN f.valor ELSE 0 END) AS total_sales_2006
        -- Calculate the sum of sales values for the year 2006, or 0 if not in 2006
    FROM Cliente c
    LEFT JOIN Factura f ON c.cedula = f.cedula  -- Join the Cliente and Factura tables
    WHERE EXTRACT(YEAR FROM f.fecha_factura) IN (2005, 2006)
    -- Filter data to include only records from 2005 and 2006
    GROUP BY c.nombre  -- Group data by client name
    HAVING SUM(CASE WHEN EXTRACT(YEAR FROM f.fecha_factura) = 2005 THEN f.valor ELSE 0 END) = 0
    -- Include only clients with zero sales in 2005
)

-- Select the client name and calculate the average sales for clients in 2006
SELECT client_name AS Nombre, AVG(total_sales_2006) AS Promedio
FROM SalesData
GROUP BY client_name;