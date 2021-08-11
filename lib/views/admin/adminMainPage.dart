import 'package:ctbeca/controller/adminController.dart';
import 'package:ctbeca/controller/globalController.dart';
import 'package:ctbeca/env.dart';
import 'package:ctbeca/views/admin/newPlayerPage.dart';
import 'package:ctbeca/views/admin/widget/allHistoryWidget.dart';
import 'package:ctbeca/views/admin/widget/allPlayerWidget.dart';
import 'package:ctbeca/views/admin/widget/allSlpWidget.dart';
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
                  AllPlayerWidget(),
                  AllSlpWidget(),
                  AllHistoryWidget(),
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
        ),
        floatingActionButton: Obx(
          () => Visibility(
            visible: globalController.indexController.value <= 1? true : false,
            child: Padding(
              padding: EdgeInsets.only(bottom: 80),
              child: FloatingActionButton(
                onPressed: () {
                  if(globalController.indexController.value == 0){
                    adminController.getAdmin(true);
                  }
                  else
                    Get.to(() => NewPlayerPage(-1), transition: Transition.zoom);
                },
                child: globalController.indexController.value == 0? Icon(Icons.sync_rounded) : Icon(Icons.add),
                backgroundColor: colorPrimary,
              )
            )
          ),
        )
      ),
    );
  }
}