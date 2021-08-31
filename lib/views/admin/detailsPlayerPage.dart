import 'package:ctbeca/controller/adminController.dart';
import 'package:ctbeca/env.dart';
import 'package:ctbeca/views/admin/newPlayerPage.dart';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPLayerPage extends StatefulWidget {
  final int index;
  DetailsPLayerPage(this.index);

  @override
  _DetailsPLayerPageState createState() => _DetailsPLayerPageState(index);
}

class _DetailsPLayerPageState extends State<DetailsPLayerPage> {
  final index;
  _DetailsPLayerPageState(this.index);

  AdminController adminController = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    
    var size = MediaQuery.of(context).size;
    
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: GFAppBar(
          backgroundColor: Colors.white,
          leading: GFIconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: colorPrimary,
            ),
            onPressed: () => Get.back(),
            type: GFButtonType.transparent,
          ),
          actions: [
            GFButton(
              onPressed: (){
                Get.off(() => NewPlayerPage(index));
              },
              text: "Modificar",
              color: colorPrimary,
              icon: Icon(
                Icons.edit,
                color: colorPrimary,
              ),
              type: GFButtonType.transparent,
            ),
          ],
          centerTitle: true,
          title: Text(
            "Becado",
            style: TextStyle(
              color: colorPrimary,
            ),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: [
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0) 
                ),
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                boxShadow: [
                  new BoxShadow(
                    color: Color(0xffA4A4A4),
                    offset: Offset(1.0, 5.0),
                    blurRadius: 3.0,
                  ),
                ]
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 20, 5, 5),
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      "Datos Personales",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'MontserratBold',
                      ),
                      maxFontSize: 18,
                      minFontSize: 18,
                    ),
                  ),
                  
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: AutoSizeText.rich(
                      TextSpan(
                        text: 'Nombre: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'MontserratBold',
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: adminController.players[index].name,
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
                  ),

                  Padding(
                    padding: EdgeInsets.all(5),
                    child: AutoSizeText.rich(
                      TextSpan(
                        text: 'Correo Electrónico: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'MontserratBold',
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: adminController.players[index].email,
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
                  ),
                    Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeText.rich(
                          TextSpan(
                            text: 'Teléfono: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'MontserratBold',
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: adminController.players[index].phone,
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
                        ),
                        Expanded(child: Container()),
                        IconButton(
                          icon: Image.asset("assets/icons/telefono.png"), 
                          color: colorPrimary,
                          tooltip: "Llamar",
                          onPressed: () => launch("tel://${adminController.players[index].phone}"),
                        ),
                        IconButton(
                          icon: Image.asset("assets/icons/sms.png"), 
                          color: colorPrimary,
                          tooltip: "Enviar Mensaje",
                          onPressed: () => launch("sms://${adminController.players[index].phone}"),
                        ),
                      ],
                    )
                  ),

                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeText.rich(
                          TextSpan(
                            text: 'Telegram: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'MontserratBold',
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: adminController.players[index].telegram,
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
                        ),

                         adminController.players[index].telegram![0] == "@"? 
                          IconButton(
                            icon: Image.asset("assets/icons/telegram.png"), 
                            onPressed: () => launch("https://t.me/${adminController.players[index].telegram!.replaceAll('@','')}"),
                            tooltip: "Abrir Telegram",
                          )
                        :
                          Container(),
                      ],
                    )
                  ),

                  Padding(
                    padding: EdgeInsets.all(5),
                    child: AutoSizeText.rich(
                      TextSpan(
                        text: 'Referencia: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'MontserratBold',
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: adminController.players[index].reference,
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
                  ),
                ],
              )
            ),

            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0) 
                ),
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                boxShadow: [
                  new BoxShadow(
                    color: Color(0xffA4A4A4),
                    offset: Offset(1.0, 5.0),
                    blurRadius: 3.0,
                  ),
                ]
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 20, 5, 5),
                    alignment: Alignment.center,
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
                  ),

                  Padding(
                    padding: EdgeInsets.all(5),
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
                          child: CachedNetworkImage(
                            imageUrl: "http://"+url+"/storage/${adminController.players[index].urlCodeQr}",
                            placeholder: (context, url) => CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(colorPrimary)),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                            fit: BoxFit.fill,
                            width: size.width / 2,
                            height: size.width / 2,  
                          )
                        ),
                      ),
                    ), 
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: AutoSizeText.rich(
                            TextSpan(
                              text: 'Correo Electrónico: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'MontserratBold',
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: adminController.players[index].emailGame,
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
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.copy,
                            color: colorPrimary,
                          ), 
                          tooltip: "Copiar Correo Electrónico",
                          onPressed: () => Clipboard.setData(ClipboardData(text: adminController.players[index].emailGame)).then((result) {
                            Fluttertoast.showToast(
                              msg: "Correo Electrónico Copiado!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: colorPrimary,
                              textColor: Colors.white,
                              fontSize: 16.0
                            );
                          }),
                        ),
                      ],
                    )
                  ),

                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: AutoSizeText.rich(
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
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.copy,
                            color: colorPrimary,
                          ), 
                          tooltip: "Copiar Billetera",
                          onPressed: () => Clipboard.setData(ClipboardData(text: "ronin:${adminController.players[index].wallet}")).then((result) {
                            Fluttertoast.showToast(
                              msg: "Billetera Copiado!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: colorPrimary,
                              textColor: Colors.white,
                              fontSize: 16.0
                            );
                          }),
                        ),
                      ],
                    )
                  ),
                  
                ],
              )
            ),

            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0) 
                ),
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                boxShadow: [
                  new BoxShadow(
                    color: Color(0xffA4A4A4),
                    offset: Offset(1.0, 5.0),
                    blurRadius: 3.0,
                  ),
                ]
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 20, 5, 5),
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      "Axies",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'MontserratBold',
                      ),
                      maxFontSize: 18,
                      minFontSize: 18,
                    ),
                  ),
                  
                  adminController.players[index].listAnimals!.length == 0 ?  

                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: AutoSizeText(
                          "No tiene Axie",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'MontserratMedium',
                          ),
                          maxFontSize: 18,
                          minFontSize: 18,
                        ),
                      ),
                    )

                  :
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: adminController.players[index].listAnimals!.length,
                      itemBuilder: (BuildContext ctxt, int indexList) {
                        return Container(
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0) 
                            ),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            boxShadow: [
                              new BoxShadow(
                                color: Color(0xffA4A4A4),
                                offset: Offset(1.0, 5.0),
                                blurRadius: 3.0,
                              ),
                            ]
                          ),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: backgroundAxies,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0) 
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: new BorderRadius.circular(10.0), 
                                  child: CachedNetworkImage(
                                    imageUrl: adminController.players[index].listAnimals![indexList].image!,
                                    placeholder: (context, url) => CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(colorPrimary)),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                    fit: BoxFit.fill,
                                    width: size.width / 2,
                                    height: size.width / 2,  
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Center(
                                  child: AutoSizeText(
                                    adminController.players[index].listAnimals![indexList].name!,
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
                              GFListTile(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                title: AutoSizeText.rich(
                                  TextSpan(
                                    text: 'Código: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontFamily: 'MontserratBold',
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: adminController.players[index].listAnimals![indexList].code,
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
                                ),
                                subTitle: AutoSizeText.rich(
                                  TextSpan(
                                    text: 'Nomenclatura: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontFamily: 'MontserratBold',
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: adminController.players[index].listAnimals![indexList].nomenclature,
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
                                ),
                              ),
                            ],
                          )
                        );
                      }
                    ),
                ],
              )
            ),
          ],
        )
      )
    );
  }
}