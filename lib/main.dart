import 'package:ctbeca/controller/mainController.dart';
import 'package:ctbeca/env.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Reto Flutter',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GetBuilder<MainController>(
      init: MainController(),
      builder: (_home) => Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: colorPrimary,
          )
        )
      ),
    ),
    );
  }

}
