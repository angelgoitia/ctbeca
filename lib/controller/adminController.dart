import 'package:ctbeca/controller/globalController.dart';
import 'package:ctbeca/env.dart';
import 'package:ctbeca/models/admin.dart';
import 'package:ctbeca/models/claim.dart';
import 'package:ctbeca/models/myRow.dart';
import 'package:ctbeca/models/player.dart';
import 'package:ctbeca/views/admin/adminMainPage.dart';

import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdminController extends GetxController {
  final admin = Admin().obs;
  final players = <Player>[].obs;
  final dataGraphic = <MyRow>[].obs;
  final statusPoints = false.obs;
  final selectMyRow = MyRow().obs;

  @override
  void onReady() {
    super.onReady();
    statusPoints.value = false;
  }

  List<Player> getListPlayers(data) {
    return data.map((val) => Player.fromJson(val)).toList();
  }

  getAdmin(bool loading) async {
    GlobalController globalController = Get.put(GlobalController());
    var result, response, jsonResponse;

    if(loading)
      globalController.loading();

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
        print("token: ${admin.value.accessToken}");
        print(response.body);
        jsonResponse = jsonDecode(response.body);

        if (jsonResponse['statusCode'] == 201) {
          
          String? accessToken = admin.value.accessToken;
          admin.value = new Admin.fromJson(jsonResponse['admin']);
          admin.value.accessToken = accessToken;
          players.value = (jsonResponse['players'] as List).map((val) => Player.fromJson(val)).toList();
          globalController.dbctbeca.createOrUpdateAdmin(admin.value);
          globalController.dbctbeca.createOrUpdateListPlayer(players);
          globalController.getPriceSLP();
          await getDataGraphic();
          Get.off(() => AdminMainPage());

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
        admin.value = await globalController.dbctbeca.getAdmin();
        players.value = await globalController.dbctbeca.getPlayers();
        Get.off(() => AdminMainPage());
      }
      
    } 
  }

  Future  getDataGraphic() async {
    dataGraphic.value = <MyRow>[];
    for( var i = 15 ; i >= 1; i-- ) { 
      final dateLastSixDays = i == 1? DateTime.now() : DateTime.now().subtract(Duration(days:i-1));
      var statusForeach = false;
      int totalSlp = 0;
      for (var player in players) {
        for (var item in player.listSlp!) {
          DateTime dateList = DateTime.parse(item.date!);
          if(dateList.day == dateLastSixDays.day && dateList.month == dateLastSixDays.month && dateList.year == dateLastSixDays.year){
            statusForeach = true;
            totalSlp += item.daily!;
          }
        } 
      }


      if(statusForeach)
        dataGraphic.add(
          MyRow(timeStamp: dateLastSixDays, amount: totalSlp)
        );
      else
        dataGraphic.add(
          MyRow(timeStamp: dateLastSixDays, amount: 0)
        );
    } 
    
    return true;
  }
}