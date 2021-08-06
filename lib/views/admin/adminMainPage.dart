import 'package:ctbeca/controller/globalController.dart';
import 'package:ctbeca/env.dart';
import 'package:ctbeca/views/admin/widget/allPlayerWidget.dart';
import 'package:ctbeca/views/admin/widget/allSlpWidget.dart';
import 'package:ctbeca/views/admin/widget/homeWidget.dart';
import 'package:ctbeca/views/widget/navbar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class AdminMainPage extends StatefulWidget {
  AdminMainPage({Key? key}) : super(key: key);

  @override
  _AdminMainPageState createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
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
                  HomeWidget(),
                  AllPlayerWidget(),
                  AllSlpWidget(),
                  Container(color: Colors.blue)
                ]
              ),
            ),
            GFTabBar(
              length: 4,
              controller: tabController,
              tabBarColor: Colors.white,
              indicatorColor: colorPrimary,
              labelColor: colorPrimary,
              unselectedLabelColor: Colors.black87,
              isScrollable: false,
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                  text: "Inicio",
                ),
                Tab(
                  icon: Icon(Icons.person),
                  text: "Becados",
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