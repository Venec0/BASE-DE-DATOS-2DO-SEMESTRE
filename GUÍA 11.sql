SELECT
    cli.numrun||'-'||cli.dvrun AS "RUN CLIENTE",
    cli.pnombre||' '||cli.snombre||' '||cli.appaterno||' '||cli.apmaterno AS "NOMBRE CLIENTE",
    po.nombre_prof_ofic AS "PROFESIÓN U OFICIO",
    tc.nombre_tipo_contrato AS "TIPO CONTRATO"
FROM mdy2131_p11_1.cliente cli
    JOIN profesion_oficio po ON cli.cod_prof_ofic = po.cod_prof_ofic
    JOIN tipo_contrato tc ON cli.cod_tipo_contrato = tc.cod_tipo_contrato
;

SELECT
*
FROM mdy2131_p11_1.tipo_contrato