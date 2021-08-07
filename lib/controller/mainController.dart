import 'package:ctbeca/controller/adminController.dart';
import 'package:ctbeca/controller/playerController.dart';
import 'package:ctbeca/models/admin.dart';
import 'package:ctbeca/models/player.dart';
import 'package:ctbeca/views/loginPage.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController extends GetxController {
   
  @override
  void onReady() {
    super.onReady();
    passVariable();
    /* Future.delayed(Duration(seconds:2), (){
      Get.off(LoginPage(), transition: Transition.zoom);
    }); */
  }

  passVariable()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    AdminController adminController = Get.put(AdminController());
    PlayerController playerController = Get.put(PlayerController());

    if(prefs.containsKey('access_token') && prefs.containsKey('type') && prefs.getInt('type') == 0){

      adminController.admin.value = Admin(
        accessToken: prefs.getString('access_token'),
      );
      adminController.getAdmin();

    }else if(prefs.containsKey('access_token') && prefs.containsKey('type') && prefs.getInt('type') == 1 ){

      playerController.player.value = Player(
        accessToken: prefs.getString('access_token'),
      );
      playerController.getPlayer();

    }else{

      Future.delayed(Duration(seconds:2), (){
        Get.off(LoginPage(), transition: Transition.zoom);
      });
      
    }
  }
}