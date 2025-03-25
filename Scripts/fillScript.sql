
-- Fill company table
INSERT INTO PW_company (name, type) VALUES
('Eat-Easy APP', 'Tecnología'),
('Akurey.', 'Tecnología 4k'),
('Global Foods Ltd.', 'Alimentos'),
('HealthCare Partners', 'Salud'),
('Creative Designs Co.', 'Diseño');

SELECT * FROM PW_company;

-- Fill user table:
INSERT INTO PW_users (firstName, lastName, email, createdAt, updatedAt, PW_company_companyId)
SELECT 
    CONCAT('NombreCool', FLOOR(RAND() * 1000)) AS firstName,
    CONCAT('ApellidoAburrido', FLOOR(RAND() * 1000)) AS lastName,
    CONCAT('usuario', (@row := @row + 1), '@paymentwall.com') AS email,
    NOW() - INTERVAL FLOOR(RAND() * 365) DAY AS createdAt,
    NOW() - INTERVAL FLOOR(RAND() * 365) DAY AS updatedAt,
    FLOOR(1 + RAND() * 5) AS PW_company_companyId
FROM 
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) AS dummy
CROSS JOIN 
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) AS dummy2
CROSS JOIN 
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8) AS dummy3
CROSS JOIN 
    (SELECT @row := 0) AS row_counter
LIMIT 40;

SELECT * FROM PW_users;

-- Fill roles:
INSERT INTO PW_roles (roleName, roleDescription)
VALUES
    ('Admin', 'Administrator with full access to all features.'),
    ('User', 'Regular user with limited access to features.'),
    ('Moderator', 'User who can moderate content and manage users.'),
    ('Manager', 'User with permission to manage specific sections or features.'),
    ('Guest', 'User with minimal access to view content only.');

SELECT * FROM PW_roles;

-- Fill countries :) (Solo puse los que primero se me vinieron a la mente)
INSERT INTO PW_countries (countryId, name, isoCode, phoneCode)
VALUES
    (1, 'United States', 'US', '+1'),
    (2, 'Canada', 'CA', '+1'),
    (3, 'Mexico', 'MX', '+52'),
    (4, 'Germany', 'DE', '+49'),
    (5, 'France', 'FR', '+33'),
    (6, 'United Kingdom', 'GB', '+44'),
    (7, 'Australia', 'AU', '+61'),
    (8, 'Japan', 'JP', '+81'),
    (9, 'Brazil', 'BR', '+55'),
    (10, 'India', 'IN', '+91');

SELECT * FROM PW_countries;

-- Fill states:
-- Fun fact para el que revise investigando estados descubrí que Francia se divide en 13 regiones :0 (República francesa) y pues francia es: Île-de-France, ahí un dato nuevo :)
INSERT INTO PW_states (name, countryId)
VALUES
    ('California', 1),
    ('Ontario', 2),
    ('Jalisco', 3),
    ('Bavaria', 4),
    ('Île-de-France', 5),
    ('England', 6),
    ('New South Wales', 7),
    ('Tokyo', 8),
    ('São Paulo', 9),
    ('Maharashtra', 10);

SELECT * FROM PW_states;

-- Fill cities
INSERT INTO PW_cities (name, stateId)
VALUES
    ('Los Angeles', 1),
    ('Toronto', 2),
    ('Guadalajara', 3),
    ('Munich', 4),
    ('Paris', 5),
    ('London', 6),
    ('Sydney', 7),
    ('Osaka', 8),
    ('Rio de Janeiro', 9),
    ('Mumbai', 10);

SELECT * FROM PW_cities;

-- Fill currencies
INSERT INTO PW_currency (name, acronym, symbol, countryId)
VALUES
    ('US Dollar', 'USD', '$', 1),
    ('Canadian Dollar', 'CAD', '$', 2),
    ('Mexican Peso', 'MXN', '$', 3),
    ('Euro', 'EUR', '€', 4),
    ('French Franc', 'FRF', '₣', 5),
    ('British Pound', 'GBP', '£', 6),
    ('Australian Dollar', 'AUD', '$', 7),
    ('Japanese Yen', 'JPY', '¥', 8),
    ('Brazilian Real', 'BRL', 'R$', 9),
    ('Indian Rupee', 'INR', '₹', 10);
    
SELECT * FROM PW_currency;

-- exchange rate
INSERT INTO PW_exchangeRate (startDate, changeDate, PW_exchangeRatecol, enabled, currentChange, baseCurrencyId, conversionCurrencyId)
SELECT 
    NOW() - INTERVAL FLOOR(RAND() * 365) DAY AS startDate,
    NOW() AS changeDate,
    CONCAT(c1.acronym, '_TO_', c2.acronym) AS PW_exchangeRatecol,
    1 AS enabled,
    CASE WHEN RAND() > 0.5 THEN 1 ELSE 0 END AS currentChange,
    c1.currencyId AS baseCurrencyId,
    c2.currencyId AS conversionCurrencyId
FROM 
    PW_currency c1
CROSS JOIN 
    PW_currency c2
WHERE 
    c1.currencyId != c2.currencyId
ORDER BY 
    RAND()
LIMIT 20;

-- Contact types:
INSERT INTO PW_contactType (contactTypeId, name, format)
VALUES
    (1, 'Email', 'example@domain.com'),
    (2, 'Phone', '+1-XXX-XXX-XXXX'),
    (3, 'Fax', '+1-XXX-XXX-XXXX'),
    (4, 'Address', '1234 Main St, City, Country'),
    (5, 'Social Media', '@username');

SELECT * FROM PW_contactType;

-- Fill contactInfo table:
SET @row := (SELECT IFNULL(MAX(contactInfoId), 0) FROM PW_contactInfo);

INSERT INTO PW_contactInfo (contactInfoId, contactTypeId, value, isPrimary, verifiedAt, updatedAt)
SELECT 
    (@row := @row + 1) AS contactInfoId,  
    contactTypeId,
    CASE 
        WHEN contactTypeId = 1 THEN CONCAT('user', FLOOR(RAND() * 1000))  
        WHEN contactTypeId = 2 THEN FLOOR(RAND() * 9000000000) + 1000000000  
        WHEN contactTypeId = 3 THEN FLOOR(RAND() * 9000000000) + 1000000000  
        WHEN contactTypeId = 4 THEN CONCAT(FLOOR(RAND() * 1000) + 100, ' Main St, City, Country')  
        WHEN contactTypeId = 5 THEN CONCAT('username', FLOOR(RAND() * 1000))  
    END AS value,
    FLOOR(RAND() * 2) AS isPrimary,  -- Randomly 0 or 1
    NOW() - INTERVAL FLOOR(RAND() * 365) DAY AS verifiedAt, 
    NOW() - INTERVAL FLOOR(RAND() * 365) DAY AS updatedAt
FROM 
    (SELECT 1 AS contactTypeId UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) AS dummy
CROSS JOIN 
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) AS dummy2
CROSS JOIN 
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8) AS dummy3
LIMIT 60;

SELECT * FROM PW_contactInfo;

-- user contact. (PD: Cree 60 contactos, entonces, si yo tengo 40 usuarios, pues de es 1:1, por eso, no sé si esto encaja en "random", por eso uso el union, pero si es un poco brusco meter los 40, pero no literal. En fin, espero este bien.
SET @row := (SELECT IFNULL(MAX(userContactId), 0) FROM PW_userContact);

INSERT INTO PW_userContact (userContactId, contactInfoId, userId)
SELECT 
    (@row := @row + 1) AS userContactId, 
    contactInfoId,
    userId
FROM 
    (SELECT 1 AS contactInfoId, 1 AS userId UNION SELECT 2, 2 UNION SELECT 3, 3 UNION SELECT 4, 4 
     UNION SELECT 5, 5 UNION SELECT 6, 6 UNION SELECT 7, 7 UNION SELECT 8, 8 UNION SELECT 9, 9 
     UNION SELECT 10, 10 UNION SELECT 11, 11 UNION SELECT 12, 12 UNION SELECT 13, 13 UNION SELECT 14, 14 
     UNION SELECT 15, 15 UNION SELECT 16, 16 UNION SELECT 17, 17 UNION SELECT 18, 18 UNION SELECT 19, 19 
     UNION SELECT 20, 20 UNION SELECT 21, 21 UNION SELECT 22, 22 UNION SELECT 23, 23 UNION SELECT 24, 24 
     UNION SELECT 25, 25 UNION SELECT 26, 26 UNION SELECT 27, 27 UNION SELECT 28, 28 UNION SELECT 29, 29 
     UNION SELECT 30, 30 UNION SELECT 31, 31 UNION SELECT 32, 32 UNION SELECT 33, 33 UNION SELECT 34, 34 
     UNION SELECT 35, 35 UNION SELECT 36, 36 UNION SELECT 37, 37 UNION SELECT 38, 38 UNION SELECT 39, 39 
     UNION SELECT 40, 40) AS user_contact_pairs;

SELECT * FROM PW_userContact;

-- Services.
INSERT INTO PW_services (name, keywords, category, description, Cuenta_Iban)
VALUES
    ('Servicio de Jardinería', 'césped, poda, jardín', 'Hogar', 'Mantenimiento de jardines y áreas verdes.', 12345678),
    ('Reparación de Computadoras', 'hardware, software, PC', 'Tecnología', 'Diagnóstico y reparación de computadoras.', 23456789),
    ('Clases de Yoga', 'yoga, meditación, salud', 'Salud y Bienestar', 'Sesiones de yoga para todos los niveles.', 34567890),
    ('Transporte Privado', 'taxi, transporte, viaje', 'Transporte', 'Servicio de transporte privado en la ciudad.', 45678901),
    ('Diseño Gráfico', 'logos, branding, diseño', 'Creativo', 'Creación de logotipos y material publicitario.', 56789012);

 SELECT * FROM PW_services;

-- Languages.
INSERT INTO PW_languages (languageId, name, culture)
VALUES
    (1, 'Español', 'es-ES'),
    (2, 'Inglés', 'en-US'),
    (3, 'Francés', 'fr-FR'),
    (4, 'Alemán', 'de-DE'),
    (5, 'Italiano', 'it-IT');
    
SELECT * FROM PW_languages;

-- Information.
INSERT INTO PW_infoTypes (name)
VALUES
    ('Género'),
    ('Fecha de Nacimiento'),
    ('Tipo de Empresa'),
    ('Número de Empleados'),
    ('Industria');
    
-- Info types.
SELECT * FROM PW_infoTypes;

INSERT INTO PW_info (value, enabled, lastUpdate, paymentMethodId, infoTypeId)
VALUES
    ('Masculino', 1, NOW(), 1, 1),
    ('1990-05-12', 1, NOW(), 2, 2),
    ('Startup', 1, NOW(), 3, 3),
    ('50-100', 1, NOW(), 4, 4),
    ('Tecnología', 1, NOW(), 5, 5);
    
SELECT * FROM PW_info;


-- payment methods
INSERT INTO PW_paymentMethods (name, apiURL, secretkey, `key`, logoIconUrl, enabled)
VALUES
    ('PayPal', 'https://api.paypal.com', AES_ENCRYPT('secret1', 'key1'), AES_ENCRYPT('key1', 'key1'), 'https://example.com/paypal.png', b'1'),
    ('Stripe', 'https://api.stripe.com', AES_ENCRYPT('secret2', 'key2'), AES_ENCRYPT('key2', 'key2'), 'https://example.com/stripe.png', b'1'),
    ('Visa', 'https://api.visa.com', AES_ENCRYPT('secret3', 'key3'), AES_ENCRYPT('key3', 'key3'), 'https://example.com/visa.png', b'1'),
    ('Mastercard', 'https://api.mastercard.com', AES_ENCRYPT('secret4', 'key4'), AES_ENCRYPT('key4', 'key4'), 'https://example.com/mastercard.png', b'1'),
    ('Bitcoin', 'https://api.bitcoin.com', AES_ENCRYPT('secret5', 'key5'), AES_ENCRYPT('key5', 'key5'), 'https://example.com/bitcoin.png', b'1'),
    ('Apple Pay', 'https://api.apple.com', AES_ENCRYPT('secret6', 'key6'), AES_ENCRYPT('key6', 'key6'), 'https://example.com/applepay.png', b'1');
    
SELECT * FROM PW_paymentMethods;

-- modules
INSERT INTO PW_modules (moduleId, name)
VALUES
	(1, 'Usuarios'),
    (2, 'Pagos'),
    (3, 'Reportes'),
    (4, 'Productos'),
    (5, 'Pedidos'),
    (6, 'Idiomas'),
    (7, 'IA');

SELECT * FROM PW_modules;

-- permissions
INSERT INTO PW_permissions (name, description, code, createdAt, updatedAt, moduleId, htmlObject)
VALUES
    ('Ver Usuarios', 'Permite ver la lista de usuarios', 'USR_V', NOW(), NOW(), 1, '<button>Ver Usuarios</button>'),
    ('Editar Usuarios', 'Permite editar información de usuarios', 'USR_E', NOW(), NOW(), 1, '<button>Editar Usuario</button>'),
    ('Eliminar Usuarios', 'Permite eliminar un usuario', 'USR_D', NOW(), NOW(), 1, '<button>Eliminar Usuario</button>'),
    ('Ver Pagos', 'Permite ver transacciones de pago', 'PAY_V', NOW(), NOW(), 2, '<button>Ver Pagos</button>'),
    ('Procesar Pago', 'Permite procesar pagos manualmente', 'PAY_P', NOW(), NOW(), 2, '<button>Procesar Pago</button>'),
    ('Generar Reportes', 'Permite generar reportes financieros', 'REP_G', NOW(), NOW(), 3, '<button>Generar Reporte</button>'),
    ('Exportar Reportes', 'Permite exportar reportes a Excel/PDF', 'REP_E', NOW(), NOW(), 3, '<button>Exportar Reporte</button>'),
    ('Agregar Producto', 'Permite agregar productos al catálogo', 'PRD_A', NOW(), NOW(), 4, '<button>Agregar Producto</button>'),
    ('Modificar Producto', 'Permite editar información de productos', 'PRD_M', NOW(), NOW(), 4, '<button>Modificar Producto</button>'),
    ('Eliminar Pedido', 'Permite cancelar o eliminar pedidos', 'ORD_D', NOW(), NOW(), 5, '<button>Eliminar Pedido</button>');

SELECT * FROM PW_permissions;    

-- user permissions
INSERT INTO PW_userPermissions (userPermissionsId, enabled, deleted, lastUpdate, userName, checksum, permissionId, userId)
SELECT 
    (@row := @row + 1) AS userPermissionsId, 1 AS enabled, 0 AS deleted,
    NOW() - INTERVAL FLOOR(RAND() * 365) DAY AS lastUpdate,
    CONCAT('user', user_id) AS userName,
    UNHEX(SHA1(CONCAT(user_id, '-', permission_id))) AS checksum,
    permission_id AS permissionId,
    user_id AS userId
FROM (
    SELECT 
        u.user_id, 11 + FLOOR(RAND() * 10) AS permission_id 
    FROM (
        SELECT 1 AS user_id UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION
        SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION
        SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION
        SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20 UNION
        SELECT 21 UNION SELECT 22 UNION SELECT 23 UNION SELECT 24 UNION SELECT 25 UNION
        SELECT 26 UNION SELECT 27 UNION SELECT 28 UNION SELECT 29 UNION SELECT 30 UNION
        SELECT 31 UNION SELECT 32 UNION SELECT 33 UNION SELECT 34 UNION SELECT 35 UNION
        SELECT 36 UNION SELECT 37 UNION SELECT 38 UNION SELECT 39 UNION SELECT 40
    ) AS u
    CROSS JOIN (
        -- Esto nos ayuda a generar 3 registros por usuario
        SELECT 1 AS n UNION SELECT 2 UNION SELECT 3
    ) AS counts
    ORDER BY u.user_id, permission_id
) AS combinations
CROSS JOIN (SELECT @row := 0) AS row_counter
GROUP BY user_id, permission_id 
HAVING COUNT(*) = 1  
LIMIT 120; 

-- permissions for roles
SET @row = 0;
INSERT INTO PW_rolePermissions (rolePermissionId, enabled, deleted, lastUpdate, userName, checksum, permissionId, roleId)
SELECT 
    (@row := @row + 1) AS rolePermissionId, 1 AS enabled,
    0 AS deleted,
    NOW() AS lastUpdate,
    CONCAT('role', roleId) AS userName,
    UNHEX(SHA1(CONCAT(roleId, '-', permissionId))) AS checksum,
    permissionId,
    roleId
FROM (
    SELECT r.roleId, p.permissionId
    FROM (
        SELECT 1 AS roleId UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
    ) r
    CROSS JOIN (
        SELECT 11 AS permissionId UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 
        UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20
    ) p
    WHERE FLOOR(RAND() * 10) < 4
    LIMIT 15
) AS data;

SELECT * FROM PW_rolePermissions;

-- user Roles
SET @row = 0;
INSERT INTO PW_userRoles (roleId, userId, lastUpdated, userName, checksum, enabled, deleted)
SELECT 
FLOOR(1 + RAND() * 5) AS roleId,
u.userId,
NOW() - INTERVAL FLOOR(RAND() * 365) DAY AS lastUpdated,
CONCAT('user', u.userId) AS userName,
UNHEX(SHA1(CONCAT(u.userId, '-', FLOOR(1 + RAND() * 5)))) AS checksum,
1 AS enabled,
0 AS deleted
FROM (
SELECT 1 AS userId UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION
SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION
SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION
SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20 UNION
SELECT 21 UNION SELECT 22 UNION SELECT 23 UNION SELECT 24 UNION SELECT 25 UNION
SELECT 26 UNION SELECT 27 UNION SELECT 28 UNION SELECT 29 UNION SELECT 30 UNION
SELECT 31 UNION SELECT 32 UNION SELECT 33 UNION SELECT 34 UNION SELECT 35 UNION
SELECT 36 UNION SELECT 37 UNION SELECT 38 UNION SELECT 39 UNION SELECT 40
) u
ORDER BY RAND()
LIMIT 60;

SELECT * FROM PW_userRoles;

-- User services.
INSERT INTO PW_userServices (serviceId, userId)
SELECT 
FLOOR(1 + RAND() * 5) AS serviceId, 
user_id AS userId
FROM (
SELECT 1 AS user_id UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION
SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION
SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION
SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20 UNION
SELECT 21 UNION SELECT 22 UNION SELECT 23 UNION SELECT 24 UNION SELECT 25 UNION
SELECT 26 UNION SELECT 27 UNION SELECT 28 UNION SELECT 29 UNION SELECT 30 UNION
SELECT 31 UNION SELECT 32 UNION SELECT 33 UNION SELECT 34 UNION SELECT 35 UNION
SELECT 36 UNION SELECT 37 UNION SELECT 38 UNION SELECT 39 UNION SELECT 40
) users
CROSS JOIN (
SELECT 1 AS n UNION SELECT 2 UNION SELECT 3
) counts
WHERE FLOOR(RAND() * 2) = 0
GROUP BY user_id, serviceId
HAVING COUNT(*) = 1
LIMIT 80;

SELECT * FROM PW_userServices;

-- Media types
INSERT INTO PW_mediaTypes (mediaTypeId, name, playerimpl) VALUES 
(1, 'Video', 'HTML5VideoPlayer'),
(2, 'Audio', 'HTML5AudioPlayer'),
(3, 'Image', 'ImageGalleryPlayer'),
(4, 'Document', 'PDFViewerPlayer'),
(5, 'Stream', 'VideoStreamPlayer');

SELECT * FROM PW_mediaTypes;

-- List of media file.
INSERT INTO PW_mediafiles (filename, fileUrl, fileSizeMB, deleted, createdAt, updatedAt, mediaTypeId)
SELECT 
    file_data.filename,
    CONCAT('https://cdn.example.com/media/', 
           CASE file_data.mediaTypeId
               WHEN 1 THEN 'videos/'
               WHEN 2 THEN 'audios/' 
               WHEN 3 THEN 'images/'
               WHEN 4 THEN 'docs/'
               WHEN 5 THEN 'streams/'
           END,
           file_data.filename) AS fileUrl,
    FLOOR(1 + RAND() * 50) AS fileSizeMB,
    0 AS deleted,
    NOW() - INTERVAL FLOOR(RAND() * 365) DAY AS createdAt,
    NOW() - INTERVAL FLOOR(RAND() * 100) DAY AS updatedAt,
    file_data.mediaTypeId
FROM (
    SELECT 
        mediaTypeId,
        CONCAT(
            CASE mediaTypeId
                WHEN 1 THEN 'video_'
                WHEN 2 THEN 'audio_'
                WHEN 3 THEN 'image_' 
                WHEN 4 THEN 'doc_'
                WHEN 5 THEN 'stream_'
            END,
            FLOOR(1 + RAND() * 1000),
            CASE mediaTypeId
                WHEN 1 THEN '.mp4'
                WHEN 2 THEN '.mp3'
                WHEN 3 THEN '.jpg' 
                WHEN 4 THEN '.pdf'
                WHEN 5 THEN '.m3u8'
            END
        ) AS filename
    FROM (
        SELECT 1 AS mediaTypeId UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
    ) types
    CROSS JOIN (
        SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4
    ) multiplier
) AS file_data
ORDER BY RAND()
LIMIT 20;

SELECT * FROM PW_mediafiles;

-- Suscriptions
INSERT INTO PW_suscriptions (description, logoURL) VALUES 
('Basic Plan', 'https://example.com/logos/basic.png'),
('Premium Plan', 'https://example.com/logos/premium.png'),
('Enterprise Plan', 'https://example.com/logos/enterprise.png');

-- Suscriptions Features
INSERT INTO PW_planFeatures (description, enabled, dateType) VALUES 
('Acceso ilimitado a contenido básico', 1, 'monthly'),
('Descarga de archivos multimedia', 1, 'monthly'),
('Streaming en alta calidad', 1, 'monthly'),
('Soporte prioritario 24/7', 1, 'yearly'),
('Almacenamiento en la nube 50GB', 1, 'yearly'),
('Acceso exclusivo a eventos', 1, 'weekly'),
('Perfiles múltiples (hasta 5)', 1, 'monthly'),
('Contenido premium sin anuncios', 1, 'monthly');

-- Features per plan
INSERT INTO PW_featuresPerPlan (featurePerPlanId, value, enabled, planFeatureId, suscriptionId)
SELECT 
    (@row := @row + 1) AS featurePerPlanId,
    CASE 
        WHEN pf.planFeatureId IN (1, 6) THEN 'Ilimitado'
        WHEN pf.planFeatureId IN (2, 7) THEN 'Disponible'
        WHEN pf.planFeatureId = 3 THEN CONCAT(FLOOR(1 + RAND() * 4), 'K Ultra HD')
        WHEN pf.planFeatureId = 4 THEN '24/7'
        WHEN pf.planFeatureId = 5 THEN CONCAT(FLOOR(10 + RAND() * 91), 'GB')
        ELSE 'Activo'
    END AS value,
    1 AS enabled,
    pf.planFeatureId,
    s.suscriptionId
FROM 
    (SELECT 1 AS suscriptionId UNION SELECT 2 UNION SELECT 3) s
CROSS JOIN 
    PW_planFeatures pf
CROSS JOIN 
    (SELECT @row := 0) r
WHERE 
    (s.suscriptionId = 1 AND pf.planFeatureId IN (1, 2, 5)) OR
    (s.suscriptionId = 2 AND pf.planFeatureId IN (1, 2, 3, 5, 6)) OR
    (s.suscriptionId = 3 AND pf.planFeatureId IN (1, 2, 3, 4, 5, 6, 7))
ORDER BY 
    s.suscriptionId, pf.planFeatureId;
    
SELECT * FROM PW_featuresPerPlan;

-- Plan prices
INSERT INTO PW_planPrice (amount, recurrencyType, postTime, endDate, currencyId, suscriptionId) VALUES 
-- Basic Plan (ID 1)
(499, 1, NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR), 1, 1),
(4999, 2, NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR), 1, 1),

-- Premium Plan (ID 2)
(1299, 1, NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR), 1, 2),
(12990, 2, NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR), 1, 2),

-- Enterprise Plan (ID 3)
(2999, 1, NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR), 1, 3),
(29990, 2, NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR), 1, 3);

SELECT * FROM PW_planPrice;

-- Schedules
INSERT INTO PW_schedules (name, recurrencyType, repetions, endtype, repit, endDate) VALUES
('Mensual Standard', 1, NULL, 1, 1, DATE_ADD(NOW(), INTERVAL 1 YEAR)),
('Anual Standard', 2, NULL, 1, 1, DATE_ADD(NOW(), INTERVAL 2 YEAR)),
('Mensual Premium', 1, NULL, 1, 1, DATE_ADD(NOW(), INTERVAL 1 YEAR)),
('Anual Premium', 2, NULL, 1, 1, DATE_ADD(NOW(), INTERVAL 2 YEAR)),
('Trimestral Basic', 3, NULL, 1, 1, DATE_ADD(NOW(), INTERVAL 6 MONTH));

-- Schedule Details
INSERT INTO PW_scheduleDetails (scheduleDetailsId, deleted, baseDate, datepart, lastExecute, nextExecute, scheduleId)
SELECT 
    (@row := @row + 1) AS scheduleDetailsId,
    0 AS deleted,
    NOW() - INTERVAL FLOOR(RAND() * 180) DAY AS baseDate,
    CASE 
        WHEN s.recurrencyType = 1 THEN 'MONTH'
        WHEN s.recurrencyType = 2 THEN 'YEAR' 
        WHEN s.recurrencyType = 3 THEN 'QUARTER'
    END AS datepart,
    NOW() - INTERVAL FLOOR(RAND() * 30) DAY AS lastExecute,
    CASE 
        WHEN s.recurrencyType = 1 THEN DATE_ADD(NOW(), INTERVAL 1 MONTH)
        WHEN s.recurrencyType = 2 THEN DATE_ADD(NOW(), INTERVAL 1 YEAR)
        WHEN s.recurrencyType = 3 THEN DATE_ADD(NOW(), INTERVAL 3 MONTH)
    END AS nextExecute,
    s.scheduleId
FROM 
    PW_schedules s
CROSS JOIN 
    (SELECT 1 AS n UNION SELECT 2 UNION SELECT 3) AS multiplier
CROSS JOIN 
    (SELECT @row := 0) AS r
ORDER BY 
    s.scheduleId
LIMIT 15;

-- User plans
SET @schedule_count = (SELECT COUNT(*) FROM PW_schedules);
SET @plan_price_count = (SELECT COUNT(*) FROM PW_planPrice);

INSERT INTO PW_userPlan (userPlanId, acquisition, enabled, planPriceId, userId, scheduleId)
SELECT 
    (@row := @row + 1) AS userPlanId,
    NOW() - INTERVAL FLOOR(RAND() * 180) DAY AS acquisition,
    1 AS enabled,
    FLOOR(1 + RAND() * @plan_price_count) AS planPriceId,
    user_id AS userId,
    FLOOR(1 + RAND() * @schedule_count) AS scheduleId
FROM (
    SELECT user_id FROM (
        SELECT 1 AS user_id UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION
        SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION
        SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION
        SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20 UNION
        SELECT 21 UNION SELECT 22 UNION SELECT 23 UNION SELECT 24 UNION SELECT 25 UNION
        SELECT 26 UNION SELECT 27 UNION SELECT 28 UNION SELECT 29 UNION SELECT 30 UNION
        SELECT 31 UNION SELECT 32 UNION SELECT 33 UNION SELECT 34 UNION SELECT 35 UNION
        SELECT 36 UNION SELECT 37 UNION SELECT 38 UNION SELECT 39 UNION SELECT 40
    ) users
    ORDER BY RAND()
    LIMIT 25
) AS selected_users
CROSS JOIN (SELECT @row := 0) AS row_counter;

SELECT * FROM PW_userPlan;

-- User Plan Limit
INSERT INTO PW_userPlanLimit (`limit`, userPlanId, planFeatureId)
SELECT FLOOR(1+RAND()*10) AS `limit`, userPlanId, planFeatureId FROM (
SELECT up.userPlanId, pf.planFeatureId FROM PW_userPlan up
CROSS JOIN PW_planFeatures pf
WHERE (
(up.scheduleId IN(1,3) AND pf.planFeatureId IN(1,2,5)) OR
(up.scheduleId IN(2,4) AND pf.planFeatureId IN(1,2,3,5,6)) OR
(up.scheduleId=5 AND pf.planFeatureId IN(1,2,3,4,5,6,7))
)
AND up.userPlanId BETWEEN 1 AND 60
ORDER BY RAND() LIMIT 100) data;

-- ThirdPartyAuth
INSERT INTO PW_thirdPartyAuth (idPW_thirdPartyAuth, name, secretKey, publicKey, iconURL) VALUES
(1, 'Google', UNHEX(MD5(RAND())), UNHEX(MD5(RAND())), 'https://example.com/icons/google.png'),
(2, 'Facebook', UNHEX(MD5(RAND())), UNHEX(MD5(RAND())), 'https://example.com/icons/facebook.png'),
(3, 'Apple', UNHEX(MD5(RAND())), UNHEX(MD5(RAND())), 'https://example.com/icons/apple.png');

-- First insert 3 third party auth providers
INSERT INTO PW_thirdPartyAuth (idPW_thirdPartyAuth, name, secretKey, publicKey, iconURL) VALUES
(1, 'Google', UNHEX(MD5(RAND())), UNHEX(MD5(RAND())), 'https://example.com/icons/google.png'),
(2, 'Facebook', UNHEX(MD5(RAND())), UNHEX(MD5(RAND())), 'https://example.com/icons/facebook.png'),
(3, 'Apple', UNHEX(MD5(RAND())), UNHEX(MD5(RAND())), 'https://example.com/icons/apple.png');

-- 1000 random auth sessions
INSERT INTO PW_authSession (authSessionId, sessionId, externalUser, token, refreshToken, thirdPartyAuth, userId)
SELECT 
    (@row := @row + 1) AS authSessionId,
    UNHEX(MD5(CONCAT(NOW(), RAND(), userId))) AS sessionId,
    UNHEX(MD5(CONCAT('ext', userId, RAND()))) AS externalUser,
    UNHEX(SHA2(CONCAT('token', NOW(), RAND(), userId), 256)) AS token,
    UNHEX(SHA2(CONCAT('refresh', NOW(), RAND(), userId), 256)) AS refreshToken,
    FLOOR(1 + RAND() * 3) AS thirdPartyAuth,
    userId
FROM (
    SELECT userId FROM (
        SELECT 1 AS userId UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION
        SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION
        SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION
        SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20 UNION
        SELECT 21 UNION SELECT 22 UNION SELECT 23 UNION SELECT 24 UNION SELECT 25 UNION
        SELECT 26 UNION SELECT 27 UNION SELECT 28 UNION SELECT 29 UNION SELECT 30 UNION
        SELECT 31 UNION SELECT 32 UNION SELECT 33 UNION SELECT 34 UNION SELECT 35 UNION
        SELECT 36 UNION SELECT 37 UNION SELECT 38 UNION SELECT 39 UNION SELECT 40
    ) users
    CROSS JOIN (
        SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION
        SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION
        SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION
        SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20 UNION
        SELECT 21 UNION SELECT 22 UNION SELECT 23 UNION SELECT 24 UNION SELECT 25
    ) multiplier
    LIMIT 1000
) AS user_cross
CROSS JOIN (SELECT @row := 0) AS row_counter;

SELECT * FROM PW_authSession;

-- Address
INSERT INTO PW_address (street, number, zipcode, line1, line2, cityId, geoSpatial)
SELECT 
    CONCAT('Calle ', FLOOR(1 + RAND() * 100)) AS street,
    FLOOR(1 + RAND() * 2000) AS number,
    LPAD(FLOOR(1000 + RAND() * 90000), 5, '0') AS zipcode,
    CONCAT('Edificio ', CHAR(65 + FLOOR(RAND() * 5)), ', Piso ', FLOOR(1 + RAND() * 20)) AS line1,
    CASE WHEN RAND() > 0.7 THEN CONCAT('Departamento ', FLOOR(1 + RAND() * 300)) ELSE NULL END AS line2,
    FLOOR(1 + RAND() * 10) AS cityId,
    POINT(-100 - RAND() * 20, 20 + RAND() * 30) AS geoSpatial
FROM (
    SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION
    SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION
    SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION
    SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20 UNION
    SELECT 21 UNION SELECT 22 UNION SELECT 23 UNION SELECT 24 UNION SELECT 25
) AS dummy
LIMIT 100;

SELECT * FROM PW_address;

-- User address
SET @max_address = (SELECT MAX(addressId) FROM PW_address);
SET @min_address = (SELECT MIN(addressId) FROM PW_address);

INSERT INTO PW_userAddress (addressId, userId)
SELECT 
    (SELECT addressId FROM PW_address ORDER BY RAND() LIMIT 1) AS addressId,
    userId
FROM (
    SELECT 1 AS userId UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION
    SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION
    SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION
    SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20 UNION
    SELECT 21 UNION SELECT 22 UNION SELECT 23 UNION SELECT 24 UNION SELECT 25 UNION
    SELECT 26 UNION SELECT 27 UNION SELECT 28 UNION SELECT 29 UNION SELECT 30 UNION
    SELECT 31 UNION SELECT 32 UNION SELECT 33 UNION SELECT 34 UNION SELECT 35 UNION
    SELECT 36 UNION SELECT 37 UNION SELECT 38 UNION SELECT 39 UNION SELECT 40
) AS users;
SELECT * FROM PW_userAddress;

-- Company address
INSERT INTO PW_companyAddress (companyAddressId, companyId, addressId)
SELECT 
    (@row := @row + 1) AS companyAddressId,
    companyId,
    (SELECT addressId FROM PW_address ORDER BY RAND() LIMIT 1) AS addressId
FROM (
    SELECT 1 AS companyId UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
) AS companies
CROSS JOIN (SELECT @row := 0) AS row_counter;

SELECT * FROM PW_companyAddress;

-- Company services
INSERT INTO PW_companyServices (serviceId, companyAddressId)
SELECT 
    serviceId,
    (SELECT companyAddressId FROM PW_companyAddress WHERE companyId = c.companyId LIMIT 1)
FROM 
    (SELECT 1 AS companyId UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) c
JOIN
    (SELECT 1 AS serviceId UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) s
ON c.companyId = s.serviceId;

-- Company Contact
INSERT INTO PW_companyContact (companyContactId, contactInfoId, companyId)
VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);

-- User Media
INSERT INTO PW_userMedia (userMediaId, mediafileId, userId)
SELECT 
    (@row := @row + 1) AS userMediaId,
    FLOOR(1 + RAND() * 20) AS mediafileId,
    userId
FROM (
    SELECT 1 AS userId UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION
    SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION
    SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION
    SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20 UNION
    SELECT 21 UNION SELECT 22 UNION SELECT 23 UNION SELECT 24 UNION SELECT 25 UNION
    SELECT 26 UNION SELECT 27 UNION SELECT 28 UNION SELECT 29 UNION SELECT 30 UNION
    SELECT 31 UNION SELECT 32 UNION SELECT 33 UNION SELECT 34 UNION SELECT 35 UNION
    SELECT 36 UNION SELECT 37 UNION SELECT 38 UNION SELECT 39 UNION SELECT 40
) AS users
CROSS JOIN (SELECT @row := 0) AS row_counter;

SELECT * FROM PW_userMedia;

-- TRANSLATIONS (Queridos ManuellitoGod y ProfeGod vean, yo sé que tenían que ser randoms, pero cómo traduzco yo usando random? que es ese nivel de ingeniería :c)
INSERT INTO PW_translation (translationId, code, caption, enabled, languageId, moduleId) VALUES
(1, 'WELCOME_MSG', 'Bienvenido', 1, 1, 6),
(2, 'WELCOME_MSG', 'Welcome', 1, 2, 6),
(3, 'WELCOME_MSG', 'Bienvenue', 1, 3, 6),
(4, 'WELCOME_MSG', 'Willkommen', 1, 4, 6),
(5, 'WELCOME_MSG', 'Benvenuto', 1, 5, 6),
(6, 'LOGIN_BTN', 'Iniciar sesión', 1, 1, 6),
(7, 'LOGIN_BTN', 'Login', 1, 2, 6),
(8, 'LOGIN_BTN', 'Connexion', 1, 3, 6),
(9, 'LOGIN_BTN', 'Anmelden', 1, 4, 6),
(10, 'LOGIN_BTN', 'Accesso', 1, 5, 6),
(11, 'LOGOUT_BTN', 'Cerrar sesión', 1, 1, 6),
(12, 'LOGOUT_BTN', 'Logout', 1, 2, 6),
(13, 'LOGOUT_BTN', 'Déconnexion', 1, 3, 6),
(14, 'LOGOUT_BTN', 'Abmelden', 1, 4, 6),
(15, 'LOGOUT_BTN', 'Disconnessione', 1, 5, 6),
(16, 'ERROR_404', 'Página no encontrada', 1, 1, 6),
(17, 'ERROR_404', 'Page not found', 1, 2, 6),
(18, 'ERROR_404', 'Page non trouvée', 1, 3, 6),
(19, 'ERROR_404', 'Seite nicht gefunden', 1, 4, 6),
(20, 'ERROR_404', 'Pagina non trovata', 1, 5, 6);

-- Info
INSERT INTO PW_info (value, enabled, lastUpdate, paymentMethodId, infoTypeId)
SELECT 
    CASE infoTypeId
        WHEN 1 THEN CASE FLOOR(1 + RAND() * 3)
                        WHEN 1 THEN 'Masculino'
                        WHEN 2 THEN 'Femenino'
                        WHEN 3 THEN 'Otro'
                    END
        WHEN 2 THEN DATE_FORMAT(DATE_SUB(NOW(), INTERVAL FLOOR(18 + RAND() * 50) YEAR), '%Y-%m-%d')
        WHEN 3 THEN CASE FLOOR(1 + RAND() * 4)
                        WHEN 1 THEN 'Sociedad Anónima'
                        WHEN 2 THEN 'Sociedad Limitada'
                        WHEN 3 THEN 'Empresario Individual'
                        WHEN 4 THEN 'Cooperativa'
                    END
        WHEN 4 THEN FLOOR(1 + RAND() * 500)
        WHEN 5 THEN CASE FLOOR(1 + RAND() * 6)
                        WHEN 1 THEN 'Tecnología'
                        WHEN 2 THEN 'Finanzas'
                        WHEN 3 THEN 'Manufactura'
                        WHEN 4 THEN 'Salud'
                        WHEN 5 THEN 'Educación'
                        WHEN 6 THEN 'Retail'
                    END
    END AS value,
    1 AS enabled,
    NOW() - INTERVAL FLOOR(RAND() * 365) DAY AS lastUpdate,
    FLOOR(1 + RAND() * 6) AS paymentMethodId,  -- Solo IDs 1-6 que existen
    infoTypeId
FROM 
    (SELECT 1 AS infoTypeId UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) types
CROSS JOIN 
    (SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION
     SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) multiplier
LIMIT 50;

-- User infromation
INSERT INTO PW_userInfo (userInfoId, userId, infoId)
SELECT 
    CONCAT('UI', LPAD(@row := @row + 1, 5, '0')) AS userInfoId,
    userId,
    infoId
FROM (
    SELECT 
        u.userId,
        (SELECT infoId FROM PW_info ORDER BY RAND() LIMIT 1) AS infoId
    FROM (
        SELECT 1 AS userId UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION
        SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION
        SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION
        SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20 UNION
        SELECT 21 UNION SELECT 22 UNION SELECT 23 UNION SELECT 24 UNION SELECT 25 UNION
        SELECT 26 UNION SELECT 27 UNION SELECT 28 UNION SELECT 29 UNION SELECT 30 UNION
        SELECT 31 UNION SELECT 32 UNION SELECT 33 UNION SELECT 34 UNION SELECT 35 UNION
        SELECT 36 UNION SELECT 37 UNION SELECT 38 UNION SELECT 39 UNION SELECT 40
    ) u
    CROSS JOIN (
        SELECT 1 AS n UNION SELECT 2 UNION SELECT 3
    ) multiplier
    ORDER BY RAND()
    LIMIT 100
) AS user_info_data
CROSS JOIN (SELECT @row := 0) AS row_counter;

-- Company Info 
INSERT INTO PW_infoCompany (companyAddressId, infoId)
SELECT 
    ca.companyAddressId,
    i.infoId
FROM 
    (SELECT companyAddressId, companyId FROM PW_companyAddress ORDER BY companyId LIMIT 5) ca
JOIN 
    (SELECT infoId FROM PW_info WHERE infoTypeId IN (3, 4, 5) ORDER BY RAND() LIMIT 5) i
ON 
    1=1
WHERE 
    (ca.companyId, i.infoId) NOT IN (SELECT companyAddressId, infoId FROM PW_infoCompany);


-- Aquí viene lo chido B)

INSERT INTO PW_transTypes (name) VALUES 
('Pago'),('Recarga'),('Reembolso'),('Transferencia'),('Tarifa');

INSERT INTO PW_transSubTypes (name) VALUES
('Compra producto'),('Suscripción'),('Donación'),('Servicio'),
('Saldo móvil'),('Tarjeta prepago'),('Wallet digital'),
('Devolución producto'),('Cancelación servicio'),
('Entre usuarios'),('A comercio'),('Internacional'),
('Comisión'),('Penalización'),('Mantenimiento');

-- available methods
INSERT INTO PW_availableMethods (name, token, expirationTokenDate, maskaccount, paymentMethodId, userId)
SELECT 
    pm.name,
    UNHEX(SHA2(RAND(), 256)) AS token,
    DATE_ADD(NOW(), INTERVAL 2 YEAR) AS expirationTokenDate,
    CONCAT('****-****-****-', FLOOR(1000 + RAND() * 9000)) AS maskaccount,
    pm.paymentMethodId,
    FLOOR(1 + RAND() * 40) AS userId
FROM 
    PW_paymentMethods pm
LIMIT 60;

-- payments
INSERT INTO PW_Payments (amount, actualAmount, result, reference, auth, chargetoken, description, error, date, checksum, userId, paymentMethodId, availableMethodsId, moduleId)
SELECT
    FLOOR(1000 + RAND() * 99000),
    FLOOR(1000 + RAND() * 99000),
    CASE WHEN RAND() < 0.8 THEN 1 WHEN RAND() < 0.95 THEN 0 ELSE 2 END,
    CONCAT('REF', DATE_FORMAT(NOW(), '%Y%m%d'), LPAD(FLOOR(RAND() * 100000), 5, '0')),
    LPAD(FLOOR(RAND() * 1000000), 6, '0'),
    UNHEX(SHA2(CONCAT(NOW(), RAND()), 256)),
    CASE WHEN am.paymentMethodId = 1 THEN 'Pago PayPal' WHEN am.paymentMethodId = 2 THEN 'Pago Stripe' WHEN am.paymentMethodId IN (3,4) THEN 'Pago con tarjeta' WHEN am.paymentMethodId = 5 THEN 'Transacción Bitcoin' ELSE 'Pago móvil' END,
    CASE WHEN RAND() < 0.8 THEN NULL ELSE 'Error en el procesamiento' END,
    NOW() - INTERVAL FLOOR(RAND() * 30) DAY,
    UNHEX(SHA2(CONCAT('SECRET_SALT', NOW(), RAND()), 256)),
    am.userId,
    am.paymentMethodId,
    am.availableMethodsId,
    2
FROM
    PW_availableMethods am
JOIN
    PW_paymentMethods pm ON am.paymentMethodId = pm.paymentMethodId
CROSS JOIN
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) AS multiplier
ORDER BY
    RAND()
LIMIT 150;

SELECT * FROM PW_Payments; 


-- Transactions
INSERT INTO PW_transactions (
    amount, description, date, postTime, reference1, reference2, 
    value1, value2, processManagerId, convertedAmount, checksum, 
    transTypesId, transSubTypeId, paymentId, currencyId, exchangeRateId
)
SELECT
    p.amount,
    p.description,
    p.date,
    p.date + INTERVAL FLOOR(RAND() * 60) SECOND AS postTime,
    FLOOR(RAND() * 1000000000) AS reference1,
    FLOOR(RAND() * 1000000000) AS reference2,
    CASE WHEN RAND() > 0.7 THEN CONCAT('VAL', FLOOR(RAND() * 1000)) ELSE NULL END AS value1,
    CASE WHEN RAND() > 0.7 THEN CONCAT('EXT', FLOOR(RAND() * 1000)) ELSE NULL END AS value2,
    FLOOR(1 + RAND() * 10) AS processManagerId,
    p.amount * (0.9 + RAND() * 0.2) AS convertedAmount,
    p.checksum,
    FLOOR(1 + RAND() * 5) AS transTypesId,
    FLOOR(1 + RAND() * 14) AS transSubTypeId,
    p.paymentId,
    FLOOR(1 + RAND() * 10) AS currencyId,
    FLOOR(1 + RAND() * 20) AS exchangeRateId
FROM 
    PW_Payments p
CROSS JOIN 
    (SELECT 1 UNION SELECT 2 UNION SELECT 3) AS multiplier
ORDER BY 
    RAND()
LIMIT 180;  

SELECT * FROM PW_transactions;


-- Bitacora
INSERT INTO PW_logTypes (name, referenceDescription, valueDescription) VALUES 
('Transacción','ID de Transacción','Datos adicionales de transacción'),
('Pago','ID de Pago','Respuesta de pasarela de pago'),
('Error','Código de Error','Detalles del error'),
('Seguridad','ID de Usuario','Contexto de seguridad'),
('Sistema','ID de Proceso','Estado del sistema');

INSERT INTO PW_logSeverity (name) VALUES 
('Informativo'),('Advertencia'),('Error'),('Crítico'),('Depuración');

INSERT INTO PW_sources (logSourcesId) VALUES (1),(2),(3),(4),(5);


-- Logs
INSERT INTO PW_Logs (description, posttime, computer, username, trace, referenceId1, checksum, logSeverityId, logSourcesId, logTypeId)
SELECT 
    CONCAT('Nuevo usuario creado: user', userId),
    createdAt,
    CONCAT('SRV', FLOOR(1+RAND()*3)),
    'admin',
    CONCAT('USER-CREATE-', userId),
    userId,
    UNHEX(SHA2(CONCAT('user', userId, createdAt), 256)),
    1,
    4,
    4
FROM PW_users;

INSERT INTO PW_Logs (description, posttime, computer, username, trace, referenceId1, checksum, logSeverityId, logSourcesId, logTypeId)
SELECT
    CONCAT('Actualización perfil usuario', userId),
    updatedAt + INTERVAL FLOOR(RAND()*24) HOUR,
    CONCAT('SRV', FLOOR(1+RAND()*3)),
    CONCAT('user', userId),
    CONCAT('USER-UPDATE-', userId, '-', FLOOR(RAND()*1000)),
    userId,
    UNHEX(SHA2(CONCAT('update', userId, updatedAt), 256)),
    1,
    4,
    4
FROM PW_users
CROSS JOIN (SELECT 1 UNION SELECT 2) AS multiplier;

INSERT INTO PW_Logs (description, posttime, computer, username, trace, referenceId1, value1, checksum, logSeverityId, logSourcesId, logTypeId)
SELECT 
    CONCAT('Pago ', IF(result=1,'exitoso','fallido'), ' - $', amount/100),
    date,
    CONCAT('PAY-SRV', FLOOR(1+RAND()*2)),
    CONCAT('user', userId),
    CONCAT('PAY-', paymentId),
    paymentId,
    CONCAT('Método: ', (SELECT name FROM PW_paymentMethods WHERE paymentMethodId = p.paymentMethodId)),
    UNHEX(SHA2(CONCAT(paymentId, date), 256)),
    CASE WHEN result=1 THEN 1 ELSE 3 END,
    2,
    2
FROM PW_Payments p;

INSERT INTO PW_Logs (description, posttime, computer, username, trace, referenceId1, checksum, logSeverityId, logSourcesId, logTypeId)
SELECT 
    CONCAT('Transacción procesada $', amount/100),
    date,
    CONCAT('TXN-SRV', FLOOR(1+RAND()*2)),
    CONCAT('user', (SELECT userId FROM PW_Payments WHERE paymentId = t.paymentId LIMIT 1)),
    CONCAT('TXN-', transactionId),
    transactionId,
    UNHEX(SHA2(CONCAT(transactionId, date), 256)),
    1,
    3,
    1
FROM PW_transactions t;

INSERT INTO PW_Logs (description, posttime, computer, username, trace, value1, checksum, logSeverityId, logSourcesId, logTypeId)
SELECT
    CONCAT('Error en ', ELT(FLOOR(1+RAND()*5), 'procesamiento pago', 'validación', 'base de datos', 'autenticación', 'API externa')),
    NOW() - INTERVAL FLOOR(RAND()*30) DAY,
    CONCAT('SRV', FLOOR(1+RAND()*5)),
    CASE WHEN RAND() > 0.3 THEN CONCAT('user', FLOOR(1+RAND()*40)) ELSE 'system' END,
    CONCAT('ERR-', FLOOR(RAND()*100000)),
    CONCAT('Código: ', FLOOR(RAND()*1000)),
    UNHEX(SHA2(CONCAT(NOW(), RAND()), 256)),
    CASE WHEN RAND() > 0.7 THEN 4 ELSE 3 END,
    1,
    3;

INSERT INTO PW_Logs (description, posttime, computer, username, trace, checksum, logSeverityId, logSourcesId, logTypeId)
SELECT
    CONCAT('Tarea ', ELT(FLOOR(1+RAND()*4), 'backup', 'sincronización', 'limpieza', 'reporte'), ' completada'),
    NOW() - INTERVAL FLOOR(RAND()*30) DAY,
    CONCAT('SRV', FLOOR(1+RAND()*5)),
    'cron',
    CONCAT('CRON-', FLOOR(RAND()*1000)),
    UNHEX(SHA2(CONCAT('cron', NOW(), RAND()), 256)),
    1,
    1,
    5;

INSERT INTO PW_Logs (description, posttime, computer, username, trace, referenceId1, checksum, logSeverityId, logSourcesId, logTypeId)
SELECT
    CONCAT('Intento de ', ELT(FLOOR(1+RAND()*3), 'login', 'acceso no autorizado', 'cambio contraseña')),
    NOW() - INTERVAL FLOOR(RAND()*30) DAY,
    CONCAT('SRV', FLOOR(1+RAND()*5)),
    CASE WHEN RAND() > 0.5 THEN CONCAT('user', FLOOR(1+RAND()*40)) ELSE 'unknown' END,
    CONCAT('SEC-', FLOOR(RAND()*10000)),
    CASE WHEN RAND() > 0.5 THEN FLOOR(1+RAND()*40) ELSE NULL END,
    UNHEX(SHA2(CONCAT('sec', NOW(), RAND()), 256)),
    CASE WHEN RAND() > 0.8 THEN 4 ELSE 2 END,
    4,
    4;
    
SELECT * FROM PW_Logs;

-- IA
INSERT INTO PW_authTypesAI (authTypeId, name) VALUES 
(1, 'OpenAI'),
(2, 'Gemini');

-- IA
INSERT INTO PW_AI (
    AIAuthId, name, LogoURL, secretKey, organizationName, projectName, PW_AIAuthcol, authTypeAIId, moduleId
) VALUES 
(
    1, 
    'OpenAI', 
    'https://example.com/logos/openai.png',
    UNHEX(SHA2(CONCAT('openai_secret_', RAND()), 256)),
    'OpenAI Organization',
    'GPT-4 Turbo',
    'OPENAI_AUTH',
    1,
    7
),
(
    2, 
    'Gemini', 
    'https://example.com/logos/gemini.png',
    UNHEX(SHA2(CONCAT('gemini_secret_', RAND()), 256)),
    'Google DeepMind',
    'Gemini Pro',
    'GEMINI_AUTH',
    2,
    7
);

-- request IA
INSERT INTO PW_requestAI (
    requestAIId, model, stream, temperature, requestDate, include, AIId
)
SELECT 
    (@row := @row + 1),
    CASE 
        WHEN ai.AIAuthId = 1 THEN 'gpt-4-turbo' 
        ELSE 'gemini-pro' 
    END,
    FLOOR(RAND() * 2),
    FLOOR(RAND() * 100),
    NOW() - INTERVAL FLOOR(RAND() * 30) DAY,
    CASE FLOOR(RAND() * 3)
        WHEN 0 THEN 'all'
        WHEN 1 THEN 'partial'
        ELSE 'minimal'
    END,
    ai.AIAuthId
FROM 
    PW_AI ai
CROSS JOIN 
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) AS multiplier
CROSS JOIN
    (SELECT @row := 0) r
WHERE
    ai.AIAuthId IN (1, 2)
LIMIT 10;

-- AI Format
INSERT INTO PW_responseAIFormat (responseFormatId, formatName) VALUES 
(1, 'JSON'),
(2, 'XML'),
(3, 'Texto'),
(4, 'HTML'),
(5, 'Markdown');

-- Events
INSERT INTO PW_eventType (eventTypeId, name, description, action1, action2, specifications) VALUES 
(1, 'Pago Automático', 'Pago recurrente procesado', 'ejecutar', 'notificar', 'Diario/Semanal/Mensual'),
(2, 'Recordatorio Pago', 'Recordatorio de pago pendiente', 'alertar', 'posponer', '24h antes del vencimiento'),
(3, 'Detección Fraude', 'Transacción sospechosa detectada', 'bloquear', 'notificar', 'Umbral 95% confianza'),
(4, 'Renovación Suscripción', 'Renovación automática de suscripción', 'procesar', 'confirmar', '3 días antes del vencimiento'),
(5, 'Devolución', 'Proceso de devolución de fondos', 'iniciar', 'verificar', 'Seguir protocolo 345-B');

INSERT INTO PW_eventByAI (eventId, chainId, eventTypeId) VALUES 
('PAY-001', 1, 1),
('REM-001', 1, 2),
('FRA-001', 2, 3),
('REN-001', 3, 4),
('REF-001', 2, 5),
('PAY-002', 4, 1),
('REM-002', 5, 2),
('FRA-002', 3, 3),
('REN-002', 1, 4),
('REF-002', 4, 5);

-- Systemp prompts
INSERT INTO PW_systemPrompt (systemPromptId, text) VALUES 
(1, 'Eres un asistente financiero especializado en procesamiento de pagos. Proporciona respuestas claras y concisas.'),
(2, 'Eres un analista de fraudes. Examina cuidadosamente cada transacción y marca las sospechosas.'),
(3, 'Eres un chatbot de soporte al cliente para problemas de facturación y pagos.');

-- speechToText
SET @min_audio = (SELECT MIN(mediafileId) FROM PW_mediafiles);
SET @max_audio = (SELECT MAX(mediafileId) FROM PW_mediafiles);
SET @min_request = (SELECT MIN(requestAIId) FROM PW_requestAI);
SET @max_request = (SELECT MAX(requestAIId) FROM PW_requestAI);

INSERT INTO PW_speechToText (languageId, audioFileId, formatId, userId, requestId)
SELECT 
    FLOOR(1 + RAND() * 5) AS languageId,       -- IDs de idioma 1-5
    FLOOR(@min_audio + RAND() * (@max_audio - @min_audio + 1)) AS audioFileId, 
    FLOOR(1 + RAND() * 5) AS formatId,         -- IDs de formato 1-5
    FLOOR(1 + RAND() * 40) AS userId,          -- IDs de usuario 1-40
    FLOOR(@min_request + RAND() * (@max_request - @min_request + 1)) AS requestId 
FROM 
    (SELECT a.n + b.n * 10 AS num
     FROM (SELECT 0 AS n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION 
           SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
          (SELECT 0 AS n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION 
           SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b
    ) AS numbers
WHERE num BETWEEN 1 AND 100;

SELECT * FROM PW_speechToText;


-- Transcriptions
SET @min_user = 1;
SET @max_user = 40;
SET @min_speech = (SELECT MIN(speechToTextId) FROM PW_speechToText);
SET @max_speech = (SELECT MAX(speechToTextId) FROM PW_speechToText);

INSERT INTO PW_transcriptions (transcriptionId, userId, speechToTextId, text)
SELECT 
    (@row := @row + 1) AS transcriptionId,
    FLOOR(@min_user + RAND() * (@max_user - @min_user + 1)) AS userId,
    FLOOR(@min_speech + RAND() * (@max_speech - @min_speech + 1)) AS speechToTextId,
    CASE 
        WHEN RAND() < 0.7 THEN 
            CASE FLOOR(RAND() * 6)
                WHEN 0 THEN CONCAT('Quiero pagar mi factura de ', FLOOR(10 + RAND() * 500), ' dólares')
                WHEN 1 THEN CONCAT('Reporto un problema con mi transacción #', FLOOR(1000 + RAND() * 9000))
                WHEN 2 THEN '¿Cómo cambio mi método de pago?'
                WHEN 3 THEN 'Necesito ayuda con un reembolso'
                WHEN 4 THEN CONCAT('Recibí un cargo duplicado por ', FLOOR(5 + RAND() * 200), ' dólares')
                ELSE 'Mi suscripción no se canceló correctamente'
            END
        ELSE  -- 30% con errores
            CASE FLOOR(RAND() * 4)
                WHEN 0 THEN CONCAT('Problema con... [inaudible] ...pago de ', FLOOR(10 + RAND() * 500), '... [corte]')
                WHEN 1 THEN '[Ruido de fondo] Quiero cance... [ininteligible] ...suscripción'
                WHEN 2 THEN '*Estático* reporto *estático* cargo no *estático* reconocido'
                ELSE '...[silbido]... ayuda con ...[distorsión]... factura ...[corte]'
            END
    END AS text
FROM 
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION
     SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) AS t
CROSS JOIN 
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION
     SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) AS m
CROSS JOIN
    (SELECT @row := 0) AS r
LIMIT 100;

INSERT INTO PW_userPrompt (userPromptId, transcriptionId)
SELECT 
    (@row2 := @row2 + 1) AS userPromptId,
    transcriptionId
FROM 
    PW_transcriptions
CROSS JOIN
    (SELECT @row2 := 0) AS r2
LIMIT 100;

SELECT * FROM PW_transcriptions;

-- Chain of Thought
INSERT INTO PW_chainOfThought (chainId, requestId, responseFormatId, userPromptId, systemPromptId, response)
SELECT 
    (@row := @row + 1) AS chainId,
    r.requestAIId AS requestId,
    FLOOR(1 + RAND() * 5) AS responseFormatId,  -- Formatos 1-5
    up.userPromptId,
    FLOOR(1 + RAND() * 3) AS systemPromptId,    -- System Prompts 1-3
    JSON_OBJECT(
        'analysis', CASE 
            WHEN r.model LIKE '%gpt%' THEN 'Análisis realizado por modelo GPT'
            ELSE 'Análisis realizado por modelo Gemini'
        END,
        'steps', JSON_ARRAY(
            'Paso 1: Interpretación de la solicitud',
            'Paso 2: Validación de parámetros',
            'Paso 3: Procesamiento central',
            'Paso 4: Generación de respuesta'
        ),
        'conclusion', CASE 
            WHEN RAND() > 0.3 THEN 'Operación completada satisfactoriamente'
            ELSE 'Operación completada con observaciones'
        END,
        'timestamp', NOW() - INTERVAL FLOOR(RAND() * 30) DAY
    ) AS response
FROM 
    PW_requestAI r
JOIN 
    PW_userPrompt up ON up.userPromptId = FLOOR(1 + RAND() * 100)  -- IDs 1-100
JOIN
    (SELECT @row := 0) AS row_counter
LIMIT 50;

SELECT * FROM PW_chainOfThought;

-- Events by AI
INSERT INTO PW_eventByAI (eventId, chainId, eventTypeId)
SELECT 
    CONCAT('EVT-', 
           DATE_FORMAT(NOW(), '%Y%m%d'), 
           '-', 
           LPAD(@row := @row + 1, 4, '0')) AS eventId,
    c.chainId,
    CASE 
        WHEN c.response->>'$.conclusion' LIKE '%satisfactoriamente%' THEN 1  
        WHEN c.response->>'$.conclusion' LIKE '%observaciones%' THEN 3      
        ELSE FLOOR(1 + RAND() * 5)                                         
    END AS eventTypeId
FROM 
    PW_chainOfThought c
CROSS JOIN 
    (SELECT @row := 0) AS r
ORDER BY 
    RAND()
LIMIT 50;


-- Interactions
INSERT INTO PW_interactionByAI (
    interactionId, eventId, contactInfoId, userId, 
    transactionId, paymentId, addressId, companyAddressId, 
    moduleId, interactiontStartDate, interactionEndDate, checksum
)
SELECT
    (@row := @row + 1) AS interactionId,
    e.eventId,
    ci.contactInfoId,
    u.userId,
    t.transactionId,
    p.paymentId,
    a.addressId,
    ca.companyAddressId,
    CASE 
        WHEN e.eventTypeId = 1 THEN 2  -- Module 2 for payments
        WHEN e.eventTypeId = 3 THEN 5  -- Module 5 for fraud detection
        ELSE FLOOR(1 + RAND() * 10)    -- Other random modules
    END AS moduleId,
    NOW() - INTERVAL FLOOR(RAND() * 30) DAY AS interactiontStartDate,
    NOW() - INTERVAL FLOOR(RAND() * 29) DAY AS interactionEndDate,
    UNHEX(SHA2(CONCAT(
        COALESCE(e.eventId, ''),
        COALESCE(ci.contactInfoId, ''),
        COALESCE(u.userId, ''),
        COALESCE(t.transactionId, ''),
        COALESCE(p.paymentId, ''),
        COALESCE(a.addressId, ''),
        COALESCE(ca.companyAddressId, ''),
        RAND()
    ), 256)) AS checksum
FROM
    PW_eventByAI e
INNER JOIN (SELECT contactInfoId FROM PW_contactInfo ORDER BY RAND() LIMIT 100) ci ON 1=1
INNER JOIN (SELECT userId FROM PW_users ORDER BY RAND() LIMIT 100) u ON 1=1
INNER JOIN (SELECT transactionId FROM PW_transactions ORDER BY RAND() LIMIT 100) t ON 1=1
INNER JOIN (SELECT paymentId FROM PW_Payments ORDER BY RAND() LIMIT 100) p ON 1=1
INNER JOIN (SELECT addressId FROM PW_address ORDER BY RAND() LIMIT 100) a ON 1=1
INNER JOIN (SELECT companyAddressId FROM PW_companyAddress ORDER BY RAND() LIMIT 100) ca ON 1=1
CROSS JOIN (SELECT @row := 0) r
LIMIT 100;

SELECT * FROM PW_interactionByAI;

-- Vea señores Manuelito y Don Rodrigo, yo llené todo, yo ya no quiero ver más SQL, he visto 102010290 de páginas de stack overflow, deepseek ya no me quiere, y creo que me hice experto en SQL
-- Ya no veo código, ahora veo SQL, que dios bendiga SQL y que no se repita. (No sabía si había que llenar todo, pero bueno, para mí tiene sentido todo lo que añadí)


-- update 2: soy un manco y no leí que costarica importaba jajan't
-- Add Costa Rica to countries (using countryId 11 to follow your sequence)
INSERT INTO PW_countries (countryId, name, isoCode, phoneCode)
VALUES
    (11, 'Costa Rica', 'CR', '+506');

-- Add a state for Costa Rica (San José is the capital province)
INSERT INTO PW_states (name, countryId)
VALUES
    ('San José', 11);

-- Add the capital city (San José) for Costa Rica
INSERT INTO PW_cities (name, stateId)
VALUES
    ('San José', (SELECT stateId FROM PW_states WHERE name = 'San José' AND countryId = 11));

-- Add Costa Rican Colón currency
INSERT INTO PW_currency (name, acronym, symbol, countryId)
VALUES
    ('Costa Rican Colón', 'CRC', '₡', 11);

-- Add some exchange rates for CRC (Colón Costarricense)
INSERT INTO PW_exchangeRate (startDate, changeDate, PW_exchangeRatecol, enabled, currentChange, baseCurrencyId, conversionCurrencyId)
SELECT 
    NOW() - INTERVAL FLOOR(RAND() * 365) DAY AS startDate,
    NOW() AS changeDate,
    CONCAT(c1.acronym, '_TO_', c2.acronym) AS PW_exchangeRatecol,
    1 AS enabled,
    CASE WHEN RAND() > 0.5 THEN 1 ELSE 0 END AS currentChange,
    c1.currencyId AS baseCurrencyId,
    c2.currencyId AS conversionCurrencyId
FROM 
    PW_currency c1
CROSS JOIN 
    PW_currency c2
WHERE 
    c1.acronym = 'CRC' AND c2.acronym != 'CRC'
LIMIT 5;

-- Also add some rates where CRC is the target currency
INSERT INTO PW_exchangeRate (startDate, changeDate, PW_exchangeRatecol, enabled, currentChange, baseCurrencyId, conversionCurrencyId)
SELECT 
    NOW() - INTERVAL FLOOR(RAND() * 365) DAY AS startDate,
    NOW() AS changeDate,
    CONCAT(c1.acronym, '_TO_', c2.acronym) AS PW_exchangeRatecol,
    1 AS enabled,
    CASE WHEN RAND() > 0.5 THEN 1 ELSE 0 END AS currentChange,
    c1.currencyId AS baseCurrencyId,
    c2.currencyId AS conversionCurrencyId
FROM 
    PW_currency c1
CROSS JOIN 
    PW_currency c2
WHERE 
    c2.acronym = 'CRC' AND c1.acronym != 'CRC'
LIMIT 5;