import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Llamar al privider
    //final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(),
      floatingActionButton: _crearBtn(context),
    );
  }

  Widget _crearBtn(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        elevation: 0.0,
        onPressed: () => Navigator.pushNamed(context, 'producto'));
  }
}
