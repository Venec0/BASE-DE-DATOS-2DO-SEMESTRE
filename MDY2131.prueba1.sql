SELECT
*
FROM camion
;

SELECT
*
FROM tipo_salud
;
--PRUEBA N°1:

--CASO N°1:

SELECT
nro_patente AS "PATENTE",
color AS "COLOR",
anio AS "AÑO",
valor_arriendo_dia AS "VALOR DIARIO DEL ARRIENDO"
FROM camion
ORDER BY anio ASC, nro_patente ASC
;

--CASO N°2:

SELECT
nro_patente AS "PATENTE",
id_marca AS "MARCA",
motor AS "CILINDRADA",
EXTRACT(year
FROM SYSDATE)-anio AS "AÑOS EN SERVICIO",
color AS "COLOR"
FROM camion
WHERE color = '&color'
ORDER BY EXTRACT(YEAR FROM SYSDATE)-ANIO ASC
;

--CASO N°3:

SELECT
LOWER(pnombre_emp)||' '||UPPER(snombre_emp)||' '||INITCAP(appaterno_emp)||' '||INITCAP(apmaterno_emp) AS "EMPLEADO",
TO_CHAR(fecha_contrato, 'dd" de "MONTH" del "yyyy') AS "ECHA CONTRATO",
TO_CHAR(sueldo_base, '$999G9999') AS "SUELDO BASE",
TO_CHAR(sueldo_base*tipo_salud.pct_sueldo, '$99,999,000.00') AS "DESCUENTO SALUD"
FROM empleado, tipo_salud
ORDER BY sueldo_base ASC
;

