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
role-based access control (RBAC) :  https://www.ibm.com/think/topics/rbac#:~:text=Role-based%20access%20control%20(RBAC)%20is%20a%20model%20for,or%20privileges%20for%20the%20user.
                                    https://stytch.com/blog/what-is-rbac/ (Tablas de roles y ejemplo del profe.)
Modular desing patter: https://www.patterns.dev/vanilla/module-pattern/ (Tabla de los modulos)
UI Component Pattern https://www.linkedin.com/pulse/discovering-database-driven-ui-design-pattern-deepika-naik-qx5ge/ (Porqué añadir los objectHTML)
GeoSpatial Data : https://www.ibm.com/think/topics/geospatial-data#:~:text=Examples%20of%20geospatial%20data%20include:%20*%20Vectors,images%20of%20our%20world%2C%20taken%20from%20above. (qué es)

Countries/Cities : https://gis.stackexchange.com/questions/23078/how-to-design-a-database-for-continents-countries-regions-cities-and-pois (DOC y Ejemplo del Profe.)
ISO-CODE : https://www.iso.org/contents/news/2022/12/how-iso-codes-connect-the-world.html#:~:text=Having%20multiple%20names%20and%20spellings,Connections%20through%20code (Porqué se uso).
More than one Phone Code : https://www.quora.com/Is-there-any-country-that-uses-multiple-dialing-codes (Me surgió la duda, so fun fact.)
Amount of decimals for latitde / longitud : https://en.wikipedia.org/wiki/Decimal_degrees#:~:text=The%20appropriate%20decimal%20places%20are,location%20and%20journal%20or%20publication.
Add "userAddress" : https://chatgpt.com/share/67da4593-e9ac-800c-bca2-adea2466a67f (Yes, bc more than one direction)
ContactInfo Pattern: https://stackoverflow.com/questions/3636061/database-design-similar-contact-information-for-multiple-entities 
Patrones de diseño de bases de datos: https://vertabelo.com/blog/database-design-patterns/ 
ThirdPartyAuth : https://developers.google.com/identity/protocols/oauth2/javascript-implicit-flow (Check endpoints)
ExchangeRate : https://www.exchangerate-api.com (Cambian en grupo)
cadena de pensamiento: https://platform.openai.com/docs/guides/structured-outputs?api-mode=chat&example=structured-data 
audio to text: https://platform.openai.com/docs/api-reference/audio/createSpeech 
## Bases_de_Datos
## LLenado_datos
![image](https://github.com/user-attachments/assets/d5ac587a-a75e-4af0-a0c6-95d64bcfbd15)
