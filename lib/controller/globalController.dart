import 'dart:convert';

import 'package:ctbeca/controller/adminController.dart';
import 'package:ctbeca/controller/playerController.dart';
import 'package:ctbeca/env.dart';
import 'package:ctbeca/models/admin.dart';
import 'package:ctbeca/models/player.dart';
import 'package:ctbeca/views/loginPage.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GlobalController extends GetxController { 
  final indexSelect = 0.obs;
  final indexController = 0.obs; 
  DateTime? currentBackPressTime; 

  AdminController adminController = Get.put(AdminController());
  PlayerController playerController = Get.put(PlayerController());

  changeSelectIndex(int index)
  {
    indexSelect.value = index;
  }

  changeIndexController(int index){
    indexController.value = index;
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

  removeSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result, response, jsonResponse;

    loading();
    
    try {
      result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var route = prefs.getInt('type') == 0? "logout":"logoutPlayer";
        print("entro: ${playerController.player.value.tokenFCM}");
        response = await http.post(
          Uri.parse(urlApi+route),
          headers:{
            'Content-Type': 'application/json',
            'X-Requested-With': 'XMLHttpRequest',
            'authorization': 'Bearer ${prefs.getInt('type') == 0? adminController.admin.value.accessToken : playerController.player.value.accessToken}',
          },
        ); 

        print(response.body);
        jsonResponse = jsonDecode(response.body);

        if (jsonResponse['statusCode'] == 201) {
          
          Get.back();
          removeVariable();

        } else{
          Get.back();
          showMessage("intentalo de nuevo mas tardes!", false);
        }  
      }
    } on SocketException catch (_) {
      Get.back();
      showMessage("intentalo de nuevo mas tardes!", false);     
    }  

  }

  removeVariable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("access_token");
    prefs.remove("type");
    Get.off(LoginPage(), transition: Transition.zoom);
  }

  loading(){
    Get.defaultDialog(
      title: "",
      titlePadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      barrierDismissible: false,
      content: WillPopScope(
        onWillPop: () async => false,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5),
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(colorPrimary),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Cargando ",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'MontserratSemiBold',
                        )
                      ),
                      TextSpan(
                        text: "...",
                        style: TextStyle(
                          color: colorPrimary,
                          fontFamily: 'MontserratSemiBold',
                        )
                      ),
                    ]
                  ),
                ),
              ),
            ],
        ),
      ),
    );
  }

  showMessage(_titleMessage, _statusCorrectly) async {

    return Get.defaultDialog(
      title: '',
      titlePadding: EdgeInsets.zero,
      barrierDismissible: true,
      backgroundColor: Colors.white,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _statusCorrectly? Padding(
            padding: EdgeInsets.all(5),
            child: Icon(
              Icons.check_circle,
              color: colorPrimary,
              size: 30,
            )
          )
          : Padding(
            padding: EdgeInsets.all(5),
            child: Icon(
              Icons.error,
              color: Colors.red,
              size: 30,
            )
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Text(
              _titleMessage,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'MontserratSemiBold',
                fontSize:14
              ),
            ),
          ),
        ],
      ),
    );
  }
}