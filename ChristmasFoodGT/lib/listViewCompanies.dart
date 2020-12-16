import 'dart:convert';

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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CompanyData>>(
      future: fetchCompanies(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        return ListView(
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
                              child: Image.network(data.companyPhoto),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Text(data.companyName),
                                  Text(data.companyType)
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
                      onTap: (){
                        selectCompany(data.companyID);
                      },
                    ),
                  ],
                ),
              ).toList(),
        );
      },
    );
  }
}
