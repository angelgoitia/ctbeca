import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ctbeca/controller/adminController.dart';
import 'package:ctbeca/controller/formController.dart';
import 'package:ctbeca/env.dart';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class FormWidget extends StatefulWidget {
  final int index;
  FormWidget(this.index);

  @override
  _FormWidgetState createState() => _FormWidgetState(index);
}

class _FormWidgetState extends State<FormWidget> {
  final int index;
  _FormWidgetState(this.index);

  final _formKeyNewPlayer = new GlobalKey<FormState>();
  final FocusNode _nameFocus = FocusNode();  
  final FocusNode _phoneFocus = FocusNode();  
  final FocusNode _telegramFocus = FocusNode();  
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _referenceFocus = FocusNode();
  final FocusNode _codeQrFocus = FocusNode();  
  final FocusNode _walletFocus = FocusNode();  
  final FocusNode _userFocus = FocusNode();  
  final FocusNode _emailGameFocus = FocusNode(); 
  final FocusNode _passwordGameFocus = FocusNode();  
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool statusPlayer = false;

  FormController formController = Get.put(FormController());
  AdminController adminController = Get.put(AdminController());

  @override
  void initState() {
    super.initState();
    _phoneController.text = index >= 0? adminController.players[index].phone!.substring(5) : '';
    formController.player.value.wallet  = index >= 0? adminController.players[index].wallet! : '';
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return new Form(
      key: _formKeyNewPlayer,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
              child: new TextFormField(
                initialValue: index >= 0? adminController.players[index].name : '',
                maxLines: 1,
                keyboardType: TextInputType.text,
                autofocus: true,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z\ áéíóúÁÉÍÓÚñÑ\s]")),
                ], 
                focusNode: _nameFocus,
                onEditingComplete: () => FocusScope.of(context).requestFocus(_phoneFocus),
                textCapitalization: TextCapitalization.words,
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
                validator: (value) => value!.trim().length >5? null : 'Ingrese un nombre válido',
                onSaved: (value) => formController.player.value.name = value!.trim(),
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

                  Obx(
                    () => DropdownButton<String>(
                      value: index >= 0? adminController.players[index].phone!.substring(0,4) : formController.digitsPhone.value.length == 4 ? formController.digitsPhone.value : "Seleccionar",
                      icon: Icon(Icons.arrow_drop_down, color: colorPrimary),
                      elevation: 16,
                      underline: Container(
                        height: 2,
                        color: formController.statusErrorPhone.value? Colors.red : colorPrimary,
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
                        else{
                          print("entro");
                          FocusScope.of(context).requestFocus(_phoneFocus);
                          formController.digitsPhone.value = newValue!;
                        }
                      },
                      items: <String>["Seleccionar","0412","0414","0424","0416","0426"].map<DropdownMenuItem<String>>((String value) {
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
                  ),

                  SizedBox(width: 15,),

                  Expanded(
                    child: new TextFormField(
                      controller: _phoneController,
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
                      textInputAction: TextInputAction.next ,
                      cursorColor: colorPrimary,
                      style: TextStyle(
                        fontFamily: 'MontserratSemiBold',
                        fontSize: 14,
                      ),
                      validator: (value) => value!.length == 7?  null : '',
                      onSaved: (value) => formController.player.value.phone = formController.digitsPhone.value.length == 0 ? "${adminController.players[index].phone!.substring(0,4)}-${value!.trim()}" : "${formController.digitsPhone.value}-${value!.trim()}",
                    )
                  ),
                ],
              )
            ),

            Obx(
              () => Visibility(
                visible: formController.statusErrorPhone.value,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 0.0),
                  child: Center(
                    child: AutoSizeText(
                      'Ingrese un número correcto válido',
                      style: TextStyle(
                        color: Colors.red,
                        fontFamily: 'MontserratSemiBold',
                      ),
                      maxFontSize: 14,
                      minFontSize: 14,
                    )
                  ),
                )
              )
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
              child: new TextFormField(
                initialValue: index >= 0? adminController.players[index].telegram : '',
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
                  hintText: "@JoeDoe",
                  icon: Image.asset("assets/icons/telegramBlack.png", width: 20, color: colorPrimary,),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorPrimary),
                  ),
                ),
                validator: (value) => formController.validateTelegram(value!)? null : 'Ingrese un usuario de telegram válido',
                onSaved: (value) => formController.player.value.telegram = value!.trim(),
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
                initialValue: index >= 0? adminController.players[index].email : '',
                keyboardType: TextInputType.emailAddress,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
                ],
                autofocus: false,
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
                validator: (value) => formController.validarEmail(value!)? null : 'Ingrese un Correo Electrónico válido',
                onSaved: (value) => formController.player.value.email = value!.trim(),
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
                initialValue: index >= 0? adminController.players[index].reference : '',
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                autofocus: false,
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
                onSaved: (value) => formController.player.value.reference = value!.trim(),
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
              child: 

              index>=0? 

                AutoSizeText.rich(
                  TextSpan(
                    text: 'Billetera: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'MontserratBold',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "ronin:${adminController.players[index].wallet}",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'MontserratMedium',
                        ),
                      ),
                    ],
                  ),
                  maxFontSize: 14,
                  minFontSize: 14,
                )

              :

                new TextFormField(
                  maxLines: 1,
                  initialValue: index >= 0? adminController.players[index].wallet : '',
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
                  ],
                  focusNode: _walletFocus,
                  onEditingComplete: () => FocusScope.of(context).requestFocus(_codeQrFocus), 
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
                  validator: (value) => value!.trim().length >=20? null : 'Ingrese una Billetera válido',
                  onSaved: (value) => formController.player.value.wallet = value!.trim(),
                  textInputAction: TextInputAction.next ,
                  cursorColor: colorPrimary,
                  style: TextStyle(
                    fontFamily: 'MontserratSemiBold',
                    fontSize: 14,
                  ),
                  readOnly: index >= 0,
                ),
            ),
            
            Obx(
              () => Visibility(
                visible: index >= 0 || formController.imageSelect.value,
                child: index <0 && !formController.imageSelect.value ? Container() : Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
                  child: Center(
                    child: Container(
                      width: size.width / 2,
                      height: size.width / 2,
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.circular(10.0),
                        boxShadow: [
                          new BoxShadow(
                            color: Color(0xffA4A4A4),
                            offset: Offset(1.0, 5.0),
                            blurRadius: 3.0,
                          ),
                        ]
                      ),
                      child: ClipRRect(
                        borderRadius: new BorderRadius.circular(10.0),
                        child: index >= 0 && !formController.imageSelect.value ? 
                          CachedNetworkImage(
                            imageUrl: "http://"+url+"/storage/${adminController.players[index].urlCodeQr}",
                            placeholder: (context, url) => CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(colorPrimary)),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                            fit: BoxFit.fill,              
                          )
                        : ClipRRect(
                          child: Image.file(
                            formController.fileSelect,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover
                          ),
                        ),
                      ),
                    ),
                  ), 
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
              child:new TextFormField(
                initialValue: 'SELECCIONAR',
                autofocus: false,
                textCapitalization:TextCapitalization.sentences, 
                decoration: InputDecoration(
                  labelText: 'Código QR',
                  labelStyle: TextStyle(
                    color: colorText,
                    fontFamily: 'MontserratSemiBold',
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorPrimary),
                  ),
                  icon: new Icon(
                    Icons.qr_code_2_sharp,
                    color: colorPrimary
                  ),
                ),
                textInputAction: TextInputAction.next,
                focusNode: _codeQrFocus,
                onEditingComplete: () => FocusScope.of(context).requestFocus(_userFocus),
                cursorColor: colorPrimary,
                style: TextStyle(
                  fontFamily: 'MontserratSemiBold',
                ),
                readOnly: true,
                onTap: (){
                  _showSelectionDialog(context);
                },
              ),
            ),

            Obx(
              () => Visibility(
                visible: formController.statusSubmit.value,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 0.0),
                  child: Center(
                    child: AutoSizeText(
                      'Ingrese un selecionar un Código QR',
                      style: TextStyle(
                        color: Colors.red,
                        fontFamily: 'MontserratSemiBold',
                      ),
                      maxFontSize: 14,
                      minFontSize: 14,
                    )
                  ),
                )
              )
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
              child: new TextFormField(
                maxLines: 1,
                initialValue: index >= 0? adminController.players[index].user : '',
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
                ],
                focusNode: _userFocus,
                onEditingComplete: () => FocusScope.of(context).requestFocus(_emailGameFocus),
                decoration: new InputDecoration(
                  labelText: "Usuario",
                  labelStyle: TextStyle(
                    color: colorPrimary,
                    fontFamily: 'MontserratSemiBold',
                    fontSize: 14,
                  ),
                  icon: Icon(
                    Icons.person,
                    color: colorPrimary,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorPrimary),
                  ),
                ),
                validator: (value) => value!.trim().length >= 5? null : 'Ingrese un Usuario válido',
                onSaved: (value) => formController.player.value.user = value!.trim(),
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
                initialValue: index >= 0? adminController.players[index].emailGame : '',
                keyboardType: TextInputType.emailAddress,
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
                validator: (value) => formController.validarEmail(value!)? null : 'Ingrese un Correo Electrónico válido',
                onSaved: (value) => formController.player.value.emailGame = value!.trim(),
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
                  validator: (value) => value!.trim().length < 5? 'Ingrese una contraseña válida': null,
                  onSaved: (value) => formController.player.value.passwordGame = value!.trim(),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (term){
                    FocusScope.of(context).requestFocus(new FocusNode()); 
                    tapSubmit(index);
                  },
                  cursorColor: colorPrimary,
                  style: TextStyle(
                    fontFamily: 'MontserratSemiBold',
                    fontSize: 14,
                  ),
                ),
              ),
            ),  
              SizedBox(height: 25,),
            buttonSubmit(context), 
          ],
        ),
      ),
    );
  }

  Widget buttonSubmit(context){
    
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode()); 
        tapSubmit(index);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 30.0),
        child: Container(
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
              'Guardar',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontFamily: 'MontserratSemiBold',
              ),
              maxFontSize: 14,
              minFontSize: 14,
            ),
          ),
        )
      ),
    );
  }

  Future<void> _showSelectionDialog(BuildContext context) {
    
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20)
        ),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext bc){
          return Container(
            child: new Wrap(
              spacing: 20,
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.crop_original, color:Colors.black, size: 30.0),
                  title: new AutoSizeText(
                    "Galeria",
                    style: TextStyle(
                      fontFamily: 'MontserratSemiBold',
                      fontSize:14
                    ),
                    maxFontSize: 14,
                    minFontSize: 14,
                  ),
                  onTap: () => _getImage(context, ImageSource.gallery),       
                ),
                new ListTile(
                  leading: new Icon(Icons.camera, color:Colors.black, size: 30.0),
                  title: new AutoSizeText(
                    "Camara",
                    style: TextStyle(
                      fontFamily: 'MontserratSemiBold',
                      fontSize:14
                    ),
                    maxFontSize: 14,
                    minFontSize: 14,
                  ),
                  onTap: () => _getImage(context, ImageSource.camera),          
                ),
              ],
            ),
          );
      }
    );
  }

  _getImage(BuildContext context, ImageSource source) async {

    var picture = await ImagePicker().pickImage(source: source,  imageQuality: 50, maxHeight: 600, maxWidth: 900);

    var cropped;

    if(picture != null){
      cropped = await ImageCropper.cropImage(
        sourcePath: picture.path,
        aspectRatio:  CropAspectRatio(
          ratioX: 1, ratioY: 1
        ),
        compressQuality: 100,
        maxWidth: 700,
        maxHeight: 700,
        cropStyle: CropStyle.rectangle,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: "Editar Foto",
          backgroundColor: Colors.black,
          toolbarWidgetColor: Colors.black,
          toolbarColor: Colors.white,
        ),
        iosUiSettings: IOSUiSettings(
          title: 'Editar Foto',
        )
      );

      if(cropped != null){
        
        Navigator.of(context).pop();
        formController.fileSelect = cropped;
        formController.imageSelect.value = true;

        formController.player.value.urlCodeQr = base64Encode(cropped.readAsBytesSync());

      }
    }
  }

  void tapSubmit(index){

    if(index < 0 && !formController.imageSelect.value)
      formController.statusSubmit.value = true;
    else 
      formController.statusSubmit.value = false;

    if("${formController.digitsPhone.value}-${_phoneController.text.trim()}".length != 12)
      formController.statusErrorPhone.value = true;
    else
      formController.statusErrorPhone.value = false;
    
    if(_formKeyNewPlayer.currentState!.validate()){
      _formKeyNewPlayer.currentState!.save();
      formController.statusErrorPhone.value = false;
      _passwordController.clear();
      formController.submitForm(index);
    } 
  }

}