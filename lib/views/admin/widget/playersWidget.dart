import 'package:ctbeca/controller/adminController.dart';
import 'package:ctbeca/env.dart';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:ctbeca/views/admin/detailsPlayerPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PlayersWidget extends StatefulWidget {

  @override
  _PlayersWidgetState createState() => _PlayersWidgetState();
}

class _PlayersWidgetState extends State<PlayersWidget> {
  AdminController adminController = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Obx(
      () => adminController.players.length == 0? 
        Center(
          child: AutoSizeText(
            "No hay becado",
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
        ListView.builder(
          shrinkWrap: true,
          itemCount: adminController.players.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return GestureDetector(
              onTap: () => Get.to(() => DetailsPLayerPage(index), transition: Transition.rightToLeft),
              child: Container(
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
                child: ListTile(
                  title: AutoSizeText(
                    adminController.players[index].name!,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'MontserratBold',
                    ),
                    minFontSize: 12,
                    maxFontSize: 12,
                  ),
                  subtitle: AutoSizeText(
                    adminController.players[index].telegram!,
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
                        getLastSlp(adminController.players[index].listSlp, adminController.players[index].listSlp!.length ).toString(),
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
              ),
            );
          }
        )
    );
  }

  getLastSlp(listSlp, listLenght){
    if(listLenght == 0) return 0;

    return listSlp[listLenght-1].total;
  }
}