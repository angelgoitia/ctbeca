import 'package:ctbeca/controller/adminController.dart';
import 'package:ctbeca/controller/globalController.dart';
import 'package:ctbeca/env.dart';
import 'package:ctbeca/models/player.dart';

import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FormController extends GetxController {  
  final player = Player().obs;
  final messageError = ''.obs, digitsPhone = ''.obs;
  final passwordVisible = true.obs, statusError = false.obs, statusErrorPhone = false.obs,
        imageSelect = false.obs , statusSubmit = false.obs;
  var fileSelect;

  validateTelegram(String value){
    value = value.trim();
    // This is just a regular expression for email addresses
    String p = "[@][A-Za-z0-9_]{5,20}";
    RegExp regExp = new RegExp(p);

    if (value.isNotEmpty && regExp.hasMatch(value)) {
      return true;    
    }

    return false;
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
      return true;    
    }

    return false; 
  }

  submitForm(index, status) async {
    GlobalController globalController = Get.put(GlobalController());
    AdminController adminController = Get.put(AdminController());
    
    var result, response, jsonResponse;

    globalController.loading();

    try {
      result = await InternetAddress.lookup('google.com'); //verify network
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

        response = await http.post(
          Uri.parse(urlApi+"formPlayer/"),
          headers:{
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'X-Requested-With': 'XMLHttpRequest',
          },
          body: jsonEncode({
            'statusApi': true,
            'playerSelect': player,
            'name': player.value.name,
            'phone': player.value.phone,
            'telegram': player.value.telegram,
            'email': player.value.email,
            'reference': player.value.reference,
            'wallet': player.value.wallet,
            'emailGame': player.value.emailGame,
            'passwordGame': player.value.passwordGame,
            'urlPrevius': status? adminController.players[index].urlCodeQr : null,
            'image': player.value.urlCodeQr,
          }),
        ); // petición api
        print(response.body);
        jsonResponse = jsonDecode(response.body);

        if (jsonResponse['statusCode'] == 201) {

          Get.back();
          Get.back();
          globalController.showMessage("Ha sido Guardado correctamente!", true);

        } else if(jsonResponse['statusCode'] == 400){

          statusError.value = true;
          messageError.value = jsonResponse['message'];

        } 
      }
    } on SocketException catch (_) {
      globalController.showMessage("Sin conexión a internet", false); 
    } 

      
  }

  
}