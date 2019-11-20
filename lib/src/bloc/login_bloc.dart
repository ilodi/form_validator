import 'dart:async';

class LoginBlov {
  //controladores
  final _emailController = StreamController<String>.broadcast();
  final _passController = StreamController<String>.broadcast();

//Recuperar los datos del Stream
  Stream<String> get emailStream => _emailController.stream;
  Stream<String> get passwordSream => _passController.stream;

  //Constructor
  //Insertar Valores al Stream

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passController.sink.add;

  //Cerrar cuando no se necesitan
  dispose() {
    _emailController?.close();
    _passController?.close();
  }
}
