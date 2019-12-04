import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:formvalidator/src/bloc/provider.dart';
import 'package:formvalidator/src/providers/usuario_provider.dart';

class RegistroPage extends StatelessWidget {
  //Instancia del usuario provider

  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
//Llamar al privider
    final bloc = Provider.of(context);
//Ya siene acceso a todas las propiedades del bloc

    //OBTENER EL 40% DE la pantalla
    final size = MediaQuery.of(context).size;
    //Hace scroll depende del tamaño de su hijo
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 50.0),
            margin: EdgeInsets.symmetric(vertical: 30.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    spreadRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                  )
                ]),
            child: Column(
              children: <Widget>[
                Text(
                  'Crear Cuenta',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 20.0),
                _crearEmail(bloc),
                SizedBox(height: 30.0),
                _crearPass(bloc),
                SizedBox(height: 30.0),
                _creatBotn(bloc),
              ],
            ),
          ),
          FlatButton(
            child: Text('¿Ya tienes cuenta?'),
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
          ),
          SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(Icons.alternate_email, color: Colors.cyan),
                hintText: 'ejemplo@mail.com',
                labelText: 'Correo Electronico',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: (value) => bloc.changeEmail(value),
          ),
        );
      },
    );

    //despues de hacer uso del StreamBuider
  }

  Widget _creatBotn(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
            child: Text('Registrar'),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 0.0,
          color: Color.fromRGBO(0, 103, 185, 1.0),
          textColor: Colors.white,
          onPressed: snapshot.hasData ? () => _register(context, bloc) : null,
        );
      },
    );
  }

  _register(BuildContext context, LoginBloc bloc) {
    usuarioProvider.nuevoUsuario(bloc.email, bloc.password);
  }

  Widget _crearPass(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordSream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.vpn_key, color: Colors.cyan),
                labelText: 'Password',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearFondo(BuildContext context) {
    //OBTENER EL 40% DE la pantalla
    final size = MediaQuery.of(context).size;
    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(142, 45, 226, 1.0),
        Color.fromRGBO(74, 0, 224, 1.0),
      ])),
    );

    ///
    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned(
          child: circulo,
          top: 90.0,
          left: 30.0,
        ),
        Positioned(
          child: circulo,
          top: -40.0,
          right: -30.0,
        ),
        Positioned(
          child: circulo,
          bottom: -50.0,
          right: 50.0,
        ),
        Positioned(
          child: circulo,
          bottom: 120.0,
          right: 20.0,
        ),
        Positioned(
          child: circulo,
          bottom: -50.0,
          left: -20.0,
        ),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.verified_user,
                color: Colors.white,
                size: 100.0,
              ),
              SizedBox(
                height: 10.0,
                width: double.infinity,
              ),
              Text('Hola',
                  style: TextStyle(color: Colors.white, fontSize: 25.0)),
            ],
          ),
        )
      ],
    );
  }
}
