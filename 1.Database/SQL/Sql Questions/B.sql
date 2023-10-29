-- SOLVE FOR B
/* B. Generar el valor total y el porcentaje equivalente para las ventas del año 2006 que no incluya el mes de febrero. El porcentaje debe ser sobre el total de ventas del año 2006 */

WITH SalesData AS (
    SELECT
        SUM(CASE WHEN EXTRACT(YEAR FROM f.fecha_factura) = 2006 THEN f.valor ELSE 0 END) AS total_sales_2006,
		SUM(CASE WHEN EXTRACT(YEAR FROM f.fecha_factura) = 2006 AND EXTRACT(MONTH FROM f.fecha_factura) != 2 THEN f.valor ELSE 0 END) AS total_sales_2006_nofeb
    FROM Factura f
)

SELECT 
	total_sales_2006_nofeb AS Valor,
	((total_sales_2006_nofeb * 100)/total_Sales_2006) AS Porcentaje
FROM SalesData;