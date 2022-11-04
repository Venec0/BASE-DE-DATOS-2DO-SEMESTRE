--CASO N°1

SELECT
    TO_CHAR(cli.numrun, '09G999G999')||'-'||cli.dvrun AS "RUN CLIENTE",
    INITCAP(cli.pnombre||' '||cli.snombre||' '||cli.appaterno||' '||cli.apmaterno) AS "NOMBRE CLIENTE",
    TO_CHAR(cli.fecha_nacimiento, 'DD "de" Month') AS "DIA DE CUMPLEAÑOS",
    sr.direccion||'/'||UPPER(re.nombre_region) AS "DIRECCION SUCURSAL / REGION SUCURSAL"
FROM cliente cli
    JOIN sucursal_retail sr ON cli.cod_region = sr.cod_region
                            AND cli.cod_provincia = sr.cod_provincia
                            AND cli.cod_comuna = sr.cod_comuna
    JOIN region re ON cli.cod_region = re.cod_region
WHERE cli.cod_region = 13 AND EXTRACT(MONTH FROM cli.fecha_nacimiento) = 09
ORDER BY "DIA DE CUMPLEAÑOS" ASC, "NOMBRE CLIENTE" DESC
;

--CASO N°2

SELECT
    TO_CHAR(cli.numrun, '99G999G999') ||'-'|| cli.dvrun AS "RUN CLIENTE",
    cli.pnombre||' '||cli.snombre||' '||cli.appaterno||' '||cli.apmaterno AS "NOMBRE CLIENTE",
    TO_CHAR(SUM(ttc.monto_transaccion), '$99G999G999')  AS "MONTO COMPRAS/AVANCES/S.AVANCES",
    TO_CHAR((SUM(ttc.monto_transaccion)/10000)*250,'$99G999G999') AS "TOTAL PUNTOS ACUMULADOS"
FROM cliente cli
    JOIN tarjeta_cliente tc ON cli.numrun = tc.numrun
    JOIN transaccion_tarjeta_cliente ttc ON tc.nro_tarjeta = ttc.nro_tarjeta
WHERE EXTRACT(YEAR FROM ttc.fecha_transaccion) = EXTRACT(YEAR FROM SYSDATE)-1
GROUP BY cli.numrun, cli.dvrun, cli.pnombre, cli.snombre, cli.appaterno, cli.apmaterno
ORDER BY "MONTO COMPRAS/AVANCES/S.AVANCES"
;

--CASO N°3

SELECT
    TO_CHAR(ttc.fecha_transaccion, 'MMYYYY') AS "MES TRANSACCIÓN",
    ttt.nombre_tptran_tarjeta AS "TIPO TRANSACCIÓN",
    TO_CHAR(ttc.monto_total_transaccion, '$99G999G999') AS "MONTO AVANCES / SUPER AVANCES",
    TO_CHAR((ttc.monto_total_transaccion * (asb.porc_aporte_sbif/100)), '$99G999G999') AS "APORTE A LA SBIF"
FROM transaccion_tarjeta_cliente ttc
    JOIN tipo_transaccion_tarjeta ttt ON ttc.cod_tptran_tarjeta = ttt.cod_tptran_tarjeta
    JOIN aporte_sbif asb ON ttc.monto_total_transaccion BETWEEN asb.monto_inf_av_sav AND asb.monto_sup_av_sav
WHERE ttt.cod_tptran_tarjeta IN (102,103)
AND EXTRACT(YEAR FROM ttc.fecha_transaccion) = EXTRACT(YEAR FROM SYSDATE)
GROUP BY (TO_CHAR(ttc.fecha_transaccion, 'MMYYYY'), ttt.nombre_tptran_tarjeta)
ORDER BY "MES TRANSACCIÓN" , "TIPO TRANSACCIÓN"
;

--CORREGIR GROUP BY.

--CASO N°4

SELECT
    TO_CHAR(c.numrun, '09G999G999')||'-'||c.dvrun AS "RUN CLIENTE",
    c.pnombre||' '||c.snombre||' '||c.appaterno||' '||c.apmaterno AS "NOMBRE CLIENTE",
    RTRIM(TO_CHAR(NVL(SUM(ttc.monto_total_transaccion),0), '$99G999G999')) AS "COMPRAS / AVANCES / S.AVANCES",
    CASE WHEN NVL(SUM(ttc.monto_total_transaccion),0) BETWEEN 0 AND 100000 THEN 'SIN CATEGORIZACIÓN'
    WHEN NVL(SUM(ttc.monto_total_transaccion),0) BETWEEN 100001 AND 1000000 THEN 'BRONCE'
    WHEN NVL(SUM(ttc.monto_total_transaccion),0) BETWEEN 1000001 AND 4000000 THEN 'PLATA'
    WHEN NVL(SUM(ttc.monto_total_transaccion),0) BETWEEN 4000001 AND 8000000 THEN 'SILVER'
    WHEN NVL(SUM(ttc.monto_total_transaccion),0) BETWEEN 8000001 AND 15000000 THEN 'GOLD'
    WHEN NVL(SUM(ttc.monto_total_transaccion),0) > 15000000 THEN 'PLATINUM'
    END AS "CATEGORIZACION CLIENTE"
FROM cliente c
    INNER JOIN tarjeta_cliente tc ON tc.numrun = c.numrun
    LEFT JOIN transaccion_tarjeta_cliente ttc ON ttc.nro_tarjeta = tc.nro_tarjeta
GROUP BY TO_CHAR(c.numrun, '09G999G999')||'-'||dvrun,pnombre,snombre,appaterno,apmaterno
ORDER BY appaterno, "COMPRAS / AVANCES / S.AVANCES" DESC
;

--CASO N°5

SELECT
    TO_CHAR(c.numrun, '09G999G999')||'-'||INITCAP(c.dvrun) AS "RUN CLIENTE",
    INITCAP(c.pnombre||' '||CONCAT(SUBSTR(c.snombre,0,1),'.'||' '||c.appaterno||' '||c.apmaterno)) AS "NOMBRE CLIENTE",
    TRUNC(SUM(ttc.monto_total_transaccion)/tc.cupo_disp_sp_avance) AS "TOTAL DE SUPER AVANCE VIGENTE",
    TO_CHAR(SUM(ttc.monto_total_transaccion),'$99G999G999') AS "MONTO TOTAL SUPER AVANCE"
FROM cliente c
    INNER JOIN tarjeta_cliente tc ON tc.numrun = c.numrun
    LEFT JOIN transaccion_tarjeta_cliente ttc ON ttc.nro_tarjeta = tc.nro_tarjeta
WHERE ttc.cod_tptran_tarjeta = 103
GROUP BY c.numrun,dvrun,pnombre,snombre,appaterno,apmaterno,tc.cupo_disp_sp_avance
ORDER BY appaterno
;

--CASO N°6 INFORME N°1