--GUÍA N°3

--CASO N°1

SELECT
TO_CHAR(numrun_cli, '99G999G999')||'-'||dvrun_cli AS "RUN CLIENTE",
LOWER(pnombre_cli)||' '|| INITCAP(snombre_cli)||' '|| appaterno_cli||' '|| apmaterno_cli AS "NOMBRE COMPLETO CLIENTE",
TO_CHAR (fecha_nac_cli +1, 'DD/MM/YYYY') "FECHA NACIMIENTO"
FROM cliente
WHERE EXTRACT(DAY FROM fecha_nac_cli) = 20 AND EXTRACT(MONTH FROM fecha_nac_cli) = 08
;

--CASO N°2
SELECT
TO_CHAR(numrun_emp, '99G999G999')||' '||dvrun_emp AS "RUN EMPLEADO",
pnombre_emp||' '||snombre_emp||' '||appaterno_emp||' '||apmaterno_emp AS "NOMBRE COMPLETO EMPLEADO",
sueldo_base AS "SUELDO BASE",
ROUND (sueldo_base/100000) AS "PORCENTAJE MOVILIZACIÓN",
(ROUND(sueldo_base/100000)/100*sueldo_base) AS "VALOR MOVILIZACIÓN",
fecha_nac AS "FECHA NACIMIENTO",
SUBSTR(pnombre_emp, 0, 3)||''|| LENGTH(pnombre_emp)||'*'||dvrun_emp||''||ROUND((SYSDATE-fecha_contrato)/7) AS "NOMBRE USUARIO"
FROM empleado
ORDER BY ROUND(sueldo_base/100000) DESC
;


--CASO N°3

SELECT
numrun_emp||' '||dvrun_emp AS "RUN EMPLEADO",
pnombre_emp||' '||snombre_emp||' '||appaterno_emp||' '||apmaterno_emp AS "NOMBRE COMPLETO EMPLEADO",
sueldo_base AS "SUELDO BASE",
fecha_nac AS "FECHA NACIMIENTO",
SUBSTR(pnombre_emp, 1, 3)||LENGTH(pnombre_emp)||'*'||SUBSTR(sueldo_base,-1,1)||dvrun_emp||ROUND(MONTHS_BETWEEN(SYSDATE,fecha_contrato)/12) "USUARIO DEL EMPLEADO",
SUBSTR(numrun_emp,3,1)||EXTRACT(YEAR FROM fecha_contrato)+2||SUBSTR(sueldo_base,-2,2)-1||SUBSTR(appaterno_emp,-1,1)||EXTRACT(MONTH FROM SYSDATE) "CLAVE DEL EMPLEADO" 
FROM empleado
ORDER BY appaterno_emp
;

--CASO N°4

CREATE TABLE hist_rebaja_arriendo
AS SELECT 
nro_patente,
anio,
valor_arriendo_dia,
valor_garantia_dia
FROM camion
;

SELECT 
EXTRACT(YEAR FROM SYSDATE) "AÑO PROCESO",
nro_patente "NUMERO DE PATENTE",
valor_arriendo_dia "VALOR ARRIENDO DÍA SR", 
valor_garantia_dia "VALOR GARANTÍA DÍA SR",
EXTRACT(YEAR FROM SYSDATE)-anio "AÑOS DE ANTIGUEDAD",
    (1-((EXTRACT(YEAR FROM SYSDATE)-anio)/100))*valor_arriendo_dia "VALOR ARRIENDO DIA CR", 
    (1-((EXTRACT(YEAR FROM SYSDATE)-anio)/100))*valor_garantia_dia "VALOR GARANTIA CR"
FROM  hist_rebaja_arriendo
WHERE EXTRACT(YEAR FROM SYSDATE)-anio>5
ORDER BY EXTRACT(YEAR FROM SYSDATE)-anio DESC
;


--CASO N°5

SELECT
TO_CHAR(SYSDATE, 'MM/YYYY') "MES_ANNO_PROCESO",
nro_patente "NUMERO DE PATENTE",
fecha_ini_arriendo "FECHA INICIO ARRIENDO",
fecha_devolucion "FECHA DE DEVOLUCION",
CASE
WHEN (EXTRACT(DAY FROM fecha_devolucion)-(EXTRACT(DAY FROM fecha_ini_arriendo)+DIAS_SOLICITADOS)) <= '0' THEN 0
ELSE (EXTRACT(DAY FROM fecha_devolucion)-(EXTRACT(DAY FROM fecha_ini_arriendo)+DIAS_SOLICITADOS)) END "DIAS DE ATRASO",
25000*(EXTRACT(DAY FROM fecha_devolucion)-(EXTRACT(DAY FROM fecha_ini_arriendo)+DIAS_SOLICITADOS)) "VALOR DE MULTA"
FROM ARRIENDO_CAMION
WHERE EXTRACT(MONTH FROM fecha_ini_arriendo) = EXTRACT(MONTH FROM SYSDATE)-1
ORDER BY fecha_ini_arriendo, nro_patente ASC

