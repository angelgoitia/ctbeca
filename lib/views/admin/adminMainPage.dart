import 'package:ctbeca/controller/mainAdminController.dart';
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
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainAdminController>(
      init:MainAdminController(),
      builder: (_) => WillPopScope(
      onWillPop: _.onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Navbar(),
            Expanded(child: Container()),
            GFTabBar(
              length: 3,
              controller: tabController,
              tabs: [
                Tab(
                  icon: Icon(Icons.directions_bike),
                  child: Text(
                    "Tab1",
                  ),
                ),
                Tab(
                  icon: Icon(Icons.directions_bus),
                  child: Text(
                    "Tab2",
                  ),
                ),
                Tab(
                  icon: Icon(Icons.directions_railway),
                  child: Text(
                    "Tab3",
                  ),
                ),
              ],
            ),
          ],
        )
      ),
    )
    );
  }
}