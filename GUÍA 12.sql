--CASO N°1

SELECT
    TO_CHAR(cli.numrun, '99G999G999')||'-'||INITCAP(cli.dvrun) AS "RUN CLIENTE",
    INITCAP(cli.pnombre||' '||cli.snombre||' '||cli.appaterno||' '||cli.apmaterno) AS "NOMBRE CLIENTE",
    TO_CHAR(cli.fecha_nacimiento, 'dd "de" MONTH"') AS "DÍA DE CUMPLEAÑOS",
    cli.direccion||', '||com.nombre_comuna AS "DIRECCIÓN CLIENTE"
FROM mdy2131_p12_1.cliente cli
    JOIN comuna com ON cli.cod_comuna = com.cod_comuna
                    AND cli.cod_provincia = com.cod_provincia
                    AND cli.cod_region = com.cod_region
    WHERE EXTRACT(MONTH FROM cli.fecha_nacimiento) = EXTRACT(MONTH FROM SYSDATE)+1
GROUP BY cli.numrun, cli.dvrun
        ,cli.pnombre, snombre, cli.appaterno, cli.apmaterno
        ,cli.fecha_nacimiento
        ,cli.direccion 
        ,com.nombre_comuna
ORDER BY "DÍA DE CUMPLEAÑOS" ASC ,cli.appaterno ASC
;


--CASO N°2

SELECT
    TO_CHAR
FROM mdy2131_p12_1.cliente cli
;