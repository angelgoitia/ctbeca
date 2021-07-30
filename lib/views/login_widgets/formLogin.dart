import 'package:auto_size_text/auto_size_text.dart';
import 'package:ctbeca/controller/loginController.dart';
import 'package:ctbeca/env.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormLogin extends StatelessWidget {

  final _formKeyLogin = new GlobalKey<FormState>();
  final FocusNode _emailFocus = FocusNode();  
  final FocusNode _passwordFocus = FocusNode();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (_)  => new Form(
        key: _formKeyLogin,
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
              child: new TextFormField(
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                focusNode: _emailFocus,
                onEditingComplete: () => FocusScope.of(context).requestFocus(_passwordFocus),
                decoration: new InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: colorPrimary,
                    fontFamily: 'MontserratSemiBold',
                    fontSize: 14,
                  ),
                  icon: new Icon(
                    Icons.mail,
                    color: colorPrimary,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorPrimary),
                  ),
                ),
                validator: (value) => _.validateEmail(value!)? null : 'Ingrese un email válido',
                onSaved: (value) => _.emailWallet = value!.toLowerCase().trim(),
                textInputAction: TextInputAction.next,
                cursorColor: colorPrimary,
                style: TextStyle(
                  fontFamily: 'MontserratSemiBold',
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
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
                  //TODO: click botton
                },
                cursorColor: colorPrimary,
                style: TextStyle(
                  fontFamily: 'MontserratSemiBold',
                  fontSize: 14,
                ),
              ),
            ),
            Visibility(
              visible: _.statusError,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                  child: AutoSizeText(
                    _.statusError? '' : _.messageError,
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
      ),
    );
  }
}