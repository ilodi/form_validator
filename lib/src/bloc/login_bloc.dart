import 'dart:async';

import 'package:formvalidator/src/bloc/validart.dart';


//AL agregar e whith se hace un mixing para mesclar
class LoginBloc with Validators {
  //Singleton
  //controladores
  final _emailController = StreamController<String>.broadcast();
  final _passController = StreamController<String>.broadcast();

//Recuperar los datos del Stream
  Stream<String> get emailStream => _emailController.stream;
  Stream<String> get passwordSream => _passController.stream.transform( validarPassword );

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
