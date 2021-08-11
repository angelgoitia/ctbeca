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

  submitForm(index) async {
    GlobalController globalController = Get.put(GlobalController());
    AdminController adminController = Get.put(AdminController());
    
    var result, response, jsonResponse;

    globalController.loading();

    try {
      var phone = player.value.phone!.split("-");

      result = await InternetAddress.lookup('google.com'); //verify network
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        response = await http.post(
          Uri.parse(urlApi+"formPlayer/"),
          headers:{
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'X-Requested-With': 'XMLHttpRequest',
            'authorization': 'Bearer ${adminController.admin.value.accessToken}',
          },
          body: jsonEncode({
            'statusApi': true,
            'playerSelect': index < 0 ? null : player.toJson(),
            'name': player.value.name,
            'digPhone': phone[0],
            'phone': phone[1],
            'telegram': player.value.telegram,
            'email': player.value.email,
            'reference': player.value.reference,
            'wallet': player.value.wallet,
            'user': player.value.user,
            'emailGame': player.value.emailGame,
            'passwordGame': player.value.passwordGame,
            'urlPrevius': index >= 0 && imageSelect.value? adminController.players[index].urlCodeQr : null,
            'image': player.value.urlCodeQr,
          }),
        ); // petición api
        print(response.body);
        jsonResponse = jsonDecode(response.body);

        if (jsonResponse['statusCode'] == 201) {

          await adminController.getAdmin(false);
          Get.back();
          Get.back();
          globalController.showMessage("Ha sido Guardado correctamente!", true);
          await Future.delayed(Duration(seconds: 1));
          Get.back();

        } else if(jsonResponse['statusCode'] == 400){

          Get.back();
          globalController.showMessage(jsonResponse['message'], false);
          await Future.delayed(Duration(seconds: 1));
          Get.back();

        } 
      }
    } on SocketException catch (_) {

      Get.back();
      globalController.showMessage("Sin conexión a internet", false); 
      await Future.delayed(Duration(seconds: 1));
      Get.back();

    } 

      
  }

  
}