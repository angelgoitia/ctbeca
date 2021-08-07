import 'package:ctbeca/controller/globalController.dart';
import 'package:ctbeca/env.dart';
import 'package:ctbeca/models/history.dart';
import 'package:ctbeca/models/player.dart';
import 'package:ctbeca/views/player/playerMainPage.dart';

import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PlayerController extends GetxController {
  final player = Player().obs;
  RxList<History> histories = <History>[].obs;

  getPlayer() async {
    GlobalController globalController = Get.put(GlobalController());
    var result, response, jsonResponse;
    print("entro ${player.value.accessToken}");
    try {
      result = await InternetAddress.lookup('google.com'); //verify network
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

        response = await http.get(
          Uri.parse(urlApi+"player"),
          headers:{
            'Content-Type': 'application/json',
            'X-Requested-With': 'XMLHttpRequest',
            'authorization': 'Bearer ${player.value.accessToken}',
          },
        ); // petición api

        print(response.body);
        jsonResponse = jsonDecode(response.body);

        if (jsonResponse['statusCode'] == 201) {

          player.value = new Player.fromJson(jsonResponse['player']);
          Get.off(PlayerMainPage());

        } else{
          globalController.removeVariable();
        }  
      }
    } on SocketException catch (_) {
      //TODO: consultar BD        
    } 
  }
}