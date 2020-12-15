import "package:flutter/material.dart";

class ProdDetailPage extends StatelessWidget {
  final Map<String, Object> producto;
  final int nCompany, nElemento;
  final String etiquetaPush;

  ProdDetailPage(this.producto,this.nCompany,this.nElemento,this.etiquetaPush);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(producto["titulo"]),
      ),
      body: Column(
        children: [
          Hero(
            tag: etiquetaPush,
            child: Image.network(producto["foto"]),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              producto["descripcion"],
              style: TextStyle(fontSize: 30),
            ),
          )
        ],
      ),
    );
  }
}
