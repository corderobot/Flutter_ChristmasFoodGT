import 'package:flutter/material.dart';
import 'package:slimy_card/slimy_card.dart';

import 'package:flutter/gestures.dart';

import 'package:url_launcher/url_launcher.dart';

var url = 'https://www.instagram.com/corderobot/';

class MySlimyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        // This streamBuilder reads the real-time status of SlimyCard.
        initialData: false,
        stream: slimyCard.stream, //Stream of SlimyCard
        builder: ((BuildContext context, AsyncSnapshot snapshot) {
          return ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(height: 70),

              // SlimyCard is being called here.
              SlimyCard(
                color: Colors.green,
                topCardWidget: topCardWidget((snapshot.data)
                    ? 'assets/images/Yo2.jpg'
                    : 'assets/images/Yo2.jpg'),
                bottomCardWidget: bottomCardWidget(),
              ),
            ],
          );
        }),
      ),
    );
  }

  // This widget will be passed as Top Card's Widget.
  Widget topCardWidget(String imagePath) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(15),
            image:
                DecorationImage(image: AssetImage(imagePath), fit: BoxFit.fill),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Text(
          'Rodrigo Cordero',
          style:
              TextStyle(fontFamily: 'Nerko', fontSize: 30, color: Colors.white),
        ),
        SizedBox(height: 15),
        Text(
          'Ingeniero Mecatrónico',
          style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  // This widget will be passed as Bottom Card's Widget.
  Widget bottomCardWidget() {
    return RichText(
      text: new TextSpan(text: 'Instagram: ', children: [
        new TextSpan(
            text: "@Corderobot",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                var url = "https://www.instagram.com/corderobot/";
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              }),
      ]),
    );
  }
}
