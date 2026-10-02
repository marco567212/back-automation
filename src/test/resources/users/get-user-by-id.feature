Feature: GET /usuarios/{_id} - Buscar usuario por ID

Background:
  * url baseUrl
  * def generarUsuario = read('classpath:helpers/user-data.js')
  * def esquemaRegistroExitoso = { message: '#string', _id: '#regex [A-Za-z0-9]{16}' }
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
Scenario: Buscar un usuario existente por ID
  * def usuario = generarUsuario()

  Given path 'usuarios'
  And request usuario
  When method post
  Then status 201
  And match response == esquemaRegistroExitoso
  And match response.message == 'Cadastro realizado com sucesso'

  * def idUsuario = response._id

  Given path 'usuarios', idUsuario
  When method get
  Then status 200

  # Validar estructura completa y datos del usuario consultado.
  And match response == esquemaUsuario
  And match response.nome == usuario.nome
  And match response.email == usuario.email
  And match response.password == usuario.password
  And match response.administrador == usuario.administrador
  And match response._id == idUsuario

  # Eliminar el usuario creado.
  Given path 'usuarios', idUsuario
  When method delete
  Then status 200
  And match response == { message: 'Registro excluído com sucesso' }

@negative
Scenario: Buscar un usuario con ID válido pero inexistente
  Given path 'usuarios', 'ZZZZZZZZZZZZZZZZ'
  When method get
  Then status 400

  # Validar la respuesta completa del caso negativo.
  And match response == { message: 'Usuário não encontrado' }
