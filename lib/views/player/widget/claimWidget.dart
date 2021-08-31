import 'package:ctbeca/controller/playerController.dart';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class ClaimWidget extends StatefulWidget {

  @override
  _ClaimWidgetState createState() => _ClaimWidgetState();
}

class _ClaimWidgetState extends State<ClaimWidget> {
  final DateFormat formatterBD = DateFormat('yyyy-MM-dd');
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  var myGroup = AutoSizeGroup();

  PlayerController playerController = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Obx(
      () => Column(
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
                    group: myGroup,
                    minFontSize: 13,
                    maxFontSize: 13,
                  ),
                ),
                Expanded(
                  child: AutoSizeText(
                    "Acumulado",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight:  FontWeight.normal,
                      fontFamily: 'MontserratSemiBold',
                    ),
                    group: myGroup,
                    minFontSize: 13,
                    maxFontSize: 13,
                  ),
                ),
                Expanded(
                  child: AutoSizeText(
                    "Manager",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight:  FontWeight.normal,
                      fontFamily: 'MontserratSemiBold',
                    ),
                    group: myGroup,
                    minFontSize: 13,
                    maxFontSize: 13,
                  ),
                ),
                Expanded(
                  child: AutoSizeText(
                    "Becado",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight:  FontWeight.normal,
                      fontFamily: 'MontserratSemiBold',
                    ),
                    group: myGroup,
                    minFontSize: 13,
                    maxFontSize: 13,
                  ),
                ),
              ],
            ),
          ),
      
          playerController.player.value.listClaims!.length == 0? 
            Center(
              child: AutoSizeText(
                "No hay reclamos",
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
                itemCount: playerController.player.value.listClaims!.length,
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
                          formatter.format((formatterBD.parse(playerController.player.value.listClaims![index].date!))).toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight:  FontWeight.normal,
                            fontFamily: 'MontserratSemiBold',
                          ),
                          group: myGroup,
                          minFontSize: 13,
                          maxFontSize: 13,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AutoSizeText(
                              playerController.player.value.listClaims![index].total.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight:  FontWeight.normal,
                                fontFamily: 'MontserratSemiBold',
                              ),
                              group: myGroup,
                              minFontSize: 13,
                              maxFontSize: 13,
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
                              playerController.player.value.listClaims![index].totalManager.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight:  FontWeight.normal,
                                fontFamily: 'MontserratSemiBold',
                              ),
                              group: myGroup,
                              minFontSize: 13,
                              maxFontSize: 13,
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
                              playerController.player.value.listClaims![index].totalPlayer!.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight:  FontWeight.normal,
                                fontFamily: 'MontserratSemiBold',
                              ),
                              group: myGroup,
                              minFontSize: 13,
                              maxFontSize: 13,
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
        ],
      )
    );
  }

}