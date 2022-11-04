--GUÍA N°4


--CASO N°1


SELECT
TO_CHAR (numrun_cli, '99G999G999')||'-'||dvrun_cli AS "RUN CLIENTE",
INITCAP(appaterno_cli)||' '||SUBSTR(apmaterno_cli ,0,1)|| '.'||INITCAP(pnombre_cli) AS "NOMBRE CLIENTE",
direccion AS "DIRECCIÓN",
NVL(TO_CHAR(fono_fijo_cli), 'NO POSEE FONO FIJO') AS "FONO FIJO",
NVL(TO_CHAR(celular_cli), 'NO POSEE CELULAR') AS "CELULAR",
id_comuna AS "COMUNA"
FROM cliente
ORDER BY id_comuna ASC, appaterno_cli DESC
;

--CASO N°2

SELECT
'El empleado'||' '||pnombre_emp||' '||appaterno_emp||' '||apmaterno_emp|| ' estuvo de cumpleaños el '|| EXTRACT(DAY FROM fecha_nac)||' de '||
INITCAP(TO_CHAR(FECHA_NAC,'MONTH'))||'Cumplió'||' '|| ROUND(MONTHS_BETWEEN(SYSDATE,FECHA_NAC)/12)||' '||'AÑOS' AS "CUMPLEAÑOS" 
FROM empleado
;

--CASO N°3

SELECT T.NOMBRE_TIPO_CAMION AS "TIPO CAMION",
C.NRO_PATENTE AS "NRO PATENTE",
C.ANIO AS "AÑO",
TO_CHAR(C.VALOR_ARRIENDO_DIA,'$99G999') AS "VALOR ARRIENDO DIA",
NVL(TO_CHAR(C.VALOR_GARANTIA_DIA,'$999G999'),0) AS "VALOR GARANTIA DIA",
NVL(TO_CHAR(C.VALOR_ARRIENDO_DIA+C.VALOR_GARANTIA_DIA,'$999G999'),0) AS "VALOR TOTAL DIA"
FROM CAMION C
JOIN TIPO_CAMION T ON C.ID_TIPO_CAMION = T.ID_TIPO_CAMION
ORDER BY T.NOMBRE_TIPO_CAMION,C.VALOR_ARRIENDO_DIA DESC, C.VALOR_GARANTIA_DIA ASC
;

--CASO N°4
SELECT TO_CHAR(sysdate,'MM/yyyy') AS FECHA,
TO_CHAR(numrun_emp,'99G999G999') ||'-'||dvrun_emp AS "RUN EMPLEADO" ,
pnombre_emp||' '||snombre_emp||' '||appaterno_emp||' '||apmaterno_emp,
TO_CHAR(sueldo_base,'$99G999G999') AS "SUELDO BASE",
CASE WHEN sueldo_base>320000 AND sueldo_base<450000 THEN TO_CHAR((20000000*0.05),'$99G999G999')
    WHEN sueldo_base>450001 AND sueldo_base<600000 THEN TO_CHAR((20000000*0.035),'$99G999G999')
    WHEN sueldo_base>600001 AND sueldo_base<900000 THEN TO_CHAR((20000000*0.025),'$99G999G999')
    WHEN sueldo_base>900001 AND sueldo_base<1800000 THEN TO_CHAR((20000000*0.015),'$99G999G999')
    WHEN sueldo_base>1800001 THEN TO_CHAR((20000000*0.01),'$99G999G999')
    END "BONIFICACION"
FROM empleado
ORDER BY appaterno_emp
;

--CASO N°5
SELECT numrun_emp ||'-'||dvrun_emp AS "RUN EMPLEADO",
pnombre_emp||' '||snombre_emp||' '||appaterno_emp||' '||apmaterno_emp AS "NOMBRE EMPLEADO",
TRUNC((SYSDATE-fecha_contrato)/365) AS "AÑOS CONTRATADO",
TO_CHAR(sueldo_base,'$99G999G999') AS "SUELDO BASE",
CASE WHEN sueldo_base>=450000 THEN TO_CHAR((sueldo_base*(TRUNC((SYSDATE-fecha_contrato)/365)/100)),'$99G999G999')
    WHEN sueldo_base<450000 THEN TO_CHAR((sueldo_base*(TRUNC((SYSDATE-fecha_contrato)/365)/100)),'$99G999G999')   
END "VALOR MOVILIZACION",
CASE WHEN sueldo_base>=450000 THEN TO_CHAR((sueldo_base*(SUBSTR(sueldo_base,0,1)/100)),'$99G999G999')
    WHEN sueldo_base<450000 THEN TO_CHAR((sueldo_base*(SUBSTR(sueldo_base,0,2)/100)),'$99G999G999')
END "BONIF. EXTRA MOVILIZACIÓN",
CASE WHEN sueldo_base>=450000 THEN TO_CHAR((sueldo_base*(SUBSTR(sueldo_base,0,1)/100))+(sueldo_base*(TRUNC((SYSDATE-fecha_contrato)/365)/100)),'$99G999G999')
    WHEN sueldo_base<450000 THEN TO_CHAR((sueldo_base*(SUBSTR(sueldo_base,0,2)/100))+(sueldo_base*(TRUNC((SYSDATE-fecha_contrato)/365)/100)),'$99G999G999')
END "VALOR MOVILIZACIÓN TOTAL" 
FROM empleado
WHERE id_comuna IN (117,118,120,122,126)
;

--CASO N°6

SELECT EXTRACT(YEAR FROM SYSDATE) AS "AÑO TRIBUTARIO",
TO_CHAR(numrun_emp,'99G999G999') ||'-'||dvrun_emp AS "RUN EMPLEADO",
pnombre_emp||' '||snombre_emp||' '||appaterno_emp||' '||apmaterno_emp AS "NOMBRE EMPLEADO",
TRUNC((SYSDATE-TO_DATE('01/01/22'))/31) AS "MESES TRABAJADOS EN EL AÑO",
TRUNC((SYSDATE-fecha_contrato)/365) AS "AÑOS TRABAJADOS",
sueldo_base AS "SUELDO BASE MENSUAL",
sueldo_base*12 AS "SUELDO BASE ANUAL",
TRUNC(sueldo_base*(TRUNC((SYSDATE-fecha_contrato)/365)/100))*12 AS "BONO POR AÑOS ANUAL",
TRUNC(sueldo_base*0.12)*12 AS "MOVILIZACION ANUAL",
TRUNC(sueldo_base*0.20)*12 AS "COLACION ANUAL",
TRUNC(((sueldo_base*0.20)+(sueldo_base*0.12)+sueldo_base+(sueldo_base*(TRUNC((SYSDATE-fecha_contrato)/365)/100)))*12) AS "SUELDO BRUTO ANUAL",
TRUNC((sueldo_base+sueldo_base*(TRUNC((SYSDATE-fecha_contrato)/365)/100))*12) AS "RENTA IMPONIBLE ANUAL"
FROM empleado
ORDER BY numrun_emp
;