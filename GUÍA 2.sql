--GUÍA N°2
--CASO N°1
--EJEMPLO N°1

SELECT
DISTINCT
fecter_arriendo AS "FECHA ENTREGA PROPIEDAD"
FROM propiedad_arrendada
WHERE EXTRACT (year from fecter_arriendo) = 2022
ORDER BY fecter_arriendo ASC
;

--EJEMPLO N°2:

SELECT
DISTINCT
fecini_arriendo AS "FECHA INICIO ARRIENDO"
FROM propiedad_arrendada
WHERE EXTRACT (year from fecini_arriendo)= 2022
ORDER BY fecini_arriendo ASC
;

--CASO N°2:

SELECT
numrut_cli||' - '|| dvrut_cli AS "RUT CLIENTE",
nombre_cli||' '|| appaterno_cli||' '|| apmaterno_cli AS "NOMBRE CLIENTE",
renta_cli AS "RENTA",
fonofijo_cli AS "TELÉFONO FIJO",
celular_cli AS "CELULAR"
FROM cliente
WHERE id_estcivil = 1
    OR (id_estcivil in (3, 4) AND renta_cli >=800000 )
ORDER BY appaterno_cli ASC, nombre_cli ASC
;

--CASO N°3:

--SIMULACIÓN N°1:

SELECT
numrut_emp || '-' || dvrut_emp AS "RUN EMPLEADO",
nombre_emp || ' ' || appaterno_emp || ' ' || apmaterno_emp AS "NOMBRE EMPLEADO",
sueldo_emp AS "SUELDO ACTUAL",
sueldo_emp *1.085 AS "SALARIO REAJUSTADO",
sueldo_emp *0.085 AS "AUMENTO"
FROM empleado
ORDER BY sueldo_emp *0.085 DESC, appaterno_emp ASC
;

--SIMULACIÓN N°2:

SELECT
numrut_emp || '-' || dvrut_emp AS "RUN EMPLEADO",
nombre_emp || ' ' || appaterno_emp || ' ' || apmaterno_emp AS "NOMBRE EMPLEADO",
sueldo_emp AS "SALARIO ACTUAL",
sueldo_emp *1.2 AS "SALARIO REAJUSTADO",
sueldo_emp *0.2 AS "AUMENTO"
FROM empleado
WHERE sueldo_emp BETWEEN 200000 AND 400000
ORDER BY sueldo_emp *0.2 DESC, appaterno_emp ASC
;

-- CASO N°4

SELECT
numrut_emp || '-' || dvrut_emp AS "RUN EMPLEADO",
nombre_emp || ' ' || appaterno_emp || ' ' || apmaterno_emp AS "NOMBRE EMPLEADO",
sueldo_emp AS "SALARIO ACTUAL",
sueldo_emp *0.2 AS "BONIFICACION"
FROM empleado
WHERE sueldo_emp < 500000 AND ID_CATEGORIA_EMP <> 3
ORDER BY appaterno_emp ASC
;

-- CASO N°5
-- PRUEBA N°1

SELECT
nro_propiedad as "NUMERO PROPIEDAD",
fecha_entrega_propiedad as "FECHA ENTREGA PROPIEDAD",
direccion_propiedad as "DIRECCION",
superficie as "SUPERFICIE",
nro_dormitorios as "CANTIDAD DE DORMITORIOS",
nro_banos as "CANTIDAD DE BAÑOS",
valor_arriendo as "VALOR ARRIENDO"
FROM propiedad
WHERE EXTRACT(year from fecha_entrega_propiedad) = 2022
ORDER BY fecha_entrega_propiedad ASC, nro_propiedad asc
;