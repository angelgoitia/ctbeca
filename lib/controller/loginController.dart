import 'package:ctbeca/controller/globalController.dart';
import 'package:ctbeca/controller/adminController.dart';
import 'package:ctbeca/controller/playerController.dart';
import 'package:ctbeca/env.dart';
import 'package:ctbeca/models/player.dart';
import 'package:ctbeca/models/admin.dart';
import 'package:ctbeca/views/admin/adminMainPage.dart';
import 'package:ctbeca/views/player/playerMainPage.dart';

import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class LoginController extends GetxController {  
  final messageError = ''.obs;
  final passwordVisible = true.obs, statusError = false.obs;

  @override
  void onInit() {
    super.onInit();
    passwordVisible.value = true;
    statusError.value = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  validarEmail(String value){
    value = value.trim().toLowerCase();
    // This is just a regular expression for email addresses
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (value.isNotEmpty && regExp.hasMatch(value)) {
      return null;    
    }

    return "Ingrese un correo electrónico válido"; 

  }

  formSubmit(email, password)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    GlobalController globalController = Get.put(GlobalController());
    AdminController adminController = Get.put(AdminController());
    PlayerController playerController = Get.put(PlayerController());
    var result, response, jsonResponse;

    globalController.loading();

    try {
      result = await InternetAddress.lookup('google.com'); 
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

        var parameters = jsonToUrl(jsonEncode({
          'email': email,
          'password': password,
        }));

        response = await http.get(
          Uri.parse(urlApi+"login/$parameters"),
          headers:{
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'X-Requested-With': 'XMLHttpRequest',
          },
        ); // petición api
        print(response.body);
        jsonResponse = jsonDecode(response.body);

        if (jsonResponse['statusCode'] == 201 && jsonResponse['type'] == 0) {

          statusError.value = false;
          prefs.setString('access_token', jsonResponse['access_token']);
          prefs.setInt('type',0);
          adminController.admin.value = new Admin.fromJson(jsonResponse['admin']);
          adminController.admin.value.accessToken = jsonResponse['access_token'];
          adminController.players.value = (jsonResponse['players'] as List).map((val) => Player.fromJson(val)).toList();
          adminController.admins.value = (jsonResponse['admins'] as List).map((val) => Admin.fromJson(val)).toList();
          globalController.dbctbeca.createOrUpdateAdmin(adminController.admin.value);
          globalController.dbctbeca.createOrUpdateListAdmins(adminController.admins);
          globalController.dbctbeca.createOrUpdateListPlayer(adminController.players);
          globalController.getPriceSLP();
          Get.back();
          Get.off(() => AdminMainPage());

        } else if(jsonResponse['statusCode'] == 201 && jsonResponse['type'] == 1) {

          statusError.value = false;
          prefs.setString('access_token', jsonResponse['access_token']);
          prefs.setInt('type',1);
          playerController.player.value = new Player.fromJson(jsonResponse['player']);
          playerController.player.value.accessToken = jsonResponse['access_token'];
          globalController.dbctbeca.createOrUpdatePlayer(playerController.player.value);
          globalController.getPriceSLP();
          Get.back();
          Get.off(() => PlayerMainPage());

        } else if(jsonResponse['statusCode'] == 400){

          statusError.value = true;
          messageError.value = jsonResponse['message'];

        } else if(jsonResponse['message'] == 'Unauthorized'){

          statusError.value = true;
          messageError.value = "Email o contraseña incorrectos";

        }  
      }
    } on SocketException catch (_) {
      
      statusError.value = true;
      messageError.value = "Sin conexión, inténtalo de nuevo mas tarde";
      
    }  

    if (statusError.value)
      Get.back(result: true);

  }


  String jsonToUrl(value){
    String parametersUrl="?";
    final json = jsonDecode(value) as Map;
    for (final name in json.keys) {
      final value = json[name];
      parametersUrl = parametersUrl + "$name=$value&";
    }
    
    return parametersUrl.substring(0, parametersUrl.length-1);
  }
}