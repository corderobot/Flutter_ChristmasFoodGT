import 'package:flutter/material.dart';

class ListViewCompanies extends StatelessWidget {
  final Function selectCompany;

  ListViewCompanies(this.selectCompany);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          InkWell(
            child: Container(
              color: Colors.lightBlue[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 100,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: Image.network(
                      'http://images.trepico.com.gt/images/CasaTipica.jpg',
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
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.green[900]),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [Text("Casa Típica"), Text("Salado")],
                    ),
                  ),
                  Container(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              selectCompany(1);
            },
          ),
          InkWell(
            child: Container(
              color: Colors.lightBlue[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 100,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: Image.network(
                      'http://images.trepico.com.gt/images/Trepico.jpg',
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
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.green[900]),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [Text("Trepico"), Text("Dulce")],
                    ),
                  ),
                  Container(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              selectCompany(2);
            },
          ),
        ],
      ),
    );
  }
}
