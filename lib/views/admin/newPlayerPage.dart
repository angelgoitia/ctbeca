import 'package:ctbeca/controller/adminController.dart';
import 'package:ctbeca/env.dart';

import 'package:ctbeca/views/admin/widgetNewPlayer/formWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class NewPlayerPage extends StatefulWidget {
  final int index;
  NewPlayerPage(this.index);

  @override
  _NewPlayerPageState createState() => _NewPlayerPageState(index);
}

class _NewPlayerPageState extends State<NewPlayerPage> {
  final int index;
  _NewPlayerPageState(this.index);

  AdminController adminController = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: GFAppBar(
          backgroundColor: Colors.white,
          leading: GFIconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: colorPrimary,
            ),
            onPressed: () => Get.back(),
            type: GFButtonType.transparent,
          ),
          centerTitle: true,
          title: Text(
            "Nuevo Becado",
            style: TextStyle(
              color: colorPrimary,
            ),
          ),
        ),
        body: FormWidget(index),
      )
    );
  }
}