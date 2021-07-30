import 'package:get/get.dart';

class LoginController extends GetxController {  
  String get emailWallet => emailWallet;
  set emailWallet(String newEmailWallet) {
    emailWallet = newEmailWallet; 
  }

  String get password => password;
  set password(String newPassword) {
    password = newPassword; 
  }

  String get messageError => messageError;
  set messageError(String newError) {
    messageError = newError; 
  }

  bool get passwordVisible => passwordVisible;
  set passwordVisible(bool newStatus) {
    passwordVisible = newStatus; 
  }

  bool get statusError => statusError;
  set statusError(bool newStatus) {
    statusError = newStatus; 
  }

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

  bool validateEmail(String value){
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
      return true;     
    }

    // The pattern of the email didn't match the regex above.
    return false;
  }
}