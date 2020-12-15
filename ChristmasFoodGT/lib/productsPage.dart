import 'package:ChristmasFoodGT/prodDetailPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'likeButton.dart';
import './main.dart';

class ProductsPage extends StatelessWidget {
  final int nCompany, nElemento;
  final Function changeLike;

  ProductsPage(this.nCompany, this.nElemento, this.changeLike);

  void pushRoute(
      BuildContext context, Map<String, Object> titulo, String etiquetaPush) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(seconds: 1),
        pageBuilder: (context, animation, secondaryAnimation) =>
            ProdDetailPage(titulo, nCompany, nElemento, etiquetaPush),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String etiqueta = "fotoProd" + nCompany.toString() + nElemento.toString();
    return Container(
      child: Container(
        color: Colors.lightBlue[300],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 100,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: GestureDetector(
                onTap: () => pushRoute(
                    context, productos[nCompany - 1][nElemento], etiqueta),
                child: Hero(
                  tag: etiqueta,
                  child: Image.network(
                    productos[nCompany - 1][nElemento]["foto"],
                    width: 120,
                    fit: BoxFit.fill,
                    height: 100,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: progress.expectedTotalBytes != null
                              ? progress.cumulativeBytesLoaded /
                                  progress.expectedTotalBytes
                              : Icon(Icons.error),
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green[900]),
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
                  Text(productos[nCompany - 1][nElemento]["titulo"]),
                  Text(productos[nCompany - 1][nElemento]["precio"])
                ],
              ),
            ),
            Container(
              child: MyLikeButton(nCompany, nElemento, changeLike),
            )
          ],
        ),
      ),
    );
  }
}
