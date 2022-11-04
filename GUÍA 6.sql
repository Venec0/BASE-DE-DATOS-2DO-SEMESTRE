--CASO N°1
SELECT 
TO_CHAR(C.numrun,'09G999G999')||'-'||C.dvrun AS "RUN CLIENTE",
INITCAP(C.pnombre)||' '||INITCAP(C.snombre)||' '||INITCAP(C.appaterno)||' '||INITCAP(C.apmaterno) AS "nombre CLIENTE",
PO.nombre_prof_ofic AS "PROFESION/OFICIO",
TO_CHAR(C.fecha_nacimiento,'DD')||' de '||TO_CHAR(C.fecha_nacimiento,'month') AS "FECHA NACIMIENTO"
FROM CLIENTE C
JOIN PROFESION_OFICIO PO ON PO.cod_prof_ofic = C.cod_prof_ofic
WHERE EXTRACT(MONTH FROM C.fecha_nacimiento) = 9
ORDER BY "FECHA NACIMIENTO" ASC, C.appaterno
;

--CASO N°2
SELECT 
TO_CHAR(C.numrun,'09G999G999')||'-'||C.dvrun AS "RUN CLIENTE",
C.pnombre||' '||C.snombre||' '||C.appaterno||' '||C.apmaterno AS "nombre CLIENTE",
TO_CHAR(SUM(CC.monto_solicitado),'$99G999G999') AS "MONTO SOLICITADO",
TO_CHAR((SUM(CC.monto_solicitado)/100000)*1200,'$99G999G999') AS "TOTAL PESOS TODOSUMA"
FROM cliente C
JOIN credito_cliente CC ON CC.nro_cliente = C.nro_cliente
WHERE EXTRACT(YEAR FROM CC.fecha_solic_cred) = EXTRACT(YEAR FROM SYSDATE)-1
GROUP BY C.numrun, C.dvrun, C.pnombre,C.snombre,C.appaterno,C.apmaterno
ORDER BY "TOTAL PESOS TODOSUMA" ASC, appaterno DESC
;

--CASO N°3
SELECT TO_CHAR(CC.fecha_solic_cred,'mmyyyy') AS "MES TRANSACCION",
C.nombre_credito AS "TIPO credito",
SUM(monto_credito) AS "MONTO SOLICITADO credito",
CASE WHEN SUM(monto_credito) BETWEEN 100000 AND 1000000 THEN SUM(monto_credito)*0.01
WHEN SUM(monto_credito) BETWEEN 1000001 AND 2000000 THEN SUM(monto_credito)*0.02
WHEN SUM(monto_credito) BETWEEN 2000001 AND 4000000 THEN SUM(monto_credito)*0.03
WHEN SUM(monto_credito) BETWEEN 4000001 AND 6000000 THEN SUM(monto_credito)*0.04
WHEN SUM(monto_credito) > 6000000 THEN SUM(monto_credito)*0.07
END "APORTE A LA SBIF"
FROM credito_cliente CC
JOIN credito C ON C.COD_credito = CC.COD_credito
WHERE EXTRACT(YEAR FROM fecha_solic_cred) = EXTRACT(YEAR FROM SYSDATE)-1
GROUP BY TO_CHAR(CC.fecha_solic_cred,'mmyyyy'),C.nombre_credito
ORDER BY "MES TRANSACCION","TIPO credito"
;

--CASO N°4
SELECT 
TO_CHAR(numrun,'09G999G999')||'-'||dvrun AS "RUT CLIENTE",
pnombre||' '||snombre||' '||appaterno||' '||apmaterno AS "nombre DEL CLIENTE",
TO_CHAR(SUM(PIC.monto_total_ahorrado),'$99G999G999') AS "MONTO TOTAL AHORRADO",
CASE WHEN SUM(PIC.monto_total_ahorrado) BETWEEN 100000 AND 1000000 THEN 'BRONCE'
WHEN SUM(PIC.monto_total_ahorrado) BETWEEN 1000001 AND 4000000 THEN 'PLATA'
WHEN SUM(PIC.monto_total_ahorrado) BETWEEN 4000001 AND 8000000 THEN 'SILVER'
WHEN SUM(PIC.monto_total_ahorrado) BETWEEN 8000001 AND 15000000 THEN 'GOLD'
WHEN SUM(PIC.monto_total_ahorrado) > 15000000 THEN 'PLATINUM'
END "CATEGORIA CLIENTE"
FROM cliente C
JOIN producto_inversion_cliente PIC ON PIC.nro_cliente = C.nro_cliente
GROUP BY numrun,dvrun,pnombre,snombre,appaterno,apmaterno
ORDER BY appaterno ASC, "MONTO TOTAL AHORRADO" DESC
;

--CASO N°5
SELECT 
EXTRACT(YEAR FROM SYSDATE) AS "AÑO TRIBUTARIO",
TO_CHAR(numrun,'09G999G999')||'-'||dvrun AS "RUT CLIENTE",
INITCAP(pnombre)||' '||SUBSTR(snombre,0,1)||'. '||INITCAP(appaterno)||' '||INITCAP(apmaterno) AS "nombre DEL CLIENTE",
COUNT(PIC.nro_cliente) AS "TOTAL PROD. INV AFECTADOS IMPTO",
TO_CHAR(SUM(PIC.monto_total_ahorrado),'$99G999G999') AS "MONTO TOTAL AHORRADO"
FROM cliente C
JOIN producto_inversion_cliente PIC ON PIC.nro_cliente = C.nro_cliente
HAVING SUM(PIC.monto_total_ahorrado) > 7833186 
GROUP BY EXTRACT(YEAR FROM SYSDATE), numrun,dvrun,pnombre,snombre,appaterno,apmaterno
ORDER BY appaterno
;

--CASO N°6 PARTE N°1
SELECT 
TO_CHAR(numrun,'09G999G999')||'-'||dvrun AS "RUT CLIENTE",
INITCAP(pnombre)||' '||INITCAP(snombre)||' '||INITCAP(appaterno)||' '||INITCAP(apmaterno) AS "nombre DEL CLIENTE",
COUNT(CC.nro_cliente) AS "TOTAL creditoS SOLICITADOS",
RTRIM(TO_CHAR(SUM(CC.monto_solicitado),'$99G999G999')) AS "MONTO TOTAL creditoS"
FROM cliente C
JOIN credito_cliente CC ON CC.nro_cliente = C.nro_cliente
WHERE EXTRACT(YEAR FROM FECHA_OTORGA_CRED) = EXTRACT(YEAR FROM SYSDATE)-1
GROUP BY numrun, dvrun, pnombre,snombre,appaterno,apmaterno
ORDER BY appaterno
;

--CASO N°6 PARTE N°2
SELECT TO_CHAR(numrun,'09G999G999')||'-'||dvrun AS "RUT CLIENTE",
INITCAP(pnombre)||' '||INITCAP(snombre)||' '||INITCAP(appaterno)||' '||INITCAP(apmaterno) AS "nombre DEL CLIENTE",
COALESCE(TO_CHAR(MAX(CASE WHEN m.cod_tipo_mov = 1 THEN m.monto_movimiento 
                            ELSE null END), 'L99g999g999'), 'No realizó') AS "ABONO",
COALESCE(TO_CHAR(MAX(CASE WHEN m.cod_tipo_mov = 2 THEN m.monto_movimiento 
                            ELSE null END), 'L99g999g999'), 'No realizó') AS "RESCATES"
FROM cliente C
JOIN movimiento M ON M.nro_cliente = C.nro_cliente
WHERE EXTRACT(YEAR FROM M.FECHA_MOVIMIENTO) = EXTRACT(YEAR FROM SYSDATE)
GROUP BY TO_CHAR(numrun,'09G999G999')||'-'||dvrun, pnombre,snombre,appaterno,apmaterno
ORDER BY appaterno;