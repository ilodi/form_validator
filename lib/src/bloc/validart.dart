import 'dart:async';

class Validators {
  //STream Transformert
//Va a alterar el stream y es bueno comentarle que entra y que va a salir
  final validarPassword = StreamTransformer<String, String>.fromHandlers(
      //SInk dice que esta flullendo
      handleData: (password, sink) {
    //Si es mayor a 6 deja fluir este sink
    if (password.length >= 6) {
      sink.add(password);
    } else {
      //Notificar un error
      sink.addError('Más de 6 caracteres por favor');
    }
  });
}
