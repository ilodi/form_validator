import 'package:flutter/material.dart';
import 'package:formvalidator/src/models/producto_model.dart';
import 'package:formvalidator/src/providers/productos_provider.dart';
import 'package:formvalidator/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();

  ProductoModel producto = new ProductoModel();
//para poderla usar en otras clases
  final productoProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {
//obtener argumentos
    final ProductoModel proData = ModalRoute.of(context).settings.arguments;
    if (proData != null) {
      //reiniciar el producto
      producto = proData;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Producto interno'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {},
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
      onPressed: _sumbit,
    );
  }

  void _sumbit() {
    //Estado actual del formulario
    //Si es valido es un true
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    print(producto.titulo);
    print(producto.valor);
    print(producto.disponible);

    if (producto.id == null) {
      productoProvider.crearProducto(producto);
    } else {
      productoProvider.editarProducto(producto);
    }
  }
}
