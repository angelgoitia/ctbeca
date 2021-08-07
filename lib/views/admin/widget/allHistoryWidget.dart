import 'package:ctbeca/controller/adminController.dart';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AllHistoryWidget extends StatefulWidget {

  @override
  _AllHistoryWidgetState createState() => _AllHistoryWidgetState();
}

class _AllHistoryWidgetState extends State<AllHistoryWidget> {

  AdminController adminController = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {

    return adminController.histories.length == 0? 
      Center(
        child: AutoSizeText(
          "No hay Historial",
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
      () => ListView.builder(
        shrinkWrap: true,
        itemCount: adminController.histories.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return GestureDetector(
            onTap: () => print("click"), // TODO: onTap
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
                  "prueba",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'MontserratBold',
                  ),
                  minFontSize: 12,
                  maxFontSize: 12,
                ),
              ),   
            ),
          );
        }
      )
    );
  }


}