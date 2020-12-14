import 'package:ChristmasFoodGT/productsPage.dart';
import "package:flutter/material.dart";
import "./main.dart";

class FavoritesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    List<Widget> data(){
      List<Widget> list = List();
      for(int i = 0; i < productos.length; i++){
        print(i);
        for(int p = 0; p < productos[i].length; p++){
          print(p);
          if(!productos[i][p]["favorito"])
            list.add(ProductsPage(i + 1,p));
        }
      }
      return list;
    }
    return ListView(
      children: data()
    );
  }
}
