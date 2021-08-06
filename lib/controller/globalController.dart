import 'package:ctbeca/env.dart';
import 'package:ctbeca/models/player.dart';
import 'package:ctbeca/models/admin.dart';
import 'package:ctbeca/views/admin/adminMainPage.dart';
import 'package:ctbeca/views/loginPage.dart';
import 'package:ctbeca/views/player/playerMainPage.dart';

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GlobalController extends GetxController {
  DateTime? currentBackPressTime;  
  Admin admin = Admin();
  Player player = Player();
  List<Player> players = <Player>[].obs;


  List<Player> getListPlayers(data) {
    return data.map((val) => Player.fromJson(val)).toList();
  }

  getAdmin()async {
    var result, response, jsonResponse;

    try {
        result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

          response = await http.get(
            Uri.parse(urlApi+"admin"),
            headers:{
              'Content-Type': 'application/json',
              'X-Requested-With': 'XMLHttpRequest',
              'authorization': 'Bearer ${admin.accessToken}',
            },
          ); 

          print(response.body);
          jsonResponse = jsonDecode(response.body);

          if (jsonResponse['statusCode'] == 201) {

            players = (jsonResponse['players'] as List).map((val) => Player.fromJson(val)).toList();
            Get.off(AdminMainPage());

          } else{
            //TODO: cerrar session
            removeSession();
          }  
        }
      } on SocketException catch (_) {
        //TODO: consultar BD        
      } 
  }

  getPlayer()async {
    var result, response, jsonResponse;

    try {
        result = await InternetAddress.lookup('google.com'); //verify network
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

          response = await http.get(
            Uri.parse(urlApi+"player"),
            headers:{
              'Content-Type': 'application/json',
              'X-Requested-With': 'XMLHttpRequest',
              'authorization': 'Bearer ${player.accessToken}',
            },
          ); // petición api

          print(response.body);
          jsonResponse = jsonDecode(response.body);

          if (jsonResponse['statusCode'] == 201) {

            GlobalController().player = new Player.fromJson(jsonResponse);
            Get.off(PlayerMainPage());

          } else{
            //TODO: cerrar session
            removeSession();
          }  
        }
      } on SocketException catch (_) {
        //TODO: consultar BD        
      } 
  }

  removeSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("access_token");
    prefs.remove("type");
    Get.off(LoginPage(), transition: Transition.zoom);
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


  loading(){
    Get.defaultDialog(
      title: "",
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
}