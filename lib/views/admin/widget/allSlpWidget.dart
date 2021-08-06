import 'package:ctbeca/controller/globalController.dart';
import 'package:ctbeca/controller/mainAdminController.dart';
import 'package:ctbeca/env.dart';
import 'package:ctbeca/models/player.dart';
import 'package:ctbeca/models/slp.dart';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';


class AllSlpWidget extends StatefulWidget {

  @override
  _AllSlpWidgetState createState() => _AllSlpWidgetState();
}

class _AllSlpWidgetState extends State<AllSlpWidget> {

  GlobalController globalController = Get.put(GlobalController());
  MainAdminController mainAdminController = Get.put(MainAdminController());

  @override
  Widget build(BuildContext context) {

    return globalController.players.length == 0? 
      Center(
        child: AutoSizeText(
          "No hay becados",
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
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                "Becado:",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight:  FontWeight.normal,
                  fontFamily: 'MontserratSemiBold',
                ),
                minFontSize: 14,
                maxFontSize: 14,
              ),
              Obx(
                () => Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: DropdownButton<Player>(
                    value: globalController.players[mainAdminController.indexSelect.toInt()],
                    icon: Icon(Icons.arrow_drop_down, color: colorPrimary),
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: colorPrimary,
                    ),
                    onChanged: (Player? newValue){
                      
                      if(globalController.players[mainAdminController.indexSelect.toInt()].id != newValue!.id){
                        for( var i = 0 ; i <= globalController.players.length; i++ ) {
                          if(globalController.players[i].id == newValue.id){
                            mainAdminController.changeSelectIndex(i);
                            break;
                          }
                        }
                      }
                      
                    },
                    style: TextStyle(
                      fontFamily: 'MontserratSemiBold',
                      fontSize:14
                    ),
                    items: globalController.players.map((player) {
                        return DropdownMenuItem<Player>(
                          value: player,
                          child: Container(
                            child: AutoSizeText(
                              player.name!,
                              style: TextStyle(
                                color: colorText,
                                fontFamily: 'MontserratSemiBold',
                                fontSize:14
                              ),
                              maxFontSize: 18,
                              minFontSize: 18,
                            ),
                          ),
                        );
                    }).toList(),
                  )
                )
              ),
            ],
          ),
        ),
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
    
        globalController.players.length == 0? 
          Center(
            child: AutoSizeText(
              "No hay lista de becados con Slp",
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
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: globalController.players.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return GFCard(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: colorPrimary, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                content: ListTile(
                  onTap: () => null, //TODO: onTap
                  title: AutoSizeText(
                    globalController.players[index].name!,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'MontserratBold',
                    ),
                    minFontSize: 12,
                    maxFontSize: 12,
                  ),
                  subtitle: AutoSizeText(
                    globalController.players[index].telegram!,
                    style: TextStyle(
                      color: colorText,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'MontserratBold',
                    ),
                    minFontSize: 10,
                    maxFontSize: 10,
                  ),
                  trailing: AutoSizeText(
                    getLastSlp(globalController.players[index].listSlp, globalController.players[index].listSlp!.length ),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'MontserratSemiBold',
                    ),
                    minFontSize: 12,
                    maxFontSize: 12,
                  ),
                ),
              );
            }
          )
        ),
      ],
    );
  }

  getLastSlp(listSlp, listLenght){

    return "${listSlp[listLenght-1].total} LSP";
  }
}