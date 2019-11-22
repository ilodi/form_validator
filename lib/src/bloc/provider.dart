import 'package:flutter/material.dart';
import 'package:formvalidator/src/bloc/login_bloc.dart';
//Exportarlo para hacer uso de el en otras instancias de provider
export 'package:formvalidator/src/bloc/login_bloc.dart';

//Se extiende de InheritedWidget
class Provider extends InheritedWidget {


static Provider _instancia;

//factory determina si se debe de hacer algo o no
factory Provider({Key key, Widget child}){
  if(_instancia == null){
    _instancia = new Provider._internal(key: key, child: child,);

  }

  return _instancia;
}

Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  final loginBloc = LoginBloc();


//Constructor el super es para incializar InheritedWidget
  //Provider({Key key, Widget child}) : super(key: key, child: child);

//Al actualizarce le debe debe de notificar a sus hijos??
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  //Regresar el estado de como esta el login Bloc
  //Va a retonar la instancia del bloc
  static LoginBloc of (BuildContext context) {
    //VE y busca en este contecto la instancia del provide
    //va y busca en todo el arbol un widget con el mismo tipo de el mismo
    return (context.inheritFromWidgetOfExactType(Provider)
            as Provider).loginBloc;
  }
}
