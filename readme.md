# PaymentWall (Project for Database Course I)

## Table of Contents
- [Integrantes](#Integrantes)
- [Introduction](#introduction)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)
- [Link script Bases de datos](#Bases_de_Datos)
- [link llenado de datos](#LLenado_datos)
- [Link script de consultas](#Scrip_consultas)
## Integrantes
Bryan Marín Valverde
Allan Bolaños
## Introduction
Provide a brief description of your project, its purpose, and its goals.
La toda la base de datos está llena.
## Installation

First of all:

```sh
# Example:
git clone https://github.com/AllanDBB/PaymentWall.git
cd PaymentWall

```




Lista de comandos para luego documentar:
- docker-compose up -d
- docker exec -it paymentwall_mysql mysql -u root -p   


Patrones utilizados:
Identity Pattern : https://java-design-patterns.com/es/patterns/identity-map/#diagrama-de-clases (Tabla de usuario, ids)
role-based access control (RBAC) :
![image](https://github.com/user-attachments/assets/80359abb-1a7e-4667-9b39-1dc2bb636fab)
![image](https://github.com/user-attachments/assets/65a5c172-6ec0-4425-88d8-2631900189c2)
![image](https://github.com/user-attachments/assets/77d77645-a867-4417-8e10-ad1cf6d8e980)

https://www.ibm.com/think/topics/rbac#:~:text=Role-based%20access%20control%20(RBAC)%20is%20a%20model%20for,or%20privileges%20for%20the%20user.
                                    https://stytch.com/blog/what-is-rbac/ (Tablas de roles y ejemplo del profe.)
Modular desing patter: https://www.patterns.dev/vanilla/module-pattern/ (Tabla de los modulos)
![image](https://github.com/user-attachments/assets/b2c9c0a3-2306-4a61-90de-6b83c3030721)
![image](https://github.com/user-attachments/assets/8133b9f7-d937-4360-91b7-a6afe650a21c)
![image](https://github.com/user-attachments/assets/10c7d2b1-407d-43de-98f5-de0167572c5c)
![image](https://github.com/user-attachments/assets/875d05d2-43fd-4edc-adef-ec19a6921e4d)

UI Component Pattern https://www.linkedin.com/pulse/discovering-database-driven-ui-design-pattern-deepika-naik-qx5ge/ (Porqué añadir los objectHTML)
![image](https://github.com/user-attachments/assets/896b704e-a6db-414a-86ff-46d8a6e20bc9)
![image](https://github.com/user-attachments/assets/e21324be-b88e-4edc-a9b1-136cfebb1927)

GeoSpatial Data : https://www.ibm.com/think/topics/geospatial-data#:~:text=Examples%20of%20geospatial%20data%20include:%20*%20Vectors,images%20of%20our%20world%2C%20taken%20from%20above. (qué es)
![image](https://github.com/user-attachments/assets/d5ba6dbf-baa8-44e3-9ca4-799c567db05f)
![image](https://github.com/user-attachments/assets/0d3612c2-406a-42e1-85ac-6e1d8c459305)


Countries/Cities : https://gis.stackexchange.com/questions/23078/how-to-design-a-database-for-continents-countries-regions-cities-and-pois (DOC y Ejemplo del Profe.)

ISO-CODE : https://www.iso.org/contents/news/2022/12/how-iso-codes-connect-the-world.html#:~:text=Having%20multiple%20names%20and%20spellings,Connections%20through%20code (Porqué se uso).
![image](https://github.com/user-attachments/assets/f43cf7f6-1e6b-47cb-a6f8-87b4f0fe544c)
![image](https://github.com/user-attachments/assets/e7bf6d7c-0ab4-45ac-936b-b0cf797cb237)
More than one Phone Code : https://www.quora.com/Is-there-any-country-that-uses-multiple-dialing-codes (Me surgió la duda, so fun fact.)
Amount of decimals for latitde / longitud : https://en.wikipedia.org/wiki/Decimal_degrees#:~:text=The%20appropriate%20decimal%20places%20are,location%20and%20journal%20or%20publication.
![image](https://github.com/user-attachments/assets/e0b58a14-38c3-427b-9528-ee917d60661e)
![image](https://github.com/user-attachments/assets/bbdd0782-3400-4eee-8092-339fac4a141d)

Add "userAddress" : https://chatgpt.com/share/67da4593-e9ac-800c-bca2-adea2466a67f (Yes, bc more than one direction)
![image](https://github.com/user-attachments/assets/58c4ac6c-2dd3-4639-aa22-972bda0a9c09)
![image](https://github.com/user-attachments/assets/11548474-3497-4f14-886c-cf811d3c986d)


ContactInfo Pattern: https://stackoverflow.com/questions/3636061/database-design-similar-contact-information-for-multiple-entities 
![image](https://github.com/user-attachments/assets/f033067b-f978-4809-8d62-7e4279993f15)
![image](https://github.com/user-attachments/assets/b3db7fde-939a-4279-8cab-3c07fef0429b)
![image](https://github.com/user-attachments/assets/bec8b2ad-d98a-4337-88f1-129ad3e75741)

Patrones de diseño de bases de datos: https://vertabelo.com/blog/database-design-patterns/ 
![image](https://github.com/user-attachments/assets/73a712a9-a415-4984-928f-e24c5bd8f546)
![image](https://github.com/user-attachments/assets/b89d022d-ba67-4a6f-9151-e813cbb5498f)
![image](https://github.com/user-attachments/assets/f3baec3d-6c50-4056-8dcd-79694a4b9df8)
![image](https://github.com/user-attachments/assets/02d42630-8422-4e0a-92da-925723b276ea)
![image](https://github.com/user-attachments/assets/9fe05243-371c-4a53-8766-9ac5d372a08c)
![image](https://github.com/user-attachments/assets/ce2ed65f-f8e9-457a-8293-b48732cddada)


ThirdPartyAuth : https://developers.google.com/identity/protocols/oauth2/javascript-implicit-flow (Check endpoints)
![image](https://github.com/user-attachments/assets/d093b5dd-5b98-4b26-acb0-9d8456c3d011)
![image](https://github.com/user-attachments/assets/8eb1d6a8-db5a-469f-bddf-35367137e351)

ExchangeRate : https://www.exchangerate-api.com (Cambian en grupo)
![image](https://github.com/user-attachments/assets/89f8dee7-d3a4-4e1e-8ddd-94ff102243ef)
![image](https://github.com/user-attachments/assets/16b51e18-d9d7-4980-be0b-b311f9db1fd8)

cadena de pensamiento: https://platform.openai.com/docs/guides/structured-outputs?api-mode=chat&example=structured-data 
![image](https://github.com/user-attachments/assets/029e3ed3-fe0b-454b-abbb-fadf92da4041)
![image](https://github.com/user-attachments/assets/9af01da3-bda8-419f-8de7-563c834560f6)
![image](https://github.com/user-attachments/assets/d176f6c4-d9fc-425b-ada6-0dac8c31e34e)
![image](https://github.com/user-attachments/assets/953eb627-bc52-48e0-af32-2c36552bf051)
![image](https://github.com/user-attachments/assets/9d8c1780-9c9c-4385-a1fb-ebbfaa28e0b4)

audio to text: https://platform.openai.com/docs/api-reference/audio/createSpeech 
![image](https://github.com/user-attachments/assets/096d19b1-9f92-4c66-9820-755f3ca1dc1e)
![image](https://github.com/user-attachments/assets/4b70b54c-4e4b-4c30-a139-7eaf3b1147d3)
![image](https://github.com/user-attachments/assets/03900f34-20cc-41eb-84fd-a311ef9f7f21)
![image](https://github.com/user-attachments/assets/37978fee-9623-4ff3-82a4-5e8a2452f2fa)
![image](https://github.com/user-attachments/assets/e1118bd0-e077-4d9b-a910-4e43a444192b)

## Bases_de_Datos
https://github.com/AllanDBB/PaymentWall/blob/main/Models/Final_version_case_2.mwb
## LLenado_datos
![image](https://github.com/user-attachments/assets/d5ac587a-a75e-4af0-a0c6-95d64bcfbd15)
Como podemos ver se usa el insert into + la tabla + campos y la funcion values lo que permite insertar 10 registros de una vez
## Scrip_consultas
listar todos los usuarios de la plataforma que esten activos con su nombre completo,
--  email, país de procedencia, y el total de cuánto han pagado en subscripciones desde el 2024 hasta el día de hoy, dicho monto debe ser en colones (20+ registros)

![image](https://github.com/user-attachments/assets/a7de8a01-0901-4f39-be1d-0c3d0891e73c)
-- listar todas las personas con su nombre completo e email, los cuales le queden menos de 15 días para tener que volver a pagar una nueva subscripción (13+ registros)
![image](https://github.com/user-attachments/assets/08f8ed5e-7c45-4b3a-81d9-5cc553e15e90)
-- un ranking del top 15 de usuarios que más uso le dan a la aplicación y el top 15 que menos uso le dan a la aplicación (15 y 15 registros)

-- Más usuarios
![image](https://github.com/user-attachments/assets/d79cf9ac-39cb-400e-8ff4-03200645f70a)
![image](https://github.com/user-attachments/assets/6f8fe6b3-1d08-4056-86e8-25005b9312cc)


