# Estrategia de Automatización

## Objetivo

Automatizar la API de Usuarios de ServeRest con Karate DSL.

La documentación utilizada puede visualizarse en español mediante:

```text
https://serverest.dev/?lang=es
```

## Alcance

Se cubren las cinco operaciones solicitadas:

1. Listar usuarios.
2. Registrar usuario.
3. Buscar usuario por ID.
4. Actualizar usuario.
5. Eliminar usuario.

## Organización

Se utiliza un feature por endpoint para mantener una estructura sencilla y alineada con el reto.

Cada feature contiene:

- Un escenario positivo.
- Un escenario negativo.

## Validaciones

Se validan:

- Código HTTP.
- Estructura completa del JSON.
- Tipos de datos.
- Mensajes de negocio.
- Identificadores de 16 caracteres.
- Contenido de cada usuario dentro de las listas.
- Persistencia de los datos después de actualizar.
- Eliminación efectiva del usuario.

Karate permite validar tipos mediante:

```text
#string
#number
#[]
```

## Datos de prueba

`user-data.js` genera usuarios dinámicos con correos únicos.

Los nombres de campos `nome` y `administrador` se mantienen porque forman parte del contrato real de ServeRest, aunque la documentación se consulte en español.

## Limpieza

Los usuarios creados como preparación se eliminan cuando corresponde para no dejar información innecesaria.

## Reportería

Se utiliza el reporte HTML nativo de Karate.

No se agregaron librerías externas porque no son necesarias para el alcance del reto.
