import 'package:ctbeca/controller/globalController.dart';
import 'package:ctbeca/controller/playerController.dart';
import 'package:ctbeca/env.dart';
import 'package:ctbeca/views/player/widget/claimWidget.dart';
import 'package:ctbeca/views/player/widget/playerWidget.dart';
import 'package:ctbeca/views/player/widget/slpWidget.dart';
import 'package:ctbeca/views/player/widget/homeWidget.dart';
import 'package:ctbeca/views/navbar/navbar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class PlayerMainPage extends StatefulWidget {
  PlayerMainPage({Key? key}) : super(key: key);

  @override
  _PlayerMainPageState createState() => _PlayerMainPageState();
}

class _PlayerMainPageState extends State<PlayerMainPage> with SingleTickerProviderStateMixin {
  TabController? tabController;

  GlobalController globalController = Get.put(GlobalController());
  PlayerController playerController = Get.put(PlayerController());
  
  @override
  void initState() {
    super.initState();
    globalController.registerNotification(1);
    globalController.initialNotification();
    tabController = TabController(length: 4, vsync: this);

    tabController!.addListener(() {
      globalController.indexController.value = tabController!.index;
    });
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: globalController.onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Navbar(),
            Expanded(
              child: GFTabBarView(
                controller: tabController,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  HomeWidget(),
                  PLayerWidget(),
                  SlpWidget(),
                  ClaimWidget(),
                ]
              ),
            ),
            GFTabBar(
              length: 3,
              controller: tabController,
              tabBarColor: Colors.white,
              indicatorColor: colorPrimary,
              labelColor: colorPrimary,
              unselectedLabelColor: Colors.black87,
              isScrollable: false,
              indicatorWeight: 4,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: colorPrimary),
              ),
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                  text: "Inicio",
                ),
                Tab(
                  icon: Icon(Icons.person),
                  text: "Perfil",
                ),
                Tab(
                  icon: Icon(Icons.sports_esports),
                  text: "SLP"
                ),
                Tab(
                  icon: Icon(Icons.request_quote_rounded),
                  text: "Reclamos",
                ),
              ],
            ),
          ],
        ),
        floatingActionButton:  Padding(
          padding: EdgeInsets.only(bottom: 80),
          child: FloatingActionButton(
            onPressed: () => playerController.getPlayer(true),
            child: Icon(Icons.sync_rounded),
            backgroundColor: colorPrimary,
          ),
        ),
      ),
    );
  }
}