import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:ctbeca/controller/playerController.dart';
import 'package:ctbeca/env.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class PLayerWidget extends StatefulWidget {
  
  @override
  _PLayerWidgetState createState() => _PLayerWidgetState();
}

class _PLayerWidgetState extends State<PLayerWidget> {

  PlayerController playerController = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    
    var size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0) 
        ),
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        )
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
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
                    text: playerController.player.value.name,
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
                    text: playerController.player.value.email,
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
                text: 'Teléfono: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'MontserratBold',
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: playerController.player.value.phone,
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
                text: 'Telegram: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'MontserratBold',
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: playerController.player.value.telegram,
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
                text: 'Referencia: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'MontserratBold',
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: playerController.player.value.reference,
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
            child: GFAvatar(
              shape: GFAvatarShape.standard,
              radius: size.width / 5,
              backgroundImage: NetworkImage(
                "http://"+url+"/storage/${playerController.player.value.urlCodeQr}",
              ),
            ),
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
                    text: playerController.player.value.emailGame,
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
                text: 'Billetera: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'MontserratBold',
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "ronin:${playerController.player.value.wallet}",
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
    );
  }
}