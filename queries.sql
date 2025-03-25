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
    AND pp.recurrencyType IN (1, 2, 3, 4)  -- Considerando mensual y anual
    AND (
        (pp.recurrencyType = 1 AND DATE_ADD(up.acquisition, INTERVAL 1 MONTH) <= NOW() + INTERVAL 15 DAY) OR 
        (pp.recurrencyType = 2 AND DATE_ADD(up.acquisition, INTERVAL 1 YEAR) <= NOW() + INTERVAL 15 DAY)    
    )
ORDER BY 
    up.acquisition ASC;  

-- un ranking del top 15 de usuarios que más uso le dan a la aplicación y el top 15 que menos uso le dan a la aplicación (15 y 15 registros)

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






