import 'package:ctbeca/controller/adminController.dart';
import 'package:ctbeca/controller/playerController.dart';
import 'package:ctbeca/env.dart';
import 'package:ctbeca/models/admin.dart';
import 'package:ctbeca/models/player.dart';
import 'package:ctbeca/views/loginPage.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController extends GetxController {
   
  @override
  void onReady() {
    super.onReady();
    checkVersion();
    /* Future.delayed(Duration(seconds:2), (){
      Get.off(() => LoginPage(), transition: Transition.zoom);
    }); */
  }

  checkVersion()async{
    var result, response, jsonResponse;
    final PackageInfo info = await PackageInfo.fromPlatform();
    try {
      result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        response = await http.post(
          Uri.parse(urlApi+"version"),
          headers:{
            'Content-Type': 'application/json',
            'X-Requested-With': 'XMLHttpRequest',
          },
          body: jsonEncode({
            'app': 'ctpaga',
          }),
        ); 

        jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        if (jsonResponse['statusCode'] == 201) {
          if(info.version != jsonResponse['data']['version']){
            var versionApp = info.version;
            var newVersionApp = jsonResponse['data']['version'];
            showAlert(versionApp, newVersionApp);
          }else{
            passVariable();
          }
        }else{
          print("Error Network");
          passVariable();
        }
      }
    } on SocketException catch (_) {
      print("Error Network");
      passVariable();
    }
  }

  passVariable()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    AdminController adminController = Get.put(AdminController());
    PlayerController playerController = Get.put(PlayerController());

    if(prefs.containsKey('access_token') && prefs.containsKey('type') && prefs.getInt('type') == 0){

      adminController.admin.value = Admin(
        accessToken: prefs.getString('access_token'),
      );
      adminController.getAdmin(false);

    }else if(prefs.containsKey('access_token') && prefs.containsKey('type') && prefs.getInt('type') == 1 ){

      playerController.player.value = Player(
        accessToken: prefs.getString('access_token'),
      );
      playerController.getPlayer(false);

    }else{

      Future.delayed(Duration(seconds:2), (){
        Get.off(() => LoginPage(), transition: Transition.zoom);
      });
      
    }
  }

  showAlert(versionApp, newVersionApp) async {

    return Get.defaultDialog(
      title: 'Nueva versión',
      titlePadding: EdgeInsets.all(5),
      barrierDismissible: true,
      backgroundColor: Colors.white,
      content: WillPopScope(
        onWillPop: () async =>false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:[
            Text(
              "Versión Actual es $versionApp y la nueva versión es $newVersionApp.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontFamily: 'MontserratSemiBold',
              ),
            ),
            SizedBox(height: 20,),
            Text(
              "Por favor Actualice Ctpaga desde tu tienda favorita",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontFamily: 'MontserratSemiBold',
              ),
            ),
          ]
        ),
      ),
    );
  }
}