# Reto de Automatización QA - BackEnd

Suite automatizada para la API de Usuarios de ServeRest utilizando Karate DSL.

Documentación de ServeRest en español:

```text
https://serverest.dev/?lang=es
```

## Tecnologías

- Java 21
- Maven
- Karate DSL
- JUnit

## Cobertura

Se automatizan los cinco endpoints solicitados:

- `GET /usuarios`
- `POST /usuarios`
- `GET /usuarios/{_id}`
- `PUT /usuarios/{_id}`
- `DELETE /usuarios/{_id}`

Cada endpoint incluye un escenario positivo y uno negativo.

Se validan:

- Código HTTP.
- Contenido de la respuesta.
- Esquema JSON.
- Datos de prueba generados dinámicamente.

## Importante sobre el idioma

La documentación puede visualizarse en español usando:

```text
https://serverest.dev/?lang=es
```

Sin embargo, los nombres de propiedades del contrato de la API permanecen definidos como:

```json
{
  "nome": "Usuario QA",
  "email": "qa@mail.com",
  "password": "teste123",
  "administrador": "true"
}
```

Por ese motivo, los tests mantienen `nome`, `password` y `administrador`.

Del mismo modo, algunos mensajes que devuelve realmente la API están en portugués, por ejemplo:

```text
Cadastro realizado com sucesso
Usuário não encontrado
```

Estos valores se mantienen sin traducir porque el objetivo de la automatización es validar la respuesta real de ServeRest.


## Validaciones realizadas

La suite no valida únicamente el código HTTP. También verifica el cuerpo completo de las respuestas.

Para `GET /usuarios` se valida:

- `quantidade` como número.
- `usuarios` como array.
- Que `quantidade` coincida con la cantidad real de elementos de `usuarios`.
- Cada objeto dentro de `usuarios`.
- `nome` como texto.
- `email` como texto.
- `password` como texto.
- `administrador` únicamente con valor `"true"` o `"false"`.
- `_id` como valor alfanumérico de exactamente 16 caracteres.

Para las demás operaciones se validan:

- Status HTTP esperado.
- Estructura completa del JSON.
- Mensajes de negocio.
- `_id` generado.
- Datos persistidos después de un `PUT`.
- Confirmación de inexistencia después de un `DELETE`.
- Respuestas completas de los escenarios negativos.

## Estructura

```text
serverest-karate-automation-es/
├── pom.xml
├── README.md
├── AUTOMATION_STRATEGY.md
└── src/test/
    ├── java/
    │   └── users/
    │       └── UsersTest.java
    └── resources/
        ├── karate-config.js
        ├── helpers/
        │   └── user-data.js
        └── users/
            ├── get-users.feature
            ├── post-users.feature
            ├── get-user-by-id.feature
            ├── put-user.feature
            └── delete-user.feature
```

## Requisitos

```bash
java -version
mvn -version
```

El proyecto utiliza Java 21.

## Ejecutar todos los tests

```bash
mvn test
```

## Ejecutar escenarios positivos

```bash
mvn test -Dkarate.options="--tags @positive"
```

## Ejecutar escenarios negativos

```bash
mvn test -Dkarate.options="--tags @negative"
```

## Reporte

Karate genera el reporte HTML en:

```text
target/karate-reports/karate-summary.html
```

En macOS:

```bash
open target/karate-reports/karate-summary.html
```

## Datos de prueba

El helper:

```text
src/test/resources/helpers/user-data.js
```

genera un usuario diferente en cada ejecución para evitar correos duplicados.

## Configuración

La URL utilizada para las llamadas API está centralizada en:

```javascript
baseUrl: 'https://serverest.dev'
```

Y la referencia a la documentación en español es:

```javascript
documentationUrl: 'https://serverest.dev/?lang=es'
```