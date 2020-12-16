import "package:flutter/material.dart";

class ProdDetailPage extends StatelessWidget {
  final String etiquetaPush, titulo, descripcion, foto;

  ProdDetailPage(this.titulo, this.descripcion, this.foto, this.etiquetaPush);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titulo,
          style: TextStyle(
            fontFamily: 'Nerko',
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Hero(
            tag: etiquetaPush,
            child: Image.network(foto),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              descripcion,
              style: TextStyle(
                fontFamily: 'Nerko', fontSize: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}
