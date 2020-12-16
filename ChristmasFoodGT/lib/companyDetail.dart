import "package:flutter/material.dart";

class CompanyDetail extends StatelessWidget {
  final String titulo, descripcion, foto, dir;
  final int tel;

  CompanyDetail(this.titulo, this.foto, this.descripcion, this.dir, this.tel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titulo,
          style: TextStyle(
            fontFamily: 'Nerko', fontSize: 30
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Hero(
            tag: titulo,
            child: Image.network(foto),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              "Teléfono: " + tel.toString(),
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              "Dirección: " + dir,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              "Email: " + descripcion,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
