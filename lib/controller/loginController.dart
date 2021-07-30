import 'package:ctbeca/controller/globalController.dart';
import 'package:ctbeca/env.dart';
import 'package:ctbeca/models/player.dart';
import 'package:ctbeca/models/user.dart';

import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class LoginController extends GetxController {  
  String? password, emailWallet, messageError;
  bool passwordVisible = true, statusError = false, statusPassword = false;

  @override
  void onInit() {
    super.onInit();
    this.passwordVisible = true;
    this.statusError = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  void validarEmailWallet(String value){
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

    if (value.isNotEmpty &&regExp.hasMatch(value)) {
      this.statusPassword = true;    
    }else{
      this.statusPassword = false;
    }

    update();

  }

  void formSubmit()async{
    var result, response, jsonResponse;
    GlobalController().loading();
    if(this.statusPassword){
      print("http user");
      try {
        result = await InternetAddress.lookup('google.com'); //verify network
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

          response = await http.post(
            Uri.parse(urlApi+"loginUser"),
            headers:{
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              'X-Requested-With': 'XMLHttpRequest',
            },
            body: jsonEncode({
              'email': emailWallet,
              'password': password,
            }),
          ); // petición api
          print(response.body);
          jsonResponse = jsonDecode(response.body);

          if (jsonResponse['statusCode'] == 201) {

            SharedPreferences prefs = await SharedPreferences.getInstance();
            var controllerGlobal = GlobalController();
            prefs.setString('access_token', jsonResponse['access_token']);
            controllerGlobal.user = new User.fromJson(jsonResponse);
            //TODO: ruta
          } else if(jsonResponse['statusCode'] == 400){

            statusError = true;
            messageError = jsonResponse['message'];

          } else if(jsonResponse['message'] == 'Unauthorized'){

            statusError = true;
            messageError = "Email o contraseña incorrectos";

          }  
        }
      } on SocketException catch (_) {
        statusError = true;
        messageError = "Sin conexión, inténtalo de nuevo mas tarde";

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

            SharedPreferences prefs = await SharedPreferences.getInstance();
            var controllerGlobal = GlobalController();
            prefs.setString('access_token', jsonResponse['access_token']);
            controllerGlobal.player = new Player.fromJson(jsonResponse);
            //TODO: ruta
          } else if(jsonResponse['statusCode'] == 400){

            statusError = true;
            messageError = jsonResponse['message'];

          } else if(jsonResponse['message'] == 'Unauthorized'){

            statusError = true;
            messageError = "Billetera incorrectos";

          }  
        }
      } on SocketException catch (_) {
        statusError = true;
        messageError = "Sin conexión, inténtalo de nuevo mas tarde";

      } 
  
    }

    Get.back(result: true);
  }
}