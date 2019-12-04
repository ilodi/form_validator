import 'dart:convert';

import 'package:http/http.dart' as http;

class UsuarioProvider {
  final String _firebaseToken = 'AIzaSyAfInRPjkpdtp1Ak2gsp_kaykfgm_eEZxY';

  Future nuevoUsuario(String email, String password) async {
    //Primero
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };
//Segundo
    final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
        body: json.encode(authData));

    ///Tercero
    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    //Manejo de respuesta
    if(decodedResp.containsKey('idToken')){
     // TODO: Salvar el token en el storage del devices
     //Si todo sale bien con la respuesta
     //Retornara un mapa 
     return {'ok': true, 'token': decodedResp['idToken']};
    }else{
      //Si hay un mens

      //ES un mapa dentro de otro mapa
       return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }
}
