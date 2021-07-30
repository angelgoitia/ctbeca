import 'package:ctbeca/controller/loginController.dart';
import 'package:ctbeca/env.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
  final _formKeyLogin = new GlobalKey<FormState>();
  final FocusNode _emailFocus = FocusNode();  
  final FocusNode _passwordFocus = FocusNode();
  final _passwordController = TextEditingController();
  
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
                child: GetBuilder<LoginController>(
                  init:LoginController(),
                  builder: (_) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage("assets/axies.png"),
                        width: size.width/2,
                      ),
                      formLogin(context, _), 
                      SizedBox(height: 25,),
                      buttonLogin(context, _), 
                    ]
                  ),
                ),
              ),
            )
          ),
        ),
      )
    );
  }

  Widget formLogin(context, _){
    return new Form(
      key: _formKeyLogin,
      child: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
            child: new TextFormField(
              maxLines: 1,
              keyboardType: TextInputType.text,
              autofocus: false,
              focusNode: _emailFocus,
              onEditingComplete: () {
                if(_.statusPassword)
                  FocusScope.of(context).requestFocus(_passwordFocus);
                else 
                  tapSubmit();
              } ,
              decoration: new InputDecoration(
                labelText: !_.statusPassword? "Billetera" : "Correo Electrónico",
                labelStyle: TextStyle(
                  color: colorPrimary,
                  fontFamily: 'MontserratSemiBold',
                  fontSize: 14,
                ),
                icon: new Icon(
                  _.statusPassword? Icons.mail : Icons.account_balance_wallet ,
                  color: colorPrimary,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorPrimary),
                ),
              ),
              validator: (value) => value!.trim().length >5? null : 'Ingrese una billetera válido',
              onSaved: (value) => _.emailWallet = value!.toLowerCase().trim(),
              onChanged: _.validarEmailWallet,
              textInputAction: !_.statusPassword? TextInputAction.done : TextInputAction.next ,
              cursorColor: colorPrimary,
              style: TextStyle(
                fontFamily: 'MontserratSemiBold',
                fontSize: 14,
              ),
            ),
          ),
          Visibility(
            visible: _.statusPassword,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
              child: new TextFormField(
                controller: _passwordController,
                maxLines: 1,
                autofocus: false,
                keyboardType: TextInputType.text,
                obscureText: _.passwordVisible,
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
                        _.passwordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                        color: colorPrimary,
                        ),
                      onPressed: () =>_.passwordVisible = !_.passwordVisible,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: colorPrimary),
                    ),
                  ),
                validator: (value) => value!.isEmpty? 'Ingrese una contraseña válida': null,
                onSaved: (value) => _.password = value!.trim(),
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
          Visibility(
            visible: _.statusError,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                child: AutoSizeText(
                  !_.statusError? '' : _.messageError!,
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
        ],
      ),
    );
  }

  Widget buttonLogin(context, _){
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
    final _controller = Get.put(LoginController());
    if(_formKeyLogin.currentState!.validate()){
      _formKeyLogin.currentState!.save();
      _controller.formSubmit();
      _passwordController.clear();
    } 
  }
}