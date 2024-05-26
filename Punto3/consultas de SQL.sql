-- Consulta 1:  Deuda total de Tarjeta de Crédito por Franquicia. 
SELECT 
    pc.numero_tarjeta AS Numero_Tarjeta,
    pc.franquicia AS Franquicia,
    SUM(pc.cupo_aprobado - pc.cupo_disponible) AS Deuda_Total,
    pu.nombres AS Nombres,
    pu.tipo_usuario AS Tipo_Usuario
FROM tarjeta_credito pc
JOIN persona_unificada pu ON pc.usuId = pu.usuId
GROUP BY pc.numero_tarjeta, pc.franquicia, pu.nombres, pu.tipo_usuario;

-- Consulta 2: Cliente con mayor Saldo en Canje
SELECT 
    p.nombres,
    p.tipo_usuario,
    MAX(ca.saldo_canje) AS mayor_saldo_canje
FROM 
    cuenta_ahorro ca
JOIN 
    cuenta_ahorro_usuarios cau ON ca.numero_cuenta = cau.numero_cuenta
JOIN 
    persona_unificada p ON cau.usuId = p.usuId
GROUP BY 
    p.nombres, p.tipo_usuario
ORDER BY 
    mayor_saldo_canje DESC
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;

-- Consulta 3:  Cliente con mayor saldo retirado de una Cuenta de Ahorros en un periodo determinado. (Por fecha de transacción)
SELECT
    p.nombres,
    p.tipo_usuario,
    ca.numero_cuenta,
    SUM(mca.monto) AS saldo_retirado_total
FROM
    movimientos_cuenta_ahorro mca
JOIN
    cuenta_ahorro ca ON mca.numero_cuenta = ca.numero_cuenta
JOIN
    cuenta_ahorro_usuarios cau ON ca.numero_cuenta = cau.numero_cuenta
JOIN
    persona_unificada p ON cau.usuId = p.usuId
WHERE
    mca.tipo_movimiento = 'RETIRO'
    AND mca.fecha_transaccion BETWEEN '2024-01-01' AND '2024-05-31'  -- Período determinado
GROUP BY
    p.nombres, p.tipo_usuario, ca.numero_cuenta
ORDER BY
    saldo_retirado_total DESC
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;

-- Consulta 4: Cuenta de Ahorro con mayor número de titulares
SELECT
    cau.numero_cuenta,
    COUNT(cau.usuId) AS cantidad_titulares
FROM
    cuenta_ahorro_usuarios cau
GROUP BY
    cau.numero_cuenta
ORDER BY
    cantidad_titulares DESC
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;

-- Consulta 5: Saldo Total de todas las cuentas de ahorro de un cliente
SELECT
    pu.usuId,
    pu.nombres AS nombre_cliente,
    pu.tipo_usuario AS tipo_cliente,
    SUM(ca.saldo_total) AS saldo_total_cuentas
FROM
    cuenta_ahorro_usuarios cau
JOIN
    cuenta_ahorro ca ON cau.numero_cuenta = ca.numero_cuenta
JOIN
    persona_unificada pu ON cau.usuId = pu.usuId
GROUP BY
    pu.usuId, pu.nombres, pu.tipo_usuario;

-- Consulta 6: Numero de Cuentas de Ahorro activas de clientes extranjeros
SELECT
    COUNT(DISTINCT cau.numero_cuenta) AS num_cuentas_ahorro_activas_extranjeros,
    pu.nombres AS nombre_usuario,
    pu.tipo_usuario AS tipo_usuario
FROM
    cuenta_ahorro_usuarios cau
JOIN
    persona_unificada pu ON cau.usuId = pu.usuId
JOIN
    cuenta_ahorro ca ON cau.numero_cuenta = ca.numero_cuenta
WHERE
    pu.tipo_documento_id = 3  -- Tipo de documento id para extranjeros
    AND ca.estado = 'ACTIVA'  -- Cuentas de ahorro activas
GROUP BY
    pu.usuId, pu.nombres, pu.tipo_usuario;

-- Consulta 7: Listado de Accionistas que son clientes con su correspondiente Saldo Total de Deuda de todas las tarjetas de crédito cuyo Saldo Total de Deuda sea mayor a UN MILLÓN DE PESOS
SELECT
    pu.nombres AS nombre_accionista,
    SUM(tc.cupo_aprobado - tc.cupo_disponible) AS saldo_total_deuda
FROM
    composicion_accionaria ca
JOIN
    tarjeta_credito tc ON ca.accionista_id = tc.usuId
JOIN
    persona_unificada pu ON ca.accionista_id = pu.usuId
WHERE
    tc.cupo_aprobado - tc.cupo_disponible > 1000000
GROUP BY
    pu.usuId, pu.nombres;
