import 'package:ctbeca/controller/loginController.dart';
import 'package:ctbeca/env.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
  final _formKeyLogin = new GlobalKey<FormState>();
  final FocusNode _emailFocus = FocusNode();  
  final FocusNode _passwordFocus = FocusNode();
  final _emailwalletController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginController controllerLogin = Get.put(LoginController());
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async =>false,
      child: Center(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage("assets/logo/logo.png"),
                      width: size.width/2,
                    ),
                    formLogin(context), 
                    SizedBox(height: 25,),
                    buttonLogin(context), 
                  ]
                ),
              ),
            )
          ),
        ),
      )
    );
  }

  Widget formLogin(context){
    return new Form(
      key: _formKeyLogin,
      child: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          Obx(
            () => Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
              child: new TextFormField(
                controller: _emailwalletController,
                maxLines: 1,
                keyboardType: TextInputType.text,
                autofocus: false,
                focusNode: _emailFocus,
                onEditingComplete: () {
                  if(controllerLogin.statusPassword.value)
                    FocusScope.of(context).requestFocus(_passwordFocus);
                  else 
                    tapSubmit();
                } ,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
                ],
                decoration: new InputDecoration(
                  labelText: !controllerLogin.statusPassword.value? "Billetera" : "Correo Electrónico",
                  labelStyle: TextStyle(
                    color: colorPrimary,
                    fontFamily: 'MontserratSemiBold',
                    fontSize: 14,
                  ),
                  icon: new Icon(
                    controllerLogin.statusPassword.value? Icons.mail : Icons.account_balance_wallet ,
                    color: colorPrimary,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorPrimary),
                  ),
                ),
                validator: (value) => value!.trim().length >5? null : controllerLogin.statusPassword.value? 'Ingrese un correo electrónico válido' : 'Ingrese una billetera válido',
                onChanged: controllerLogin.validarEmailWallet,
                textInputAction: !controllerLogin.statusPassword.value? TextInputAction.done : TextInputAction.next ,
                cursorColor: colorPrimary,
                style: TextStyle(
                  fontFamily: 'MontserratSemiBold',
                  fontSize: 14,
                ),
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: controllerLogin.statusPassword.value,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
                child: new TextFormField(
                  controller: _passwordController,
                  maxLines: 1,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  obscureText: controllerLogin.passwordVisible.value,
                  focusNode: _passwordFocus,
                  decoration: new InputDecoration(
                    labelText: "Contraseña",
                    labelStyle: TextStyle(
                      color: colorPrimary,
                      fontFamily: 'MontserratSemiBold',
                      fontSize: 14,
                    ),
                    icon: new Icon(
                      Icons.lock,
                      color: colorPrimary
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controllerLogin.passwordVisible.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                        color: colorPrimary,
                        ),
                      onPressed: () =>controllerLogin.passwordVisible.value = !controllerLogin.passwordVisible.value,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: colorPrimary),
                    ),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
                  ],
                  validator: (value) => value!.isEmpty || value.trim().length < 5? 'Ingrese una contraseña válida': null,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (term){
                    FocusScope.of(context).requestFocus(new FocusNode()); //save the keyboard
                    tapSubmit();
                  },
                  cursorColor: colorPrimary,
                  style: TextStyle(
                    fontFamily: 'MontserratSemiBold',
                    fontSize: 14,
                  ),
                ),
              )
            ),
          ),
          Obx(
            () => Visibility(
              visible: controllerLogin.statusError.value,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                  child: AutoSizeText(
                    controllerLogin.messageError.value,
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'MontserratSemiBold',
                    ),
                    maxFontSize: 14,
                    minFontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonLogin(context){
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode()); //save the keyboard
        tapSubmit();
      },
      child: Container(
        width:size.width - 100,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: colorPrimary, 
            width: 1.0,
          ),
          color: colorPrimary,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(5, 5),
              blurRadius: 10,
            )
          ],
        ),
        child: Center(
          child: AutoSizeText(
            'Ingresar',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontFamily: 'MontserratSemiBold',
            ),
            maxFontSize: 14,
            minFontSize: 14,
          ),
        ),
      ),
    );
  }

  void tapSubmit(){
    if(_formKeyLogin.currentState!.validate()){
      controllerLogin.formSubmit(_emailwalletController.text.toLowerCase().trim(),_passwordController.text.trim());
      _passwordController.clear();
    } 
  }
}