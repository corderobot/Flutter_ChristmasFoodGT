import "package:flutter/material.dart";


class FavoritesPage extends StatelessWidget {

  final Function changeLike;

  FavoritesPage(this.changeLike);

  @override
  Widget build(BuildContext context) {

    List<Widget> data(){
      List<Widget> list = List();

      return list;
    }
    return ListView(
      children: data()
    );
  }
}
