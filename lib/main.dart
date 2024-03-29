import 'package:flutter/material.dart';
import 'package:formvalidator/src/bloc/provider.dart';
import 'package:formvalidator/src/pages/home_page.dart';
import 'package:formvalidator/src/pages/login_page.dart';
import 'package:formvalidator/src/pages/producto_page.dart';
import 'package:formvalidator/src/pages/registro_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //No es necesario el id
    return Provider(
        child: MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'registro': (BuildContext context) => RegistroPage(),
        'home': (BuildContext context) => HomePage(),
        'producto': (BuildContext context) => ProductoPage(),
        
      },
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
      ),
    ));
  }
}
