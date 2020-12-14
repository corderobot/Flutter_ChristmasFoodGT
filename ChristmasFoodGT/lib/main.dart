import 'package:ChristmasFoodGT/favoritesPage.dart';
import 'package:ChristmasFoodGT/productsPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import './slimyCard.dart';
import './listViewCompanies.dart';

import 'package:connectivity/connectivity.dart';

var url = 'https://www.instagram.com/corderobot/';

enum _SelectedTab { inicio, favoritos, creditos }
int nCompany = 0;
int _isConnected = 0;

  final productos = [
    [{
      "foto": "http://images.trepico.com.gt/images/Pierna.jpg",
      "titulo": "Pierna",
      "descripcion": "Pierna Horneada en salsa navideña con vino tinto",
      "precio": "Q50.00",
      "cantidad": "1 lb",
      "favorito": false
    },
    {
      "foto": "http://images.trepico.com.gt/images/Tamal.jpg",
      "titulo": "Tamal",
      "descripcion":
          "Tamal negro o Colorado de Pollo, Cerdo o Pavo",
      "precio": "Q15.00",
      "cantidad": "1 porcion",
      "favorito": false
    }],
    [{
      "foto": "http://images.trepico.com.gt/images/Reno.jpg",
      "titulo": "Reno",
      "descripcion":
          "Mousse de Nuez con Toffee, Relleno de Avellana, Bizcocho de Almendra y Sable Clásico",
      "precio": "Q35.00",
      "cantidad": "1 porcion",
      "favorito": false
    },
    {
      "foto": "http://images.trepico.com.gt/images/SmoreTart.jpg",
      "titulo": "Smore's Tart",
      "descripcion": "Tarta rellena de Cremoso de Chocolate, Marshmallow Flameado, Crema de Marshmallow de la Casa y Mini Brownie Bites",
      "precio": "Q35.00",
      "cantidad": "1 lb",
      "favorito": false
    }]
  ];

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/OFLNerko.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<MyApp> {
  var _selectedTab = _SelectedTab.inicio;

  hasAsync() {
    asyncFunction().then((val) {
      _handleConnection(val);
    });
  }

  Future<int> asyncFunction() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){
      return 1;
    }else{
      return 2;
    };
  }

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
      nCompany = 0;
    });
  }

  void _handleConnection(int i) {
    setState(() {
      _isConnected = i;
    });
  }

  void _handleCompanySelected(int i) {
    setState(() {
      nCompany = i;
      print(i);
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_isConnected == 0) hasAsync();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Comida Navideña"),
          backgroundColor: Colors.green,
          actions: [
            _isConnected == 1 ? Container() : Icon(Icons.wifi_off)
          ],
        ),
        body: nCompany > 0
            ? ProductsPage(nCompany, 0)
            : _SelectedTab.values.indexOf(_selectedTab) == 0
                ? ListViewCompanies(_handleCompanySelected)
                : _SelectedTab.values.indexOf(_selectedTab) == 1
                    ? FavoritesPage()
                    : MySlimyCard(),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          onTap: _handleIndexChanged,
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: Icon(Icons.home),
              title: Text("Inicio"),
              selectedColor: Colors.grey[400],
            ),

            /// Likes
            SalomonBottomBarItem(
              icon: Icon(Icons.favorite),
              title: Text("Favoritos"),
              selectedColor: Colors.red[700],
            ),

            /// Search
            SalomonBottomBarItem(
              icon: Icon(Icons.account_circle),
              title: Text("Creditos"),
              selectedColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
