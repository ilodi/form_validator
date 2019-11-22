import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:formvalidator/src/bloc/validart.dart';

//AL agregar e whith se hace un mixing para mesclar
class LoginBloc with Validators {
  //Singleton

  //controladores
  final _emailController = BehaviorSubject<String>();
  final _passController = BehaviorSubject<String>();

//Recuperar los datos del Stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordSream =>
      _passController.stream.transform(validarPassword);
  //Validr que ambos tengan datos
//RXDArt
//Se necesita hacer uso de los combine existen hasta 7
//Es un obserbable que
  Stream<bool> get formValidStream =>
      Observable.combineLatest2(emailStream, passwordSream, (e, p) => true);

  //Constructor
  //Insertar Valores al Stream

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passController.sink.add;

//Obtener ultimo valor ingresado
  String get email => _emailController.value;
  String get password => _passController.value;

  //Cerrar cuando no se necesitan
  dispose() {
    _emailController?.close();
    _passController?.close();
  }
}
