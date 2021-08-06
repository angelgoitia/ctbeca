import 'package:ctbeca/controller/globalController.dart';
import 'package:ctbeca/env.dart';
import 'package:ctbeca/views/widget/navbar.dart';

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

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    GlobalController globalController = Get.put(GlobalController());

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
                children: <Widget>[
                  Container(color: Colors.red),
                  Container(color: Colors.green),
                  Container(color: Colors.blue)
                ]
              ),
            ),
            GFTabBar(
              length: 3,
              controller: tabController,
              indicatorColor: colorPrimary,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 5.0),
              ),
              tabBarColor: Colors.white,
              labelColor: colorPrimary,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                  text: "Inicio",
                ),
                Tab(
                  icon: Icon(Icons.videogame_asset),
                  text: "LSP"
                ),
                Tab(
                  icon: Icon(Icons.request_quote_rounded),
                  text: "Historial",
                ),
              ],
              
            ),
          ],
        )
      ),
    );

  }
}