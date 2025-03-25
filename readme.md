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
## Integrantes
Bryan Marín Valverde
Allan Bolaños
## Introduction
Provide a brief description of your project, its purpose, and its goals.

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
Patrones de diseño de bases de datos: https://vertabelo.com/blog/database-design-patterns/ 
ThirdPartyAuth : https://developers.google.com/identity/protocols/oauth2/javascript-implicit-flow (Check endpoints)
ExchangeRate : https://www.exchangerate-api.com (Cambian en grupo)
cadena de pensamiento: https://platform.openai.com/docs/guides/structured-outputs?api-mode=chat&example=structured-data 
audio to text: https://platform.openai.com/docs/api-reference/audio/createSpeech 
## Bases_de_Datos
https://github.com/AllanDBB/PaymentWall/blob/main/Models/Final_version_case_2.mwb
## LLenado_datos
![image](https://github.com/user-attachments/assets/d5ac587a-a75e-4af0-a0c6-95d64bcfbd15)
Como podemos ver se usa el insert into + la tabla + campos y la funcion values lo que permite insertar 10 registros de una vez
