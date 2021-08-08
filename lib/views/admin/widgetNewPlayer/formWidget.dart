import 'package:ctbeca/controller/formController.dart';
import 'package:ctbeca/env.dart';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';

class FormWidget extends StatefulWidget {
  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKeyNewPlayer = new GlobalKey<FormState>();
  final FocusNode _nameFocus = FocusNode();  
  final FocusNode _phoneFocus = FocusNode();  
  final FocusNode _telegramFocus = FocusNode();  
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _referenceFocus = FocusNode();
  final FocusNode _walletFocus = FocusNode();  
  final FocusNode _emailGameFocus = FocusNode(); 
  final FocusNode _passwordGameFocus = FocusNode();  
  final _passwordController = TextEditingController();

  FormController formController = Get.put(FormController());

  @override
  Widget build(BuildContext context) {
    return new Form(
      key: _formKeyNewPlayer,
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
            child: new TextFormField(
              maxLines: 1,
              keyboardType: TextInputType.text,
              autofocus: false,
              focusNode: _nameFocus,
              onEditingComplete: () => FocusScope.of(context).requestFocus(_phoneFocus),
              decoration: new InputDecoration(
                labelText: "Nombre de jugador",
                labelStyle: TextStyle(
                  color: colorPrimary,
                  fontFamily: 'MontserratSemiBold',
                  fontSize: 14,
                ),
                icon: new Icon(
                  Icons.person ,
                  color: colorPrimary,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorPrimary),
                ),
              ),
              validator: (value) => value!.trim().length >5? null : 'Ingrese un nombre valido',
              textInputAction: TextInputAction.next ,
              cursorColor: colorPrimary,
              style: TextStyle(
                fontFamily: 'MontserratSemiBold',
                fontSize: 14,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
            child: Row(
              children: [
                Icon(
                  Icons.phone ,
                  color: colorPrimary,
                ),

                SizedBox(width: 15,),

                DropdownButton<String>(
                  value: "Seleccionar",
                  icon: Icon(Icons.arrow_drop_down, color: colorPrimary),
                  elevation: 16,
                  underline: Container(
                    height: 2,
                    color: colorPrimary,
                  ),
                  style: TextStyle(
                    fontFamily: 'MontserratSemiBold',
                    fontSize:14
                  ),
                  onChanged: (String? newValue) {
                    if(newValue == "Seleccionar")
                      Fluttertoast.showToast(
                        msg: "Debe seleccionar los primeros 4 digitos de tu telefóno!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: colorPrimary,
                        textColor: Colors.white,
                        fontSize: 16.0
                      );
                    //TODO:save dig
                  },
                  items: <String>["Seleccionar","0412","0414","0424","0416","0424"].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: AutoSizeText(
                          value,
                          style: TextStyle(
                            color: colorText,
                            fontFamily: 'MontserratSemiBold',
                            fontSize:14
                          ),
                          maxFontSize: 18,
                          minFontSize: 18,
                        ),
                      );
                  }).toList(),
                ),

                SizedBox(width: 15,),

                Expanded(
                  child: new TextFormField(
                    maxLines: 1,
                    keyboardType: TextInputType.phone,
                    autofocus: false,
                    focusNode: _phoneFocus,
                    onEditingComplete: () => FocusScope.of(context).requestFocus(_telegramFocus),
                    decoration: new InputDecoration(
                      labelText: "Telefóno",
                      labelStyle: TextStyle(
                        color: colorPrimary,
                        fontFamily: 'MontserratSemiBold',
                        fontSize: 14,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: colorPrimary),
                      ),
                    ),
                    validator: (value) => value!.length ==7?  null : 'Ingrese un número correcto valido',//TODO: agregar validacion digito
                    textInputAction: TextInputAction.next ,
                    cursorColor: colorPrimary,
                    style: TextStyle(
                      fontFamily: 'MontserratSemiBold',
                      fontSize: 14,
                    ),
                  )
                ),
              ],
            )
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
            child: new TextFormField(
              maxLines: 1,
              keyboardType: TextInputType.text,
              autofocus: false,
              inputFormatters: [
                FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
              ],
              focusNode: _telegramFocus,
              onEditingComplete: () => FocusScope.of(context).requestFocus(_emailFocus),
              decoration: new InputDecoration(
                labelText: "Telegram",
                labelStyle: TextStyle(
                  color: colorPrimary,
                  fontFamily: 'MontserratSemiBold',
                  fontSize: 14,
                ),
                icon: Image.asset("assets/icons/telegramBlack.png", width: 20, color: colorPrimary,),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorPrimary),
                ),
              ),
              validator: (value) => value!.trim().length >3? null : 'Ingrese un usuario de telegram valido',
              textInputAction: TextInputAction.next ,
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
              maxLines: 1,
              keyboardType: TextInputType.text,
              autofocus: false,
              inputFormatters: [
                FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
              ],
              focusNode: _emailFocus,
              onEditingComplete: () => FocusScope.of(context).requestFocus(_referenceFocus),
              decoration: new InputDecoration(
                labelText: "Correo Electrónico",
                labelStyle: TextStyle(
                  color: colorPrimary,
                  fontFamily: 'MontserratSemiBold',
                  fontSize: 14,
                ),
                icon: Icon(
                  Icons.email,
                  color: colorPrimary,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorPrimary),
                ),
              ),
              validator: (value) => value!.trim().length >3? null : 'Ingrese un Correo Electrónico valido',
              textInputAction: TextInputAction.next ,
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
              maxLines: 1,
              keyboardType: TextInputType.text,
              autofocus: false,
              inputFormatters: [
                FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
              ],
              focusNode: _referenceFocus,
              onEditingComplete: () => FocusScope.of(context).requestFocus(_walletFocus),
              decoration: new InputDecoration(
                labelText: "Referencia",
                labelStyle: TextStyle(
                  color: colorPrimary,
                  fontFamily: 'MontserratSemiBold',
                  fontSize: 14,
                ),
                icon: Icon(
                  Icons.supervisor_account,
                  color: colorPrimary,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorPrimary),
                ),
              ),
              textInputAction: TextInputAction.next ,
              cursorColor: colorPrimary,
              style: TextStyle(
                fontFamily: 'MontserratSemiBold',
                fontSize: 14,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
            child: Center(
              child: AutoSizeText(
                "Acceso Axies Infinity",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'MontserratBold',
                ),
                maxFontSize: 18,
                minFontSize: 18,
              ),
            )
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
            child: new TextFormField(
              maxLines: 1,
              keyboardType: TextInputType.text,
              autofocus: false,
              inputFormatters: [
                FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
              ],
              focusNode: _walletFocus,
              onEditingComplete: () => FocusScope.of(context).requestFocus(_passwordGameFocus), //TODO: revisar
              decoration: new InputDecoration(
                labelText: "Billetera",
                labelStyle: TextStyle(
                  color: colorPrimary,
                  fontFamily: 'MontserratSemiBold',
                  fontSize: 14,
                ),
                icon: Icon(
                  Icons.account_balance_wallet,
                  color: colorPrimary,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorPrimary),
                ),
              ),
              validator: (value) => value!.trim().length >3? null : 'Ingrese una Billetera valido',
              textInputAction: TextInputAction.next ,
              cursorColor: colorPrimary,
              style: TextStyle(
                fontFamily: 'MontserratSemiBold',
                fontSize: 14,
              ),
            ),
          ),

          //TODO: Cuadro avatar, input file -> (click) abre menu bottom

          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
            child: new TextFormField(
              maxLines: 1,
              keyboardType: TextInputType.text,
              autofocus: false,
              inputFormatters: [
                FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
              ],
              focusNode: _emailGameFocus,
              onEditingComplete: () => FocusScope.of(context).requestFocus(_passwordGameFocus),
              decoration: new InputDecoration(
                labelText: "Correo Electrónico",
                labelStyle: TextStyle(
                  color: colorPrimary,
                  fontFamily: 'MontserratSemiBold',
                  fontSize: 14,
                ),
                icon: Icon(
                  Icons.email,
                  color: colorPrimary,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorPrimary),
                ),
              ),
              validator: (value) => value!.trim().length >3? null : 'Ingrese un Correo Electrónico valido',
              textInputAction: TextInputAction.next ,
              cursorColor: colorPrimary,
              style: TextStyle(
                fontFamily: 'MontserratSemiBold',
                fontSize: 14,
              ),
            ),
          ),

          Obx(
            () => Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
              child: new TextFormField(
                controller: _passwordController,
                maxLines: 1,
                autofocus: false,
                keyboardType: TextInputType.text,
                obscureText: formController.passwordVisible.value,
                focusNode: _passwordGameFocus,
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
                      formController.passwordVisible.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                      color: colorPrimary,
                      ),
                    onPressed: () =>formController.passwordVisible.value = !formController.passwordVisible.value,
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
                  //TODO: submit
                },
                cursorColor: colorPrimary,
                style: TextStyle(
                  fontFamily: 'MontserratSemiBold',
                  fontSize: 14,
                ),
              ),
            ),
          ),

          
        ],
      ),
    );
  }
}