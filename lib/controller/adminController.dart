import 'package:ctbeca/controller/globalController.dart';
import 'package:ctbeca/env.dart';
import 'package:ctbeca/models/admin.dart';
import 'package:ctbeca/models/history.dart';
import 'package:ctbeca/models/player.dart';
import 'package:ctbeca/views/admin/adminMainPage.dart';

import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdminController extends GetxController {
  final admin = Admin().obs;
  final players = <Player>[].obs;
  final histories = <History>[].obs;

  @override
  void onReady() {
    super.onReady();
  }

  List<Player> getListPlayers(data) {
    return data.map((val) => Player.fromJson(val)).toList();
  }

  getAdmin() async {
    GlobalController globalController = Get.put(GlobalController());
    var result, response, jsonResponse;

    try {
      result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

        response = await http.get(
          Uri.parse(urlApi+"admin"),
          headers:{
            'Content-Type': 'application/json',
            'X-Requested-With': 'XMLHttpRequest',
            'authorization': 'Bearer ${admin.value.accessToken}',
          },
        ); 

        print(response.body);
        jsonResponse = jsonDecode(response.body);

        if (jsonResponse['statusCode'] == 201) {

          players.value = (jsonResponse['players'] as List).map((val) => Player.fromJson(val)).toList();
          Get.off(AdminMainPage());

        } else{
          globalController.removeVariable();
        }  
      }
    } on SocketException catch (_) {
      //TODO: consultar BD        
    } 
  }
}