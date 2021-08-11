import 'package:ctbeca/controller/globalController.dart';
import 'package:ctbeca/env.dart';
import 'package:ctbeca/models/history.dart';
import 'package:ctbeca/models/myRow.dart';
import 'package:ctbeca/models/player.dart';
import 'package:ctbeca/views/player/playerMainPage.dart';

import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class PlayerController extends GetxController {
  final player = Player().obs;
  final dataGraphic = <MyRow>[].obs;
  final histories = <History>[].obs;
  
  getPlayer(bool loading) async {
    GlobalController globalController = Get.put(GlobalController());
    var result, response, jsonResponse;

    if(loading)
      globalController.loading();
    
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

          String? accessToken = player.value.accessToken;
          player.value = new Player.fromJson(jsonResponse['player']);
          player.value.accessToken = accessToken;
          globalController.dbctbeca.createOrUpdatePlayer(player.value);
          await getDataGraphic();
          Get.off(() => PlayerMainPage());

        } else
          globalController.removeVariable();

        if(loading)
          Get.back();
      }
    } on SocketException catch (_) {

      if(loading){
        Get.back();
        globalController.showMessage("Sin conexión a internet", false); 
        await Future.delayed(Duration(seconds: 1));
        Get.back();
      }else{
        player.value = await globalController.dbctbeca.getPlayer(player.value.accessToken);
        Get.off(() => PlayerMainPage());
      }

    } 
  }

  Future getDataGraphic() async {
    dataGraphic.value = <MyRow>[];
    for( var i = 6 ; i >= 1; i-- ) { 
      final dateLastSixDays = i == 1? DateTime.now() : DateTime.now().subtract(Duration(days:i-1));
      var statusForeach = false;
      for (var item in player.value.listSlp!) {
        DateTime dateList = DateTime.parse(item.date!);
        if(dateList.day == dateLastSixDays.day && dateList.month == dateLastSixDays.month && dateList.year == dateLastSixDays.year){
          statusForeach = true;
          dataGraphic.add(
            MyRow(dateLastSixDays, item.daily!)
          );
        }
      }

      if(!statusForeach)
        dataGraphic.add(
          MyRow(dateLastSixDays, 0)
        );

    } 

    return true;
  }
}