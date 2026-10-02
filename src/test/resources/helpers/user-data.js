function fn() {
  var identificadorUnico = Date.now() + '' + Math.floor(Math.random() * 100000);

  return {
    // "nome" y "administrador" son nombres definidos por el contrato de ServeRest.
    nome: 'Usuario QA ' + identificadorUnico,
    email: 'qa_' + identificadorUnico + '@mail.com',
    password: 'teste123',
    administrador: 'true'
  };
}
