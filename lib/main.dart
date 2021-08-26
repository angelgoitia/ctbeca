import 'package:ctbeca/controller/globalController.dart';
import 'package:ctbeca/env.dart';
import 'package:ctbeca/views/welcomePage.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(messageHandler);
  runApp(MyApp());
}

Future<void> messageHandler(RemoteMessage message) async {
  GlobalController globalController = Get.put(GlobalController());
  print('onMessage: $message');
  globalController.showNotification(message.notification!.title, message.notification!.body);
  return;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CTBeca',
      theme: ThemeData(
        hoverColor: colorPrimary,
        primaryColor: colorPrimary,
        accentColor: colorPrimary,
        visualDensity: VisualDensity.adaptivePlatformDensity, 
        textSelectionTheme: TextSelectionThemeData(cursorColor: colorPrimary, selectionColor: colorPrimary),
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
