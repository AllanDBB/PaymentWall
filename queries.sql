-- listar todos los usuarios de la plataforma que esten activos con su nombre completo,
--  email, país de procedencia, y el total de cuánto han pagado en subscripciones desde el 2024 hasta el día de hoy, dicho monto debe ser en colones (20+ registros)
SELECT 
    CONCAT(u.firstName, ' ', u.lastName) AS fullName,
    u.email,
    c.name AS country,
    SUM(pp.amount) AS totalPaid
FROM 
    PW_users u
JOIN 
    PW_userPlan up ON u.userId = up.userId
JOIN 
    PW_planPrice pp ON up.planPriceId = pp.planPriceId
JOIN 
    PW_userAddress ua ON u.userId = ua.userId
JOIN 
    PW_address a ON ua.addressId = a.addressId
JOIN 
    PW_cities ci ON a.cityId = ci.cityId
JOIN 
    PW_states s ON ci.stateId = s.stateId
JOIN 
    PW_countries c ON s.countryId = c.countryId
WHERE 
    up.enabled = 1 
    AND pp.recurrencyType IN (1, 2)  
    AND pp.postTime >= '2024-01-01'  
GROUP BY 
    u.userId, u.firstName, u.lastName, u.email, c.name 
HAVING 
    totalPaid > 0
ORDER BY 
    totalPaid DESC;
    
-- listar todas las personas con su nombre completo e email, los cuales le queden menos de 15 días para tener que volver a pagar una nueva subscripción (13+ registros)
SELECT 
    CONCAT(u.firstName, ' ', u.lastName) AS fullName,
    u.email AS email
FROM 
    PW_users u
JOIN 
    PW_userPlan up ON u.userId = up.userId
JOIN 
    PW_planPrice pp ON up.planPriceId = pp.planPriceId
WHERE 
    up.enabled = 1 
    AND pp.recurrencyType IN (1, 2, 3, 4)  
    AND (
        (pp.recurrencyType = 1 AND DATE_ADD(up.acquisition, INTERVAL 1 MONTH) <= NOW() + INTERVAL 15 DAY) OR 
        (pp.recurrencyType = 2 AND DATE_ADD(up.acquisition, INTERVAL 1 YEAR) <= NOW() + INTERVAL 15 DAY)    
    )
ORDER BY 
    up.acquisition ASC;  

-- un ranking del top 15 de usuarios que más uso le dan a la aplicación y el top 15 que menos uso le dan a la aplicación (15 y 15 registros)

SELECT 'PW_users' AS tabla, COUNT(*) AS total FROM PW_users
UNION ALL
SELECT 'PW_Payments', COUNT(*) FROM PW_Payments
UNION ALL
SELECT 'PW_transactions', COUNT(*) FROM PW_transactions;

-- Más usuarios
SELECT 
    u.userId,
    CONCAT(u.firstName, ' ', u.lastName) AS fullName,
    u.email,
    COUNT(t.transactionId) AS transactionCount
FROM 
    PW_users u
JOIN 
    PW_Payments p ON u.userId = p.userId 
JOIN 
    PW_transactions t ON p.paymentId = t.paymentId  
GROUP BY 
    u.userId, u.firstName, u.lastName, u.email
ORDER BY 
    transactionCount DESC
LIMIT 15;

-- Menos usuarios
SELECT 
    u.userId,
    CONCAT(u.firstName, ' ', u.lastName) AS fullName,
    u.email,
    COUNT(t.transactionId) AS transactionCount
FROM 
    PW_users u
LEFT JOIN 
    PW_Payments p ON u.userId = p.userId 
LEFT JOIN 
    PW_transactions t ON p.paymentId = t.paymentId  
GROUP BY 
    u.userId, u.firstName, u.lastName, u.email
ORDER BY 
    transactionCount ASC
LIMIT 15;


-- 4.4 determinar cuáles son los análisis donde más está fallando la AI, encontrar los casos, situaciones, interpretaciones, halucinaciones o errores donde el usuario está teniendo más problemas en hacer que la AI determine correctamente lo que se desea hacer, rankeando cada problema de mayor a menor cantidad de ocurrencias entre un rango de fechas (30+ registros)

SELECT 
    CASE 
        WHEN description LIKE '%falso positivo%' THEN 'Falso positivo en fraude'
        WHEN description LIKE '%falso negativo%' THEN 'Falso negativo en fraude'
        WHEN description LIKE '%recomendación inválida%' THEN 'Recomendación inválida'
        WHEN description LIKE '%Sesgo racial%' THEN 'Sesgo racial detectado'
        WHEN description LIKE '%Sesgo detectado%' THEN 'Sesgo en modelo'
        WHEN description LIKE '%carga de modelo%' THEN 'Error carga modelo'
        WHEN description LIKE '%conectividad%' THEN 'Problema de conectividad'
        WHEN description LIKE '%tiempo de respuesta%' THEN 'Tiempo de respuesta excedido'
        WHEN description LIKE '%preprocesamiento%' THEN 'Error preprocesamiento'
        WHEN description LIKE '%reentrenamiento%' THEN 'Necesidad reentrenamiento'
        ELSE 'Otro error'
    END AS tipo_fallo,
    COUNT(*) AS cantidad_ocurrencias,
    AVG(CASE WHEN logSeverityId = 2 THEN 1 ELSE 0 END) * 100 AS porcentaje_advertencias,
    AVG(CASE WHEN logSeverityId = 3 THEN 1 ELSE 0 END) * 100 AS porcentaje_errores,
    AVG(CASE WHEN logSeverityId = 4 THEN 1 ELSE 0 END) * 100 AS porcentaje_criticos,
    MIN(posttime) AS primera_ocurrencia,
    MAX(posttime) AS ultima_ocurrencia,
    GROUP_CONCAT(DISTINCT 
        CASE 
            WHEN description LIKE '%falso positivo%' THEN SUBSTRING_INDEX(SUBSTRING_INDEX(value1, 'Confianza:', -1), '%', 1)
            WHEN description LIKE '%recomendación inválida%' THEN SUBSTRING_INDEX(SUBSTRING_INDEX(value1, 'Recomendación inválida:', -1), ',', 1)
            WHEN description LIKE '%Sesgo%' THEN SUBSTRING_INDEX(SUBSTRING_INDEX(value1, 'categoría:', -1), ',', 1)
            ELSE SUBSTRING(value1, 1, 30)
        END
    SEPARATOR ' | ') AS detalles_clave
FROM 
    (SELECT * FROM PW_Logs WHERE logSourcesId = 5) AS logs_ia
GROUP BY 
    tipo_fallo
ORDER BY 
    cantidad_ocurrencias DESC;


