Feature: POST /usuarios - Registrar usuario

Background:
  * url baseUrl
  * def generarUsuario = read('classpath:helpers/user-data.js')
  * def esquemaRegistroExitoso = { message: '#string', _id: '#regex [A-Za-z0-9]{16}' }

@positive
Scenario: Registrar un usuario con datos válidos
  * def usuario = generarUsuario()

  Given path 'usuarios'
  And request usuario
  When method post
  Then status 201

  # Validar estructura y contenido de la respuesta de creación.
  And match response == esquemaRegistroExitoso
  And match response.message == 'Cadastro realizado com sucesso'

  * def idUsuario = response._id

  # Eliminar el usuario creado para no dejar datos innecesarios.
  Given path 'usuarios', idUsuario
  When method delete
  Then status 200
  And match response == { message: 'Registro excluído com sucesso' }

@negative
Scenario: No registrar un usuario con correo duplicado
  * def usuario = generarUsuario()

  Given path 'usuarios'
  And request usuario
  When method post
  Then status 201
  And match response == esquemaRegistroExitoso
  And match response.message == 'Cadastro realizado com sucesso'

  * def idUsuario = response._id

  Given path 'usuarios'
  And request usuario
  When method post
  Then status 400

  # Validar la respuesta completa del caso negativo.
  And match response == { message: 'Este email já está sendo usado' }

  # Eliminar el usuario creado.
  Given path 'usuarios', idUsuario
  When method delete
  Then status 200
  And match response == { message: 'Registro excluído com sucesso' }
