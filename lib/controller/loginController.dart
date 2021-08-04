import 'package:ctbeca/controller/globalController.dart';
import 'package:ctbeca/env.dart';
import 'package:ctbeca/models/player.dart';
import 'package:ctbeca/models/user.dart';
import 'package:ctbeca/views/admin/adminMainPage.dart';
import 'package:ctbeca/views/player/playerMainPage.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';


class LoginController extends GetxController {  
  final messageError = ''.obs;
  final passwordVisible = true.obs, statusError = false.obs, statusPassword = false.obs;

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

  validarEmailWallet(String value){
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
      return statusPassword.value = true;    
    }

    statusPassword.value = false; 

  }

  formSubmit(emailWallet, password)async{
    var result, response, jsonResponse;
    GlobalController().loading();

    if(this.statusPassword.value){

      try {
        result = await InternetAddress.lookup('google.com'); //verify network
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

          var parameters = jsonToUrl(jsonEncode({
              'email': emailWallet,
              'password': password,
            }));

          response = await http.get(
            Uri.parse(urlApi+"loginAdmin/$parameters"),
            headers:{
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              'X-Requested-With': 'XMLHttpRequest',
            },
          ); // petición api
          print(response.body);
          jsonResponse = jsonDecode(response.body);

          if (jsonResponse['statusCode'] == 201) {
            print("entro");
            statusError.value = false;
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('access_token', jsonResponse['access_token']);
            GlobalController().user = new User.fromJson(jsonResponse);
            GlobalController().getPlayers(jsonResponse['players']);
            Get.off(AdminMainPage());

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
  
    }else{

      try {
        result = await InternetAddress.lookup('google.com'); //verify network
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

          response = await http.post(
            Uri.parse(urlApi+"loginPlayer"),
            headers:{
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              'X-Requested-With': 'XMLHttpRequest',
            },
            body: jsonEncode({
              'wallet': emailWallet,
            }),
          ); // petición api
          print(response.body);
          jsonResponse = jsonDecode(response.body);

          if (jsonResponse['statusCode'] == 201) {

            statusError.value = false;
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('access_token', jsonResponse['access_token']);
            GlobalController().user = new User.fromJson(jsonResponse);
            GlobalController().player = new Player.fromJson(jsonResponse['players']);
            Get.back();
            Get.off(PlayerMainPage());
            
          } else if(jsonResponse['statusCode'] == 400){

            statusError.value = true;
            messageError.value = jsonResponse['message'];

          } else if(jsonResponse['message'] == 'Unauthorized'){

            statusError.value = true;
            messageError.value = "Billetera incorrectos";

          }  
        }
      } on SocketException catch (_) {

        statusError.value = true;
        messageError.value = "Sin conexión, inténtalo de nuevo mas tarde";

      } 
  
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