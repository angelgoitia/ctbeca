import 'package:ctbeca/controller/globalController.dart';
import 'package:ctbeca/controller/playerController.dart';
import 'package:ctbeca/controller/slpController.dart';
import 'package:ctbeca/env.dart';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class SlpWidget extends StatefulWidget {

  @override
  _SlpWidgetState createState() => _SlpWidgetState();
}

class _SlpWidgetState extends State<SlpWidget> {
  final DateFormat formatterBD = DateFormat('yyyy-MM-dd');
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  var controllerInitialDate = TextEditingController(), controllerFinalDate = TextEditingController();

  GlobalController globalController = Get.put(GlobalController());
  PlayerController playerController = Get.put(PlayerController());
  SLpController slpController = Get.put(SLpController());

  @override
  void initState() {
    super.initState();
    
    if(DateTime.now().day <=15)
      controllerInitialDate.text = formatter.format(DateTime(DateTime.now().year, DateTime.now().month, 1));
    else
      controllerInitialDate.text = formatter.format(DateTime(DateTime.now().year, DateTime.now().month, 16));
    
    controllerFinalDate.text = formatter.format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {

    return Obx(
      () => Container(
        alignment: Alignment.center,
        child: slpController.statusLoading.value? 
          CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(colorPrimary))
          : slpWidget(), 
      ),
    );
  }

  Widget slpWidget(){
    var size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              showInputDate("Inicial",controllerInitialDate,0),
              showInputDate("Final",controllerFinalDate,1),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(5.0) 
            ),
            border: Border.all(
              color: Colors.black,
              width: 1.0,
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => slpController.updateOrden(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        "Fecha",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight:  FontWeight.normal,
                          fontFamily: 'MontserratSemiBold',
                        ),
                        minFontSize: 14,
                        maxFontSize: 14,
                      ),
                      SizedBox(width: 5,),
                      Icon(slpController.statusOrder.value? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded, color: colorPrimary,)
                    ],
                  )
                ),
              ),
              Expanded(
                child: AutoSizeText(
                  "Diaria",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight:  FontWeight.normal,
                    fontFamily: 'MontserratSemiBold',
                  ),
                  minFontSize: 14,
                  maxFontSize: 14,
                ),
              ),
              Expanded(
                child: AutoSizeText(
                  "Acumulado",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight:  FontWeight.normal,
                    fontFamily: 'MontserratSemiBold',
                  ),
                  minFontSize: 14,
                  maxFontSize: 14,
                ),
              ),
            ],
            ),
        ),
    
        playerController.player.value.listSlp!.length == 0? 
          Center(
            child: AutoSizeText(
              "No se ha generado la lista",
              style: TextStyle(
                color: Colors.black87,
                fontWeight:  FontWeight.normal,
                fontFamily: 'MontserratSemiBold',
              ),
              minFontSize: 14,
              maxFontSize: 14,
            ),
          )
        : 
        Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: slpController.listSlp.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return Container(
                  margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0) 
                    ),
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AutoSizeText(
                        formatter.format((formatterBD.parse(slpController.listSlp[index].date!))).toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight:  FontWeight.normal,
                          fontFamily: 'MontserratSemiBold',
                        ),
                        minFontSize: 14,
                        maxFontSize: 14,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AutoSizeText(
                            slpController.listSlp[index].daily.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight:  FontWeight.normal,
                              fontFamily: 'MontserratSemiBold',
                            ),
                            minFontSize: 14,
                            maxFontSize: 14,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Image.asset("assets/icons/SLP.png", width: size.width / 15,),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AutoSizeText(
                            slpController.listSlp[index].total!.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight:  FontWeight.normal,
                              fontFamily: 'MontserratSemiBold',
                            ),
                            minFontSize: 14,
                            maxFontSize: 14,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Image.asset("assets/icons/SLP.png", width: size.width / 15,),
                          )
                        ],
                      ),
                    ],
                  )
                );
              }
            )
          ),
      ],
    );
  }

  getLastSlp(listSlp, listLenght){
    return "${listSlp[listLenght-1].total} LSP";
  }

  showInputDate(_title, _controller,index){
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width/3,
      child: TextFormField(
        readOnly: true,
        cursorColor: colorPrimary,
        decoration: InputDecoration(
          fillColor: colorPrimary,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: Colors.green[900]!,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: Colors.green[900]!,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: Colors.green[900]!,
            ),
          ),
          labelText: _title,
          labelStyle: TextStyle(
            color: colorPrimary,
            fontFamily: 'MontserratSemiBold',
            fontSize: 14,
          ),
        ),
        controller: _controller,
        style: TextStyle(
          fontSize: 15,
          fontFamily: 'MontserratSemiBold',
        ),
        onTap: () {
          _selectDate(context, index);
        }
      )
    );
  }

  Future<Null> _selectDate(BuildContext context, statusDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.green,
                primaryColorDark: Colors.green,
                accentColor: Colors.green,
              ),
            dialogBackgroundColor:Colors.white,
          ),
          child: child!,
        );
      },
      locale : const Locale("es","ES"),
      initialDate: slpController.slpDate.value.selectInitial!,
      firstDate:  slpController.slpDate.value.rangeInitial!,
      lastDate: slpController.slpDate.value.rangeFinal!,
      helpText: statusDate == 0? "Seleccionar la Fecha Inicial:" : "Seleccionar la Fecha Final:",
    );

    if (picked != null && picked != DateTime.now()){
      if (statusDate == 0){
        slpController.slpDate.value.selectInitial = picked;

        if (controllerFinalDate.text.length == 0)
          controllerFinalDate.text = formatter.format(DateTime.now());
        
        controllerInitialDate.text = formatter.format(slpController.slpDate.value.selectInitial!);
      }else{
        slpController.slpDate.value.selectFinal = picked;

        slpController.slpDate.value.selectFinal = DateTime(picked.year, picked.month, picked.day+1);
        controllerFinalDate.text = formatter.format(slpController.slpDate.value.selectFinal!);
      }
      slpController.getListSlp();
    }
    
  }

}