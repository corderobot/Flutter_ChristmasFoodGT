import 'dart:convert';
import 'dart:io';

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatelessWidget {
  String _name;
  String _precio;
  String _descripcion;
  int _idCompany;

  String respuestaBody;

  final int companyID;

  AddProduct(this.companyID);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<List> senddata() async {
  final response = await http.post("http://images.trepico.com.gt/archivos/conectionProd.php", body: {
    "name": _name,
    "price": _precio,
    "description": _descripcion,
    "idCompany": _idCompany.toString(),
    "photo": "http://images.trepico.com.gt/archivos/" + _name.replaceAll(new RegExp(r"\s+"), "") + ".jpg",
  });

  respuestaBody = response.body;
  print("Enviado");
  }

  Widget _buildNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Nombre'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'El nombre es requerido';
        }
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildPriceField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Precio'),
      keyboardType: TextInputType.numberWithOptions(decimal:true),
      validator: (String value) {
        if (value.isEmpty) {
          return 'El precio es requerido';
        }
      },
      onSaved: (String value) {
        _precio = value;
      },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Descripcion'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'La descripción es requerida';
        }
      },
      onSaved: (String value) {
        _descripcion = value;
      },
    );
  }

    final picker = ImagePicker();
    File _image;

  String base64Image;
  PickedFile pickedFile;

  static final String uploadEndPoint =
      'http://images.trepico.com.gt/archivos/uploadImg.php';

  Future<void> obtenerImagen() async {
    pickedFile = await picker.getImage(source: ImageSource.gallery);
  }

  void enviarImagen(){
 if (pickedFile != null) {
        _image = File(pickedFile.path);
        base64Image = base64Encode(_image.readAsBytesSync());
        http.post(uploadEndPoint, body: {
          "image": base64Image,
          "name": _name.replaceAll(new RegExp(r"\s+"), "") + ".jpg",
        }).then((result) {
          print("Listo");
        }).catchError((error) {
          print("Liston't");
        });
      } else {
        print('No image selected.');
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Añadir Producto"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNameField(),
              _buildDescriptionField(),
              _buildPriceField(),
              SizedBox(height: 50),
              RaisedButton(
                child: Text(
                  "Subir Imagen",
                  style: TextStyle(
                      color: Colors.lightBlueAccent[900], fontSize: 16),
                ),
                onPressed: obtenerImagen
              ),
              SizedBox(height: 50),
              RaisedButton(
                child: Text(
                  "Enviar",
                  style: TextStyle(
                      color: Colors.lightBlueAccent[900], fontSize: 16),
                ),
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _idCompany = companyID;
                  _formKey.currentState.save();
                  enviarImagen();
                  senddata();
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
