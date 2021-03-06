import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ctbeca/controller/adminController.dart';
import 'package:ctbeca/controller/formController.dart';
import 'package:ctbeca/env.dart';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:ctbeca/models/admin.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormWidget extends StatefulWidget {
  final int index;
  FormWidget(this.index);

  @override
  _FormWidgetState createState() => _FormWidgetState(index);
}

class _FormWidgetState extends State<FormWidget> {
  final int index;
  _FormWidgetState(this.index);

  final DateFormat formatterBD = DateFormat('yyyy-MM-dd');
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
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
  final FocusNode _dateClaimFocus = FocusNode();  
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _otherReferenceController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _dateClaimController = TextEditingController();

  DateTime? now = DateTime.now();
  DateTime? playerDateClaim = DateTime.now();

  FormController formController = Get.put(FormController());
  AdminController adminController = Get.put(AdminController());

  @override
  void initState()  {
    super.initState();
    formController.getSelectDropdow(index);
    _phoneController.text = index >= 0? adminController.players[index].phone!.substring(5) : '';
    formController.player.value.wallet = index >= 0? adminController.players[index].wallet! : '';
    formController.selectDropdowGroup.value = index >= 0? adminController.players[index].group! : formController.selectDropdowGroup.value;
    _dateClaimController.text = index >=0? formatter.format(formatterBD.parse(adminController.players[index].dateClaim!)) : formatter.format(DateTime.now());
    formController.player.value.dateClaim = index >=0? formatter.format(formatterBD.parse(adminController.players[index].dateClaim!)) : formatter.format(DateTime.now());
    if(formController.statusOtherReference.value)
      _otherReferenceController.text = adminController.players[index].reference!;
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
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z\ ????????????????????????\s]")),
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
                validator: (value) => value!.trim().length >5? null : 'Ingrese un nombre v??lido',
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
                            msg: "Debe seleccionar los primeros 4 digitos de tu telef??no!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: colorPrimary,
                            textColor: Colors.white,
                            fontSize: 16.0
                          );
                        else{
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

                  SizedBox(width: 10,),
                  AutoSizeText(
                    '-',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'MontserratSemiBold',
                    ),
                    maxFontSize: 14,
                    minFontSize: 14,
                  ),
                  SizedBox(width: 10,),

                  Expanded(
                    child: new TextFormField(
                      controller: _phoneController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                        new LengthLimitingTextInputFormatter(7),
                      ], 
                      maxLines: 1,
                      keyboardType: TextInputType.phone,
                      autofocus: false,
                      focusNode: _phoneFocus,
                      onEditingComplete: () => FocusScope.of(context).requestFocus(_telegramFocus),
                      decoration: new InputDecoration(
                        labelText: "Telef??no",
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
                      'Ingrese un n??mero de tel??fono v??lido',
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
                  hintText: "@JoeDoe ?? 04125555555",
                  icon: Image.asset("assets/icons/telegramBlack.png", width: 20, color: colorPrimary,),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorPrimary),
                  ),
                ),
                validator: (value) => formController.validateTelegram(value!)? null : 'Ingrese un usuario de telegram o un n??mero de tel??fono v??lido',
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
                  labelText: "Correo Electr??nico",
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
                validator: (value) => formController.validarEmail(value!)? null : 'Ingrese un Correo Electr??nico v??lido',
                onSaved: (value) => formController.player.value.email = value!.trim(),
                textInputAction: TextInputAction.next ,
                cursorColor: colorPrimary,
                style: TextStyle(
                  fontFamily: 'MontserratSemiBold',
                  fontSize: 14,
                ),
              ),
            ),

            Obx(
              () => Visibility(
                visible: adminController.admin.value.id == 1? true : false,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.group,
                        color: colorPrimary,
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                        child: DropdownSearch<Admin>(
                          selectedItem: formController.selectDropdowGroup.value,
                          items: formController.listGroups,
                          dropdownBuilder: _customDropDownAdmin,
                          popupItemBuilder: _customPopupItemBuilderAdmin,
                          onSaved: (Admin? value) => adminController.admin.value.id == 1? formController.player.value.adminId = value!.id : adminController.admin.value.id,
                          validator: (Admin? value){
                            if(value!.nameGroup == "Seleccionar")
                              return "Debe seleccionar un grupo";
                            
                            return null;
                          },
                          onChanged: (Admin? newValue) {
                            
                            formController.selectDropdowGroup.value = newValue!;
                            
                          },
                        )
                      ), 
                    ],
                  )
                )
              ),
            ),
            

            Padding(
              padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
              child: Row(
                children: [
                  ImageIcon(
                    AssetImage("assets/icons/reference.png"),
                    color: colorPrimary,
                    size: 18,
                  ),

                  SizedBox(width: 15,),

                  Obx(
                    () => Expanded(
                      child: DropdownSearch<String>(
                        selectedItem: formController.selectDropdowReference.value,
                        items: formController.listReferences,
                        dropdownBuilder: _customDropDownString,
                        popupItemBuilder: _customPopupItemBuilderString,
                        validator: (String? value){
                          if(value == "Seleccionar")
                            return "Debe seleccionar una referencia";
                          return null;
                        },
                        onChanged: (String? newValue) {
                          
                          if(newValue == "Seleccionar"){
                            formController.statusOtherReference.value = false;
                          }
                          else if(newValue == "Otro"){
                            formController.statusOtherReference.value = true;
                            FocusScope.of(context).requestFocus(_referenceFocus);
                          }
                          else{
                            formController.statusOtherReference.value = false;
                            FocusScope.of(context).requestFocus(_walletFocus);
                          }
                          
                          formController.selectDropdowReference.value = newValue!;
                          formController.player.value.reference = newValue;
                          
                        },
                      )
                    )
                  ),
                ],
              )
            ),

            Obx(
              () => Visibility(
                visible: formController.statusOtherReference.value,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
                  child: new TextFormField(
                    maxLines: 1,
                    controller: _otherReferenceController,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z\ ????????????????????????\s]")),
                    ], 
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
                    validator: (value) => formController.statusOtherReference.value? value!.trim().length >5? null : 'Ingrese un nombre v??lido' : null,
                    onSaved: (value) => formController.statusOtherReference.value? formController.player.value.reference = value!.trim() : formController.player.value.reference = formController.selectDropdowReference.value,
                  ),
                )
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
                  validator: (value) => value!.trim().length >=20? null : 'Ingrese una Billetera v??lido',
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
                            width: size.width / 2,
                            height: size.width / 2,    
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
                  labelText: 'C??digo QR',
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
                visible: formController.statusErrorQr.value,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 0.0),
                  child: Center(
                    child: AutoSizeText(
                      'Selecionar un C??digo QR',
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
                initialValue: index >= 0? adminController.players[index].emailGame : '',
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
                ],
                focusNode: _emailGameFocus,
                onEditingComplete: () => FocusScope.of(context).requestFocus(_passwordGameFocus),
                decoration: new InputDecoration(
                  labelText: "Correo Electr??nico",
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
                validator: (value) => formController.validarEmail(value!)? null : 'Ingrese un Correo Electr??nico v??lido',
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
                    labelText: "Contrase??a",
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
                  validator: (value) => value!.trim().length < 5? 'Ingrese una contrase??a v??lida': null,
                  onSaved: (value) => formController.player.value.passwordGame = value!.trim(),
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => FocusScope.of(context).requestFocus(_dateClaimFocus),
                  cursorColor: colorPrimary,
                  style: TextStyle(
                    fontFamily: 'MontserratSemiBold',
                    fontSize: 14,
                  ),
                ),
              ),
            ),  

            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
              child: TextFormField(
                readOnly: true,
                cursorColor: colorPrimary,
                decoration: InputDecoration(
                  fillColor: colorPrimary,
                  icon: new Icon(
                    Icons.date_range,
                    color: colorPrimary
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.green[900]!,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.green[900]!,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.green[900]!,
                    ),
                  ),
                  labelText: "Fecha de reclamo",
                  labelStyle: TextStyle(
                    color: colorPrimary,
                    fontFamily: 'MontserratSemiBold',
                    fontSize: 14,
                  ),
                ),
                controller: _dateClaimController,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'MontserratSemiBold',
                ),
                onTap: () {
                  _selectDate(context);
                }
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
          backgroundColor: Colors.white,
          toolbarWidgetColor: Colors.white,
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
        formController.statusErrorQr.value = false;
        formController.player.value.urlCodeQr = base64Encode(cropped.readAsBytesSync());

      }
    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.green,
                primaryColorDark: Colors.green,
                accentColor: Colors.green,
              ),
            dialogBackgroundColor:Colors.white,
          ),
          child: child!,
        );
      },
      locale : const Locale("es","ES"),
      firstDate: DateTime(2021, 1, 1),
      lastDate: DateTime.now(),
      initialDate: formatter.parse(formController.player.value.dateClaim!),
      helpText: "Seleccionar una fecha de reclamo",
    );

    if (picked != null){
      _dateClaimController.text = formatter.format(picked);
      formController.player.value.dateClaim = formatter.format(picked);
    } 

  }

  void tapSubmit(index){

    if(index < 0 && !formController.imageSelect.value)
      formController.statusErrorQr.value = true;
    else 
      formController.statusErrorQr.value = false;

    if("${formController.digitsPhone.value}-${_phoneController.text.trim()}".length != 12)
      formController.statusErrorPhone.value = true;
    else
      formController.statusErrorPhone.value = false;

    if(_formKeyNewPlayer.currentState!.validate() && !formController.statusErrorPhone.value && !formController.statusErrorQr.value){
      _formKeyNewPlayer.currentState!.save();
      _passwordController.clear();
      formController.submitForm(index);
    } 
  }

  Widget _customDropDownAdmin(BuildContext context, Admin? item, String itemDesignation) {
    if (item == null) {
      return Container();
    }

    return Container(
      child: (item.nameGroup == null)
      ? ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text("Sin seleccionar un Grupo"),
        )
      : ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text(item.nameGroup!),
        ),
    );
  }

  Widget _customPopupItemBuilderAdmin(BuildContext context, Admin item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.nameGroup!),
        subtitle: Text(item.name!),
      ),
    );
  }

  Widget _customDropDownString(BuildContext context, String? item, String itemDesignation) {
    if (item == null) {
      return Container();
    }

    return Container(
      child: ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text(item),
        ),
    );
  }

  Widget _customPopupItemBuilderString(BuildContext context, String item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item),
      ),
    );
  }

}