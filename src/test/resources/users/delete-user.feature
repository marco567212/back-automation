Feature: DELETE /usuarios/{_id} - Eliminar usuario

Background:
  * url baseUrl
  * def generarUsuario = read('classpath:helpers/user-data.js')
  * def esquemaRegistroExitoso = { message: '#string', _id: '#regex [A-Za-z0-9]{16}' }

@positive
Scenario: Eliminar un usuario existente
  * def usuario = generarUsuario()

  Given path 'usuarios'
  And request usuario
  When method post
  Then status 201
  And match response == esquemaRegistroExitoso
  And match response.message == 'Cadastro realizado com sucesso'

  * def idUsuario = response._id

  Given path 'usuarios', idUsuario
  When method delete
  Then status 200

  # Validar respuesta completa de eliminación.
  And match response == { message: 'Registro excluído com sucesso' }

  # Confirmar que el usuario ya no puede ser consultado.
  Given path 'usuarios', idUsuario
  When method get
  Then status 400
  And match response == { message: 'Usuário não encontrado' }

@negative
Scenario: Intentar eliminar un usuario inexistente
  Given path 'usuarios', 'ZZZZZZZZZZZZZZZZ'
  When method delete
  Then status 200

  # Validar respuesta completa del caso negativo.
  And match response == { message: 'Nenhum registro excluído' }
