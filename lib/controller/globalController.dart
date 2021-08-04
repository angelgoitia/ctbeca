import 'package:ctbeca/env.dart';
import 'package:ctbeca/models/player.dart';
import 'package:ctbeca/models/user.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {

  User user = User();
  Player player = Player();
  RxList<Player> players = <Player>[].obs;


  Future<List<Player>> getPlayers(data) async {
    return (data as List).map((e) => Player.fromJson(e)).toList();
  }


  loading(){
    Get.defaultDialog(
      title: "",
      backgroundColor: Colors.white,
      barrierDismissible: false,
      content: WillPopScope(
        onWillPop: () async => false,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5),
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(colorPrimary),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Cargando ",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'MontserratSemiBold',
                        )
                      ),
                      TextSpan(
                        text: "...",
                        style: TextStyle(
                          color: colorPrimary,
                          fontFamily: 'MontserratSemiBold',
                        )
                      ),
                    ]
                  ),
                ),
              ),
            ],
        ),
      ),
    );
  }
}