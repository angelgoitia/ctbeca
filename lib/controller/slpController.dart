import 'package:ctbeca/controller/adminController.dart';
import 'package:ctbeca/controller/globalController.dart';
import 'package:ctbeca/controller/playerController.dart';
import 'package:ctbeca/models/slp.dart';
import 'package:ctbeca/models/slpDate.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SLpController extends GetxController {
  final slpDate = SlpDate().obs;
  final listSlp = <Slp>[].obs, statusOrder=true.obs, statusLoading=false.obs;
  
  GlobalController globalController = Get.put(GlobalController());
  AdminController adminController = Get.put(AdminController());
  PlayerController playerController = Get.put(PlayerController());

  @override
  void onInit() async {
    super.onInit();
    statusLoading.value = true;
    await generateDate();
    await getListSlp();
    statusLoading.value = false;
  }  

  updateOrden(){
    statusOrder.value = !statusOrder.value;
    listSlp.value = listSlp.reversed.toList();
  }

  generateDate() async{
    statusLoading.value = true;
    var date;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    slpDate.value.rangeFinal = DateTime.now();
    slpDate.value.selectFinal = DateTime.now();
    
    if(DateTime.now().day <=15){
      date = DateTime(DateTime.now().year, DateTime.now().month, 1);
    }else{
      date = DateTime(DateTime.now().year, DateTime.now().month, 16);
    }

    slpDate.value.selectInitial = date;
    slpDate.value.rangeInitial = date;    

    if(prefs.getInt('type') == 0){
      for (var item in adminController.players[globalController.indexSelect.toInt()].listSlp!) {
        var dateItem = DateTime.parse(item.date!);

        if(dateItem.isBefore(slpDate.value.rangeInitial!))
          slpDate.value.rangeInitial = dateItem;
      } 
    }else{
      slpDate.value.rangeInitial = DateTime.parse(playerController.player.value.listSlp![0].date!);
    }
    statusLoading.value = false;
  }

  Future getListSlp() async {
    statusLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    AdminController adminController = Get.put(AdminController());
    PlayerController playerController = Get.put(PlayerController());

    listSlp.clear();
    
    if(prefs.getInt('type') == 0){
      for (var item in adminController.players[globalController.indexSelect.toInt()].listSlp!) {
        DateTime dateList = DateTime.parse(item.date!);
        var firstDate = slpDate.value.selectInitial!.subtract(Duration(days:1));
        var secondDate = slpDate.value.selectFinal!.add(Duration(days:1));
        if(firstDate.isBefore(dateList) && secondDate.isAfter(dateList))
          listSlp.add(item);
      }

    }else{
      for (var item in playerController.player.value.listSlp!) {
        DateTime dateList = DateTime.parse(item.date!);
        var firstDate = slpDate.value.selectInitial!.subtract(Duration(days:1));
        var secondDate = slpDate.value.selectFinal!.add(Duration(days:1));
        if(firstDate.isBefore(dateList) && secondDate.isAfter(dateList))
          listSlp.add(item);
      }
    }

    if(statusOrder.value)
      listSlp.value = listSlp.reversed.toList();

    statusLoading.value = false;
  }
  
}