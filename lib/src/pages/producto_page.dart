import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:formvalidator/src/models/producto_model.dart';
import 'package:formvalidator/src/providers/productos_provider.dart';
import 'package:formvalidator/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  //
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ProductoModel producto = new ProductoModel();
//para poderla usar en otras clases
  final productoProvider = new ProductosProvider();

  bool _guardando = false;
  File foto;

  @override
  Widget build(BuildContext context) {
//obtener argumentos
    final ProductoModel proData = ModalRoute.of(context).settings.arguments;
    if (proData != null) {
      //reiniciar el producto
      producto = proData;
    }
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto interno'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                _crearBtn()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Producto'),
      onSaved: (value) => producto.titulo = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingresa un nombre mejor';
        } else
          return null;
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Precio'),
      onSaved: (value) => producto.valor = double.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo número';
        }
      },
    );
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: producto.disponible,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value) {
        setState(() {
          producto.disponible = value;
        });
      },
    );
  }

  Widget _crearBtn() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      label: Text('Guardar'),
      color: Colors.deepPurple,
      textColor: Colors.white,
      icon: Icon(Icons.save_alt),
      onPressed: (_guardando) ? null : _sumbit,
    );
  }

  void _sumbit() async {
    //Estado actual del formulario
    //Si es valido es un true
   
    if ( !formKey.currentState.validate() ) return;

    formKey.currentState.save();

    setState(() {_guardando = true; });
    
  
    if ( foto != null ) {
      producto.fotoUrl = await productoProvider.subirImagen(foto);
    }

    if (producto.id == null) {
      productoProvider.crearProducto(producto);
    } else {
      productoProvider.editarProducto(producto);
    }
    mostrartSnackbar('Registro listo');
    Navigator.pop(context);
  }

  void mostrartSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
   
  }

  Widget _mostrarFoto() {
    if (producto.fotoUrl != null) {
      // tengo que hacer esto
      return FadeInImage(
                  image: NetworkImage(producto.fotoUrl),
                  placeholder: AssetImage('assets/jar-loading.gif'),
                  height: 300.0,
                  width: double.infinity,
                  fit: BoxFit.contain,
                );
    } else {
      return Image(
        image: AssetImage(foto?.path ?? 'assets/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }

  _seleccionarFoto() async {
   _procesarImagen( ImageSource.gallery );
  }

  _tomarFoto() async {
     _procesarImagen( ImageSource.camera );
  }

  _procesarImagen(ImageSource origen) async {

    foto = await ImagePicker.pickImage(
      source: origen
    );

    if ( foto != null ) {
      producto.fotoUrl = null;
    }

    setState(() {});
  }
}
