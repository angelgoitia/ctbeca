import 'package:ctbeca/controller/playerController.dart';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class SlpWidget extends StatefulWidget {

  @override
  _SlpWidgetState createState() => _SlpWidgetState();
}

class _SlpWidgetState extends State<SlpWidget> {
  final DateFormat formatterBD = DateFormat('yyyy-MM-dd');
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  PlayerController playerController = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(5.0) 
            ),
            border: Border.all(
              color: Colors.black,
              width: 1.0,
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: AutoSizeText(
                  "Fecha",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight:  FontWeight.normal,
                    fontFamily: 'MontserratSemiBold',
                  ),
                  minFontSize: 14,
                  maxFontSize: 14,
                ),
              ),
              Expanded(
                child: AutoSizeText(
                  "Total",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight:  FontWeight.normal,
                    fontFamily: 'MontserratSemiBold',
                  ),
                  minFontSize: 14,
                  maxFontSize: 14,
                ),
              ),
              Expanded(
                child: AutoSizeText(
                  "Diaria",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight:  FontWeight.normal,
                    fontFamily: 'MontserratSemiBold',
                  ),
                  minFontSize: 14,
                  maxFontSize: 14,
                ),
              ),
            ],
            ),
        ),
    
        playerController.player.value.listSlp!.length == 0? 
          Center(
            child: AutoSizeText(
              "No se ha generado la lista",
              style: TextStyle(
                color: Colors.black87,
                fontWeight:  FontWeight.normal,
                fontFamily: 'MontserratSemiBold',
              ),
              minFontSize: 14,
              maxFontSize: 14,
            ),
          )
        : 
        Obx(
          () => Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: playerController.player.value.listSlp!.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return Container(
                  margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0) 
                    ),
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AutoSizeText(
                        formatter.format((formatterBD.parse(playerController.player.value.listSlp![index].createdAt!))).toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight:  FontWeight.normal,
                          fontFamily: 'MontserratSemiBold',
                        ),
                        minFontSize: 14,
                        maxFontSize: 14,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AutoSizeText(
                            playerController.player.value.listSlp![index].total!.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight:  FontWeight.normal,
                              fontFamily: 'MontserratSemiBold',
                            ),
                            minFontSize: 14,
                            maxFontSize: 14,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Image.asset("assets/icons/SLP.png", width: size.width / 15,),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AutoSizeText(
                            playerController.player.value.listSlp![index].daily.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight:  FontWeight.normal,
                              fontFamily: 'MontserratSemiBold',
                            ),
                            minFontSize: 14,
                            maxFontSize: 14,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Image.asset("assets/icons/SLP.png", width: size.width / 15,),
                          )
                        ],
                      ),
                    ],
                  )
                );
              }
            )
          ),
        )
      ],
    );
  }

  getLastSlp(listSlp, listLenght){

    return "${listSlp[listLenght-1].total} LSP";
  }

}