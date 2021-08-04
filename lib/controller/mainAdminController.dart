import 'package:getwidget/getwidget.dart';
import 'package:get/get.dart';
import 'dart:io';

class MainAdminController extends GetxController {
  DateTime? currentBackPressTime;  

  @override
  void onReady() {
    super.onReady();
  }

  Future<bool> onBackPressed()
  {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      GFToast(
        text: 'Presiona dos veces para salir de la aplicación',
        autoDismiss: true,
      );
      return Future.value(false);
    }
    return exit(0);
  }

}