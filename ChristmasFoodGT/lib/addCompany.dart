import 'dart:convert';
import 'dart:io';

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AddCompany extends StatelessWidget {
  String _name;
  String _address;
  String _telephone;
  String _type;
  String _email;

  String respuestaBody;

  final Function regresar;

  AddCompany(this.regresar);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<List> senddata() async {
  final response = await http.post("http://images.trepico.com.gt/archivos/conection.php", body: {
    "name": _name,
    "address": _address,
    "telephone": _telephone,
    "type": _type,
    "email": _email,
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

  Widget _buildAddressField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Dirección'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'La dirección es requerida';
        }
      },
      onSaved: (String value) {
        _address = value;
      },
    );
  }

  Widget _buildTelephoneField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Teléfono'),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'El teléfono es requerido';
        }
      },
      onSaved: (String value) {
        _telephone = value;
      },
    );
  }

  Widget _buildTypeField() {
    return TextFormField(
      decoration: InputDecoration(labelText: '(Salado, dulce...)'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'El tipo es requerido';
        }
      },
      onSaved: (String value) {
        _type = value;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Correo'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'El correo es requerido';
        }
      },
      onSaved: (String value) {
        _email = value;
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
    return Container(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNameField(),
              _buildAddressField(),
              _buildEmailField(),
              _buildTelephoneField(),
              _buildTypeField(),
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
                  _formKey.currentState.save();
                  enviarImagen();
                  senddata();
                  regresar(0);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
