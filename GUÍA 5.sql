--GUÍA N°5

--CASO N°1
SELECT carreraid AS "IDENTIFICACION DE LA CARRERA",
COUNT(carreraid) AS "TOTAL alumnoS MATRICULADOS",
'Le corresponden '||TRIM(TO_CHAR(30200*COUNT(carreraid),'$99G999G999'))||' del presupuesto total asignado para la publicidad' AS "MONTO POR PUBLICIDAD"
FROM alumno
GROUP BY carreraid
ORDER BY COUNT(carreraid) DESC
;

--CASO N°2
SELECT carreraid AS CARRERA,
COUNT(carreraid) AS  "TOTAL DE alumnoS"
FROM alumno
GROUP BY carreraid
HAVING COUNT(carreraid)>4
ORDER BY carreraid
;

--CASO N°3
SELECT TO_CHAR(run_jefe,'09G999G999') AS "RUN JEFE SIN DV",
COUNT(run_jefe) AS "TOTAL empleadoS A SU CARGO",
TO_CHAR(MAX(salario),'99G999G999') AS "salario MAXIMO",
COUNT(run_jefe)*10||'% del salario maximo' AS "PORCENTAJE DE BONIFICACION",
TO_CHAR(MAX(salario)*((COUNT(run_jefe)*10)/100),'$99G999G999') AS "BONIFICACION"
FROM empleado
WHERE run_jefe IS NOT NULL
GROUP BY run_jefe
ORDER BY COUNT(run_jefe) ASC
;

--CASO N°4
SELECT id_escolaridad,
CASE WHEN id_escolaridad = 10 THEN 'BÁSICA'
WHEN id_escolaridad = 20 THEN 'MEDIA CIENTÍFICA HUMANISTA'
WHEN id_escolaridad = 30 THEN 'MEDIA TÉCNICO PROFESIONAL'
WHEN id_escolaridad = 40 THEN 'SUPERIOR CENTRO DE FORMACIÓN TÉCNICA'
WHEN id_escolaridad = 50 THEN 'SUPERIOR INSTITUTO PROFESIONAL'
WHEN id_escolaridad = 60 THEN 'SUPERIOR UNIVERSIDAD'
END AS "DESCRIPCION ESCOLARIDAD",
COUNT(id_escolaridad) AS "TOTAL DE empleadoS",
TO_CHAR(MAX(salario),'$99G999G999') AS "salario MAXIMO",
TO_CHAR(MIN(salario),'$99G999G999') AS "salario MINIMO",
TO_CHAR(SUM(salario),'$99G999G999') AS "salario TOTAL",
TO_CHAR(ROUND(AVG(salario)),'$99G999G999') AS "salario PROMEDIO"
FROM empleado
GROUP BY id_escolaridad
ORDER BY COUNT(id_escolaridad) DESC
;

--CASO N°5
SELECT tituloid AS "CODIGO DEL LIBRO",
COUNT(tituloid) AS "TOTAL DE VECES SOLICITADO",
CASE WHEN COUNT(tituloid)=1 THEN 'No se requiere nuevos ejemplares'
WHEN COUNT(tituloid) BETWEEN 2 AND 3 THEN 'Se requiere comprar 1 nuevos ejemplares'
WHEN COUNT(tituloid) BETWEEN 4 AND 5 THEN 'Se requiere comprar 2 nuevos ejemplares'
WHEN COUNT(tituloid)>5 THEN 'Se requiere comprar 4 nuevos ejemplares'
END AS "SUGERENCIA"
FROM prestamo
WHERE EXTRACT(YEAR FROM fecha_ini_prestamo)=2021
GROUP BY tituloid
ORDER BY COUNT(tituloid) DESC
;

--CASO N°6
SELECT TO_CHAR(run_emp,'09G999G999') AS "RUN empleado",
to_char(fecha_ini_prestamo,'MM/yyyy') AS "MES prestamo LIBRO",
COUNT(run_emp) AS "TOTAL DE prestamoS",
TO_CHAR(COUNT(run_emp)*10000,'$99G999G999') AS "ASIGNACION POR prestamo"
FROM prestamo
WHERE EXTRACT(YEAR FROM fecha_ini_prestamo) = 2021
GROUP BY run_emp,to_char(fecha_ini_prestamo,'MM/yyyy')
HAVING COUNT(*)>=3
ORDER BY to_char(fecha_ini_prestamo,'MM/yyyy') ASC,"ASIGNACION POR PRESTAMO" DESC,run_emp DESC
;