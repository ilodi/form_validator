import 'dart:async';

class Validators {
  //STream Transformert

//Validar Email
  final validarEmail = StreamTransformer<String, String>.fromHandlers(
      //SInk dice que esta fluyendo
      handleData: (email, sink) {
    //Se evalua frente una exprecion regular
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(pattern);

    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Email no valido');
    }
  });

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
