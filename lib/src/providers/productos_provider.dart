import 'dart:convert';
import 'dart:io';
import 'package:mime_type/mime_type.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:formvalidator/src/models/producto_model.dart';

class ProductosProvider {
  final String _url = 'https://flutter-varios-16217.firebaseio.com';

  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$_url/productos.json';

    final resp = await http.post(url, body: productoModelToJson(producto));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  //Editar producto

  Future<bool> editarProducto(ProductoModel producto) async {
    final url = '$_url/productos/${producto.id}.json';
//el put remplaza no crea uno nuevo
    final resp = await http.put(url, body: productoModelToJson(producto));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

//
  Future<List<ProductoModel>> cargarProductos() async {
    final url = '$_url/productos.json';
//pet get
    final resp = await http.get(url);
//extraer respuesta ya que tiene más datos que lo basico
    final Map<String, dynamic> decodedData = json.decode(resp.body);

    final List<ProductoModel> productos = new List();

//si no trae nada entonces regrusa una lista basia
    if (decodedData == null) return [];

    decodedData.forEach((id, prod) {
      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;

      productos.add(prodTemp);
    });

    return productos;
  }

  ///Productos para borrar

  Future<int> borrarProducto(String id) async {
    final url = '$_url/productos/$id.json';
    final resp = await http.delete(url);

    print(json.decode(resp.body));

    return 1;
  }

  //
 Future<String> subirImagen( File imagen ) async {

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dc0tufkzf/image/upload?upload_preset=cwye3brj');
    final mimeType = mime(imagen.path).split('/'); //image/jpeg

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath(
      'file', 
      imagen.path,
      contentType: MediaType( mimeType[0], mimeType[1] )
    );

    imageUploadRequest.files.add(file);


    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if ( resp.statusCode != 200 && resp.statusCode != 201 ) {
      print('Algo salio mal');
      print( resp.body );
      return null;
    }

    final respData = json.decode(resp.body);
    print( respData);

    return respData['secure_url'];

  }
}
