import 'package:ctbeca/env.dart';
import 'package:ctbeca/models/myRow.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class HomeWidget extends StatefulWidget {

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

  List<MaterialColor> listColor = [Colors.orange, Colors.blue, Colors.red];
  List<String> listDate = ["Hoy", "Ayer", "Ultimos 6 Dias"];

 // Defining the data
  final data = [
    new MyRow(new DateTime(2017, 9, 25), 6),
    new MyRow(new DateTime(2017, 9, 26), 8),
    new MyRow(new DateTime(2017, 9, 27), 6),
    new MyRow(new DateTime(2017, 9, 28), 9),
    new MyRow(new DateTime(2017, 9, 29), 11),
    new MyRow(new DateTime(2017, 9, 30), 15),
    new MyRow(new DateTime(2017, 10, 01), 25),
    new MyRow(new DateTime(2017, 10, 02), 33),
    new MyRow(new DateTime(2017, 10, 03), 27),
    new MyRow(new DateTime(2017, 10, 04), 31),
    new MyRow(new DateTime(2017, 10, 05), 23),
  ];

  _getSeriesData() {
    List<charts.Series<MyRow, DateTime>> series = [
      charts.Series<MyRow, DateTime>(
        id: 'Amount',
        domainFn: (MyRow row, _) => row.timeStamp,
        measureFn: (MyRow row, _) => row.amount,
        data: data,
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
        subTitleText: 0.toString(),
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
            child: new charts.TimeSeriesChart(_getSeriesData(), animate: true,),
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
