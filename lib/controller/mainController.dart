import 'package:ctbeca/views/loginPage.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
   
  @override
  void onReady() {
    super.onReady();
    Future.delayed(Duration(seconds:2), (){
      Get.off(LoginPage(), transition: Transition.zoom);
    });
  }
}