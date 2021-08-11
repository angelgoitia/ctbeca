import 'package:ctbeca/controller/adminController.dart';
import 'package:ctbeca/env.dart';
import 'package:ctbeca/models/myRow.dart';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ctbeca/models/player.dart';
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

  AdminController adminController = Get.put(AdminController());


  _getSeriesData(data) {
    List<charts.Series<MyRow, DateTime>> series = [
      charts.Series<MyRow, DateTime>(
        id: 'Amount',
        data: data.value,
        domainFn: (MyRow row, _) => row.timeStamp,
        measureFn: (MyRow row, _) => row.amount,
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
        child: Column(
          children: [
            showWidget(0),
            showWidget(1),
            showWidget(2),
            showChart(2),
          ]
        )
      )
    );
  }

  showWidget(int index)
  {
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
            size: 30,
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
          showTotal(index, adminController.players).toString(),style: TextStyle(
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

  showTotal(int index, List<Player> players)
  {
    int totalSLP = 0;

    if (players.length == 0) return totalSLP;

    switch (index) {
      case 0:
        for (var player in players) {

          if(player.listSlp!.length >0) break;

          DateTime dateList = DateTime.parse(player.listSlp![player.listSlp!.length -1].date!);
          if(dateList.day == now.day && dateList.month == now.month && dateList.year == now.year){
            totalSLP += player.listSlp![player.listSlp!.length -1].daily!.toInt();
          } 
        }
        break;
      case 1:
        final yesterdays = DateTime.now().subtract(Duration(days:1));
        for (var player in players) {
          for (var item in player.listSlp!) {
            DateTime dateList = DateTime.parse(item.date!);
            if(dateList.day == yesterdays.day && dateList.month == yesterdays.month && dateList.year == yesterdays.year){
              totalSLP += item.daily!.toInt();
              break;
            }
          }
        }
        break;
      case 2:
        final _lastDay = DateTime.now().add(Duration(days:1));
        final dateLastSixDays = DateTime.now().subtract(Duration(days:6));
        for (var player in players) {
          for (var item in player.listSlp!) {
            DateTime dateList = DateTime.parse(item.date!);
            if(dateLastSixDays.isBefore(dateList) && _lastDay.isAfter(dateList)){
              totalSLP += item.daily!.toInt();
            }
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
      content: Column(
        children: [
          Obx(
            () => Container(
              height: 350,
              child: new charts.TimeSeriesChart(
                _getSeriesData(adminController.dataGraphic), 
                animate: true,
                domainAxis: new charts.DateTimeAxisSpec(
                  tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
                    day: new charts.TimeFormatterSpec(
                      format: 'dd/MM/yy', transitionFormat: 'dd/MM/yy', 
                    )
                  ),
                ),
                defaultRenderer: new charts.LineRendererConfig(includePoints: true)
              ),
            )
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
