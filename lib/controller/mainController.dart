import 'package:ctbeca/controller/globalController.dart';
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

    GlobalController globalController = Get.put(GlobalController());

    if(prefs.containsKey('access_token') && prefs.containsKey('type') && prefs.getInt('type') == 0){

      globalController.admin = Admin(
        accessToken: prefs.getString('access_token'),
      );
      globalController.getAdmin();

    }else if(prefs.containsKey('access_token') && prefs.containsKey('type') && prefs.getInt('type') == 1 ){

      globalController.player = Player(
        accessToken: prefs.getString('access_token'),
      );
      globalController.getPlayer();

    }else{

      Future.delayed(Duration(seconds:2), (){
        Get.off(LoginPage(), transition: Transition.zoom);
      });
      
    }
  }
}