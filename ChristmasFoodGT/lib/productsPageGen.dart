import 'dart:convert';

import 'package:ChristmasFoodGT/addProduct.dart';
import 'package:ChristmasFoodGT/likeButton.dart';
import 'package:ChristmasFoodGT/prodDetailPage.dart';
import "package:flutter/material.dart";
import "./main.dart";

import 'package:http/http.dart' as http;

class ProductData {
  int productID;
  String productName;
  String productPrice;
  String productDescription;
  int productCompany;
  String productFoto;

  ProductData({
    this.productID,
    this.productName,
    this.productPrice,
    this.productDescription,
    this.productCompany,
    this.productFoto,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
        productID: json['ID'],
        productName: json['Nombre'],
        productPrice: json['Precio'].toString(),
        productDescription: json['Descripcion'],
        productFoto: json['foto'],
        productCompany: json['IDCompania']);
  }
}

class ProductsPageGen extends StatelessWidget {
  final int nCompayGen;
  final Function changeLike;

  ProductsPageGen(this.nCompayGen, this.changeLike);

  Function ah = () {};

  void pushRoute(BuildContext context, String titulo, String etiquetaPush,
      String descripcion, String foto) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(seconds: 1),
        pageBuilder: (context, animation, secondaryAnimation) =>
            ProdDetailPage(titulo, descripcion, foto, etiquetaPush),
      ),
    );
  }

  void pushRouteAdd(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(seconds: 1),
        pageBuilder: (context, animation, secondaryAnimation) =>
            AddProduct(nCompayGen),
      ),
    );
  }

  final String apiURL =
      'http://images.trepico.com.gt/archivos/conectionGetProducts.php';

  Future<List<ProductData>> fetchProducts() async {
    try {
      var response =
          await http.post(apiURL, body: {"aidi": nCompayGen.toString()});

      if (response.statusCode == 200) {
        final items = json.decode(response.body).cast<Map<String, dynamic>>();

        List<ProductData> studentList = items.map<ProductData>((json) {
          return ProductData.fromJson(json);
        }).toList();

        return studentList;
      } else {
        throw Exception('Failed to load data from Server.');
      }
    } catch (e) {
      print(e);
      return [
        new ProductData(
            productName: "No hay productos",
            productID: 1,
            productFoto: "http://images.trepico.com.gt/archivos/error.png",
            productPrice: "0",
            productDescription: "Producto inexistente",
            productCompany: 0)
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
/*     List<Widget> data() {
      List<Widget> list = List();
      for (int i = 0; i < productos[nCompayGen - 1].length; i++) {
        list.add(ProductsPage(nCompayGen, i, changeLike));
      }
      return list;
    } */

    return FutureBuilder<List<ProductData>>(
      future: fetchProducts(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        return Column(
          children: [
            Text(
              "Click en la imágen para + información",
              style: TextStyle(fontSize: 20),
            ),
            Column(
              children: snapshot.data
                  .map(
                    (data) => Column(
                      children: [
                        Container(
                          color: Colors.lightBlue[300],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)),
                                child: GestureDetector(
                                  onTap: () => pushRoute(
                                      context,
                                      data.productName,
                                      "fotoProd" + data.productName,
                                      data.productDescription,
                                      data.productFoto),
                                  child: Hero(
                                    tag: "fotoProd" + data.productName,
                                    child: Image.network(
                                      data.productFoto,
                                      width: 120,
                                      fit: BoxFit.fill,
                                      height: 100,
                                      loadingBuilder:
                                          (context, child, progress) {
                                        if (progress == null) return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: progress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? progress
                                                        .cumulativeBytesLoaded /
                                                    progress.expectedTotalBytes
                                                : Icon(Icons.error),
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.green[900]),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Text(
                                      data.productName,
                                      style: TextStyle(
                                        fontFamily: 'Nerko',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      "Q" + data.productPrice,
                                      style: TextStyle(
                                        fontFamily: 'Nerko',
                                        fontSize: 15,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: MyLikeButton(1, 1, changeLike),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
            RaisedButton(
                child: Text(
                  "Agregar Producto",
                  style: TextStyle(
                      color: Colors.lightBlueAccent[900], fontSize: 20, fontFamily: 'Nerko'),
                ),
                onPressed: () {
                  pushRouteAdd(context);
                }),
            SizedBox(height: 50),
          ],
        );
      },
    );
  }
}
