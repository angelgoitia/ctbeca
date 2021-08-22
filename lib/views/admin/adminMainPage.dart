import 'package:ctbeca/controller/adminController.dart';
import 'package:ctbeca/controller/globalController.dart';
import 'package:ctbeca/env.dart';
import 'package:ctbeca/views/admin/newPlayerPage.dart';
import 'package:ctbeca/views/admin/widget/claimsWidget.dart';
import 'package:ctbeca/views/admin/widget/playersWidget.dart';
import 'package:ctbeca/views/admin/widget/slpsWidget.dart';
import 'package:ctbeca/views/admin/widget/homeWidget.dart';
import 'package:ctbeca/views/navbar/navbar.dart';

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

  GlobalController globalController = Get.put(GlobalController());
  AdminController adminController = Get.put(AdminController());

  @override
  void initState() {
    super.initState();
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
                  PlayersWidget(),
                  SlpsWidget(),
                  ClaimsWidget(),
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
                  text: "Becados",
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
        floatingActionButton: Obx(
          () => Padding(
            padding: EdgeInsets.only(bottom: 80),
            child: FloatingActionButton(
              onPressed: () {
                if(globalController.indexController.value != 1){
                  adminController.getAdmin(true);
                }
                else
                  Get.to(() => NewPlayerPage(-1), transition: Transition.zoom);
              },
              child: globalController.indexController.value == 1? Icon(Icons.add) : Icon(Icons.sync_rounded),
              backgroundColor: colorPrimary,
            )
          ),
        )
      ),
    );
  }
}