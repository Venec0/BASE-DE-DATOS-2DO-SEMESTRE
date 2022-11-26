--CASO N�1

SELECT
    TO_CHAR(cli.numrun, '99G999G999')||'-'||INITCAP(cli.dvrun) AS "RUN CLIENTE",
    INITCAP(cli.pnombre||' '||cli.snombre||' '||cli.appaterno||' '||cli.apmaterno) AS "NOMBRE CLIENTE",
    TO_CHAR(cli.fecha_nacimiento, 'dd "de" MONTH"') AS "DIA DE CUMPLEA�OS", --= EXTRACT(MONTH FROM SYSDATE+1)"AS D�A DE CUMPLEA�OS"
    cli.direccion||', '||com.nombre_comuna AS "DIRECCI�N CLIENTE"
FROM mdy2131_p12_1.cliente cli
    JOIN comuna com ON cli.cod_comuna = com.cod_comuna
    JOIN provincia pro ON com.cod_provincia = pro.cod_provincia
    JOIN region reg ON pro.cod_region = reg.cod_region
GROUP BY cli.numrun, cli.dvrun
        ,cli.pnombre, snombre, cli.appaterno, cli.apmaterno
        ,cli.fecha_nacimiento
        ,cli.direccion 
        ,com.nombre_comuna
ORDER BY "DIA DE CUMPLEA�OS" ASC ,cli.appaterno ASC
;

--CORREGIR GROUP BY
--HACER QUE SE EJECUTE LA SENTENCIA DE "DIA DE CUMPLEA�OS TENIENDO EN CUENTA UN MES DESPU�S DE EJECUCI�N"

SELECT
*
FROM mdy2131_p12_1.comuna