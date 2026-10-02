Feature: GET /usuarios - Listar usuarios

Background:
  * url baseUrl
  * def generarUsuario = read('classpath:helpers/user-data.js')
  * def esquemaUsuario =
    """
    {
      nome: '#string',
      email: '#string',
      password: '#string',
      administrador: '#? _ == "true" || _ == "false"',
      _id: '#regex [A-Za-z0-9]{16}'
    }
    """

@positive
Scenario: Listar todos los usuarios registrados
  Given path 'usuarios'
  When method get
  Then status 200

  # Validar estructura completa de la respuesta.
  And match response == { quantidade: '#number', usuarios: '#[]' }

  # Validar que cada elemento del array tenga el esquema completo de usuario.
  And match each response.usuarios == esquemaUsuario

  # Validar que el contador coincida con la cantidad real de usuarios.
  And assert response.quantidade == response.usuarios.length

@negative
Scenario: Buscar usuarios con un correo inexistente
  * def usuario = generarUsuario()

  Given path 'usuarios'
  And param email = usuario.email
  When method get
  Then status 200

  # Para un correo inexistente la lista debe regresar vacía.
  And match response == { quantidade: 0, usuarios: [] }
