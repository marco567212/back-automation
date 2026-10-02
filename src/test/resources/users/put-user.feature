Feature: PUT /usuarios/{_id} - Actualizar usuario

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
Scenario: Actualizar un usuario existente
  * def usuario = generarUsuario()

  Given path 'usuarios'
  And request usuario
  When method post
  Then status 201
  And match response == esquemaRegistroExitoso
  And match response.message == 'Cadastro realizado com sucesso'

  * def idUsuario = response._id

  * def usuarioActualizado =
    """
    {
      nome: 'Usuario QA Actualizado',
      email: '#(usuario.email)',
      password: 'nueva123',
      administrador: 'false'
    }
    """

  Given path 'usuarios', idUsuario
  And request usuarioActualizado
  When method put
  Then status 200

  # Validar respuesta completa de actualización.
  And match response == { message: 'Registro alterado com sucesso' }

  # Consultar nuevamente para comprobar persistencia de todos los cambios.
  Given path 'usuarios', idUsuario
  When method get
  Then status 200
  And match response == esquemaUsuario
  And match response.nome == usuarioActualizado.nome
  And match response.email == usuarioActualizado.email
  And match response.password == usuarioActualizado.password
  And match response.administrador == usuarioActualizado.administrador
  And match response._id == idUsuario

  # Eliminar el usuario creado.
  Given path 'usuarios', idUsuario
  When method delete
  Then status 200
  And match response == { message: 'Registro excluído com sucesso' }

@negative
Scenario: No actualizar un usuario con el correo de otro usuario
  * def usuario1 = generarUsuario()
  * def usuario2 = generarUsuario()

  Given path 'usuarios'
  And request usuario1
  When method post
  Then status 201
  And match response == esquemaRegistroExitoso
  And match response.message == 'Cadastro realizado com sucesso'
  * def idUsuario1 = response._id

  Given path 'usuarios'
  And request usuario2
  When method post
  Then status 201
  And match response == esquemaRegistroExitoso
  And match response.message == 'Cadastro realizado com sucesso'
  * def idUsuario2 = response._id

  * def usuarioConCorreoDuplicado =
    """
    {
      nome: 'Usuario QA Duplicado',
      email: '#(usuario2.email)',
      password: 'teste123',
      administrador: 'true'
    }
    """

  Given path 'usuarios', idUsuario1
  And request usuarioConCorreoDuplicado
  When method put
  Then status 400

  # Validar respuesta completa del caso negativo.
  And match response == { message: 'Este email já está sendo usado' }

  # Eliminar los usuarios creados.
  Given path 'usuarios', idUsuario1
  When method delete
  Then status 200
  And match response == { message: 'Registro excluído com sucesso' }

  Given path 'usuarios', idUsuario2
  When method delete
  Then status 200
  And match response == { message: 'Registro excluído com sucesso' }
