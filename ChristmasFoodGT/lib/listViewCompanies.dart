import 'dart:convert';

import 'package:ChristmasFoodGT/companyDetail.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class CompanyData {
  int companyID;
  String companyName;
  String companyAddress;
  int companyTel;
  String companyType;
  String companyEmail;
  String companyPhoto;

  CompanyData({
    this.companyID,
    this.companyName,
    this.companyAddress,
    this.companyTel,
    this.companyEmail,
    this.companyPhoto,
    this.companyType,
  });

  factory CompanyData.fromJson(Map<String, dynamic> json) {
    return CompanyData(
        companyID: json['ID'],
        companyName: json['Nombre'],
        companyAddress: json['Direccion'],
        companyEmail: json['Correo'],
        companyPhoto: json['foto'],
        companyTel: json['Telefono'],
        companyType: json['TipoComida']);
  }
}

class ListViewCompanies extends StatelessWidget {
  final Function selectCompany;

  ListViewCompanies(this.selectCompany);

  final String apiURL =
      'http://images.trepico.com.gt/archivos/conectionGetCompanies.php';

  Future<List<CompanyData>> fetchCompanies() async {
    var response = await http.get(apiURL);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<CompanyData> studentList = items.map<CompanyData>((json) {
        return CompanyData.fromJson(json);
      }).toList();

      return studentList;
    } else {
      throw Exception('Failed to load data from Server.');
    }
  }

  void pushRoute(BuildContext context, String titulo, String descripcion,
      String foto, String direccion, int tel) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(seconds: 1),
        pageBuilder: (context, animation, secondaryAnimation) =>
            CompanyDetail(titulo, foto, descripcion, direccion, tel),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CompanyData>>(
      future: fetchCompanies(),
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
                      children: <Widget>[
                        InkWell(
                          child: Container(
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
                                        data.companyName,
                                        data.companyEmail,
                                        data.companyPhoto,
                                        data.companyAddress,
                                        data.companyTel),
                                    child: Hero(
                                      tag: data.companyName,
                                      child: Image.network(data.companyPhoto),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Text(data.companyName,
                                          style: TextStyle(
                                              fontFamily: 'Nerko',
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      Text(data.companyType,
                                          style: TextStyle(
                                              fontFamily: 'Nerko',
                                              fontSize: 15))
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 40,
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            selectCompany(data.companyID);
                          },
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}
