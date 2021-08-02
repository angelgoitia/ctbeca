import 'package:auto_size_text/auto_size_text.dart';
import 'package:ctbeca/controller/mainController.dart';
import 'package:ctbeca/env.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return GetMaterialApp(
      title: 'CTBeca',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GetBuilder<MainController>(
        init: MainController(),
        builder: (_home) => WillPopScope(
          onWillPop: () async =>false,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage("assets/axies.png"),
                    width: size.width/2,
                  ),
                  Container(
                    padding: EdgeInsets.only(top:5, bottom: 5),
                    child: AutoSizeText(
                      "Cargando...",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'MontserratSemiBold',
                      ),
                      maxFontSize: 24,
                      minFontSize: 24,
                    ),
                  ),
                  CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(colorPrimary),
                  ),
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }

}
