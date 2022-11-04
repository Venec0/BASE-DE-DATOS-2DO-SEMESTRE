--GUÍA N°1

--CASO N°1
SELECT
    'El Empleado'||' '|| nombre_emp||' '|| appaterno_emp||' '|| apmaterno_emp||' nació el '|| fecnac_emp AS "LISTADO DE CUMPLEAÑOS"
FROM empleado
ORDER BY fecnac_emp ASC, appaterno_emp ASC
;


--CASO N°2

SELECT
numrut_cli AS "NUMERO RUT",
dvrut_cli AS "DIGITO VERIFICADOR",
nombre_cli ||' '|| appaterno_cli ||' '|| apmaterno_cli AS "NOMBRE CLIENTE",
renta_cli AS "RENTA",
fonofijo_cli AS "TELEFONO FIJO",
celular_cli AS "CELULAR"
FROM cliente
ORDER BY appaterno_cli ASC, apmaterno_cli ASC
;

--CASO N°3
SELECT 
nombre_emp ||' '|| appaterno_emp ||' '|| apmaterno_emp AS "NOMBRE EMPLEADO", 
sueldo_emp AS "SUELDO" , (sueldo_emp/2) AS "BONO POR CAPACITACION"
FROM empleado
ORDER BY "BONO POR CAPACITACION" DESC
;

--CASO N°4

SELECT 
nro_propiedad as "NUMERO DE PROPIEDAD", 
numrut_prop as "RUT PROPIETARIO", 
direccion_propiedad as "DIRECCION ", 
valor_arriendo as "VALOR ARRIENDO" , (valor_arriendo*0.054) as "COMPENSACION"
FROM propiedad
ORDER BY "RUT PROPIETARIO" ASC
;

--CASO N°5

SELECT 
numrut_emp || '-' || dvrut_emp AS "RUN EMPLEADO", 
nombre_emp || ' ' || appaterno_emp || ' ' || apmaterno_emp AS "NOMBRE EMPLEADO", 
sueldo_emp AS "SALARIO ACTUAL",
(Sueldo_emp*1.13) AS "SALARIO REAJUSTADO", 
(sueldo_emp*1.13 - sueldo_emp) AS "REAJUSTE"
FROM empleado
ORDER BY "SALARIO REAJUSTADO" DESC, appaterno_emp
; 

--CASO N°6
SELECT nombre_emp || ' ' || appaterno_emp || ' ' || apmaterno_emp AS "NOMBRE EMPLEADO", 
sueldo_emp AS "SALARIO", (sueldo_emp*0.055) AS "COLACIÓN", 
(sueldo_emp*0.178) AS "MOVILIZACIÓN", 
sueldo_emp*0.078 AS "SALUD", 
sueldo_emp*0.065 AS "AFP", 
(sueldo_emp + sueldo_emp*0.055 + sueldo_emp*0.178 - sueldo_emp*0.078 - sueldo_emp*0.065) AS "ALCANCE LIQUIDO"
FROM empleado 
ORDER BY appaterno_emp AS