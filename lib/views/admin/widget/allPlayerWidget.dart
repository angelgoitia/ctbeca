import 'package:ctbeca/controller/globalController.dart';
import 'package:ctbeca/env.dart';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';


class AllPlayerWidget extends StatefulWidget {

  @override
  _AllPlayerWidgetState createState() => _AllPlayerWidgetState();
}

class _AllPlayerWidgetState extends State<AllPlayerWidget> {

  GlobalController globalController = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return globalController.players.length == 0? 
      Center(
        child: AutoSizeText(
          "No tiene becados",
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
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AutoSizeText(
                    getLastSlp(globalController.players[index].listSlp, globalController.players[index].listSlp!.length ),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'MontserratSemiBold',
                    ),
                    minFontSize: 14,
                    maxFontSize: 14,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Image.asset("assets/icons/SLP.png", width: size.width / 12,),
                  )
                ],
              )
            ),
          );
        }
      )
    );
  }

  getLastSlp(listSlp, listLenght){

    return listSlp[listLenght-1].total.toString();
  }
}