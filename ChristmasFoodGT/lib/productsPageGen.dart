import 'package:ChristmasFoodGT/productsPage.dart';
import "package:flutter/material.dart";
import "./main.dart";

class ProductsPageGen extends StatelessWidget {
  final int nCompayGen;
  final Function changeLike;

  ProductsPageGen(this.nCompayGen, this.changeLike);

  @override
  Widget build(BuildContext context) {
    List<Widget> data() {
      List<Widget> list = List();
      for (int i = 0; i < productos[nCompayGen - 1].length; i++) {
        list.add(ProductsPage(nCompayGen, i, changeLike));
      }
      return list;
    }

    return Column(
      children: [
        Text("Click en la imágen para + información", style: TextStyle(fontSize: 20),),
        Expanded(
          child: ListView(children: data().length == 0 ? Container() : data()),
        ),
      ],
    );
  }
}
