SELECT
    EXTRACT(YEAR FROM ttc.fecha_transaccion) AS "AÑO"
    --c.nombre_region AS "REGION"
FROM cliente c
    JOIN tarjeta_cliente tc ON c.numrun = tc.numrun
    JOIN transaccion_tarjeta_cliente ttc ON tc.nro_tarjeta = ttc.nro_tarjeta
    JOIN sucursal_retail sr ON c.cod_region = sr.cod_region
                            AND c.cod_provincia = sr.cod_provincia
                            AND c.cod_comuna = sr.cod_comuna
;

--CASO N°1
SELECT
    TO_CHAR(c.numrun, '09G999G999')||'-'||INITCAP(c.dvrun) AS "RUN CLIENTE",
    c.pnombre||' '||c.snombre||' '||c.appaterno||' '||c.apmaterno AS "NOMBRE CLIENTE",
    TO_CHAR(ttc.monto_total_transaccion, '$99G999G999') AS "TOTAL TRANSACCIÓN",
    sr.direccion AS "SUCURSAL"
FROM cliente c
    JOIN tarjeta_cliente tc ON c.numrun = tc.numrun
    JOIN transaccion_tarjeta_cliente ttc ON tc.nro_tarjeta = ttc.nro_tarjeta
    JOIN sucursal_retail sr ON c.cod_region = sr.cod_region
                            AND c.cod_provincia = sr.cod_provincia
                            AND c.cod_comuna = sr.cod_comuna
--GROUP BY "RUN CLIENTE"
;

--CASO N°2

SELECT
    EXTRACT(YEAR FROM tc.fecha_transaccion) AS "AÑO",
    
FROM transaccion_tarjeta_cliente tc
    JOIN sucursal_retail sr ON tc.id_sucursal = sr.id_sucursal
    JOIN comuna com ON sr.id_
;



SELECT
*
FROM region
;