import 'package:ctbeca/controller/playerController.dart';
import 'package:ctbeca/env.dart';
import 'package:ctbeca/models/myRow.dart';

import 'package:ctbeca/models/slp.dart';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

class HomeWidget extends StatefulWidget {

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

  DateTime now = new DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  List<MaterialColor> listColor = [Colors.orange, Colors.blue, Colors.red];
  List<String> listDate = ["Hoy", "Ayer", "Ultimos 6 Dias"];

  PlayerController playerController = Get.put(PlayerController());

  _getSeriesData() {
    List<charts.Series<MyRow, DateTime>> series = [
      charts.Series<MyRow, DateTime>(
        id: 'Amount',
        domainFn: (MyRow row, _) => row.timeStamp,
        measureFn: (MyRow row, _) => row.amount,
        data: playerController.dataGraphic,
        colorFn: (MyRow row, _) => charts.MaterialPalette.green.shadeDefault,
        fillColorFn: (MyRow row, _) => charts.MaterialPalette.blue.shadeDefault,
      )
    ];
    return series;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              showWidget(0),
              showWidget(1),
              showWidget(2),
              showChart(2),
            ]
          )
        )
      )
    );
  }

  showWidget(int index)
  {
    var size = MediaQuery.of(context).size;

    return GFCard(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: colorPrimary, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      boxFit: BoxFit.cover,
      titlePosition: GFPosition.start,
      title: GFListTile(
        avatar: GFAvatar(
          size: 45,
          backgroundColor: listColor[index],
          shape: GFAvatarShape.standard,
          child: GFAvatar(
            backgroundImage: AssetImage("assets/icons/SLP.png"),
            backgroundColor: Colors.transparent,
            size: size.width /15,
          ),
        ),
        titleText: 'Total de SLP',
        title: AutoSizeText(
          'Total de SLP',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontFamily: 'MontserratBold',
          ),
          maxFontSize: 14,
          minFontSize: 14,
        ),
        subTitleText: "",
        icon: AutoSizeText(
          showTotal(index, playerController.player.value.listSlp!).toString(),style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontFamily: 'MontserratMedium',
          ),
          maxFontSize: 18,
          minFontSize: 18,
        ),
      ),
      content: Row(
        children: [
          Icon(Icons.calendar_today),
          SizedBox(width: 10,),
          Text(listDate[index]),
        ],
      ),
    );
  }

  showTotal(int index, List<Slp> listSlp)
  {
    int totalSLP = 0;

    if (listSlp.length == 0) return totalSLP;

    switch (index) {
      case 0:
        DateTime dateList = DateTime.parse(listSlp[listSlp.length -1].createdAt!);
        if(dateList.day == now.day && dateList.month == now.month && dateList.year == now.year){
          totalSLP += listSlp[listSlp.length -1].daily!.toInt();
        }
        break;
      case 1:
        final yesterdays = DateTime.now().subtract(Duration(days:1));
        for (var item in listSlp) {
          DateTime dateList = DateTime.parse(item.createdAt!);
          if(dateList.day == yesterdays.day && dateList.month == yesterdays.month && dateList.year == yesterdays.year){
            totalSLP += item.daily!.toInt();
            break;
          }
        }
        break;
      case 2:
        final _lastDay = DateTime.now().add(Duration(days:1));
        final dateLastSixDays = DateTime.now().subtract(Duration(days:6));
        
        for (var item in listSlp) {
          DateTime dateList = DateTime.parse(item.createdAt!);
          if(dateLastSixDays.isBefore(dateList) && _lastDay.isAfter(dateList)){
            totalSLP += item.daily!.toInt();
          }
        }
        break;
    }

    return totalSLP;
  }


  showChart(int index)
  {
    return GFCard(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: colorPrimary, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      boxFit: BoxFit.cover,
      content: Column(
        children: [
          Container(
            height: 350,
            child: new charts.TimeSeriesChart(
              _getSeriesData(), 
              animate: true,
            ),
          ),
          SizedBox(height: 15,),
          Row(
            children: [
              Icon(Icons.calendar_today),
              SizedBox(width: 10,),
              Text(listDate[index]),
            ],
          ),
        ],
      )
    );
  }

}
