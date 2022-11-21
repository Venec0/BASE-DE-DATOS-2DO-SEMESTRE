--CASO N°1

SELECT
    cli.numrun||'-'||INITCAP(cli.dvrun) AS "RUN CLIENTE",
    cli.pnombre||' '||cli.snombre||' '||cli.appaterno||' '||cli.apmaterno AS "NOMBRE CLIENTE",
    po.nombre_prof_ofic AS "PROFESIÓN U OFICIO",
    tc.nombre_tipo_contrato AS "TIPO CONTRATO",
    TO_CHAR(SUM(pic.monto_total_ahorrado), '$99G999G999') AS "MONTO TOTAL AHORRADO",
    CASE WHEN SUM(pic.monto_total_ahorrado) BETWEEN 0 AND 1000000 THEN 'BRONCE'
    WHEN SUM(pic.monto_total_ahorrado) BETWEEN 1000001 AND 4000000 THEN 'PLATA'
    WHEN SUM(pic.monto_total_ahorrado) BETWEEN 4000001 AND 8000000 THEN 'SILVER'
    WHEN SUM(pic.monto_total_ahorrado) BETWEEN 8000001 AND 15000000 THEN 'GOLD'
    WHEN SUM(pic.monto_total_ahorrado) > 15000000 THEN 'PLATINUM'
    END "CATEGORIZACIÓN CLIENTE"
FROM mdy2131_p11_1.cliente cli
    JOIN profesion_oficio po ON cli.cod_prof_ofic = po.cod_prof_ofic
    JOIN tipo_contrato tc ON cli.cod_tipo_contrato = tc.cod_tipo_contrato
    JOIN producto_inversion_cliente pic ON cli.nro_cliente = pic.nro_cliente
GROUP BY  cli.numrun, cli.dvrun
    , cli.pnombre, cli.snombre, cli.appaterno, cli.apmaterno
    , po.nombre_prof_ofic
    , tc.nombre_tipo_contrato
ORDER BY cli.appaterno ASC, "MONTO TOTAL AHORRADO" DESC
;

--CASO N°2

SELECT
    TO_CHAR(mov.fecha_movimiento, 'mmyyyy')-1 AS "MES TRANSACCIÓN",
    UPPER(c.nombre_credito) AS "TIPO CREDITO"
FROM mdy2131_p11_1.movimiento mov
    JOIN producto_inversion_cliente pic ON mov.nro_solic_prod = pic.nro_solic_prod
    JOIN cliente cli ON pic.nro_cliente = cli.nro_cliente
    JOIN credito_cliente cc ON cli.nro_cliente = cc.nro_cliente
    JOIN credito c ON cc.cod_credito = c.cod_credito
;

--VER DE QUÉ MANERA HACER APARECER ÚNICAMENTE CRÉDITO HIPOTECARIO, CONSUMO Y AUTOMOTRIZ.
--VER CÓMO AGREGAR APORTE A SBIF.

