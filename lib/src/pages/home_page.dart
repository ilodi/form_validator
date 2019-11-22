import 'package:flutter/material.dart';
import 'package:formvalidator/src/bloc/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Llamar al privider
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Email: ${bloc.email}'),
          Divider(),
          Text('Pass:  ${bloc.password}')
        ],
      ),
    );
  }
}
