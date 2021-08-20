import 'package:ctbeca/env.dart';
import 'package:ctbeca/views/welcomePage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CTBeca',
      theme: ThemeData(
        primaryColor: colorPrimary,
        accentColor: colorPrimary,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('es'),
      ],
      home: WelcomePage(),
    );
  }

}
