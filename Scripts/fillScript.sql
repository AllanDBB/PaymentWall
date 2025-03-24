
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

 

