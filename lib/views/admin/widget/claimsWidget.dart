import 'package:ctbeca/controller/adminController.dart';
import 'package:ctbeca/controller/globalController.dart';
import 'package:ctbeca/models/player.dart';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class ClaimsWidget extends StatefulWidget {

  @override
  _ClaimsWidgetState createState() => _ClaimsWidgetState();
}

class _ClaimsWidgetState extends State<ClaimsWidget> {
  final DateFormat formatterBD = DateFormat('yyyy-MM-dd');
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  GlobalController globalController = Get.put(GlobalController());
  AdminController adminController = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return adminController.players.length == 0? 
      Center(
        child: AutoSizeText(
          "No hay becado",
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

    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                "Becado:",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight:  FontWeight.normal,
                  fontFamily: 'MontserratSemiBold',
                ),
                minFontSize: 14,
                maxFontSize: 14,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Container(
                  width: size.width - 200,
                  child: DropdownSearch<Player>(
                    selectedItem: adminController.players[globalController.indexSelect.toInt()],
                    items: adminController.players,
                    dropdownBuilder: _customDropDownExample,
                    popupItemBuilder: _customPopupItemBuilderExample,
                    onChanged: (Player? newValue) {
                      
                      if(adminController.players[globalController.indexSelect.toInt()].id != newValue!.id){
                        for( var i = 0 ; i <= adminController.players.length; i++ ) {
                          if(adminController.players[i].id == newValue.id){
                            globalController.changeSelectIndex(i);
                            break;
                          }
                        }
                      }
                      
                    },
                  ), 
                )
              ),
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
                child: AutoSizeText(
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
              Expanded(
                child: AutoSizeText(
                  "Manager",
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
                  "Becado",
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

        Obx(
          () => adminController.players[globalController.indexSelect.toInt()].listClaims!.length == 0? 
          Center(
            child: AutoSizeText(
              "No hay reclamos",
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
      
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: adminController.players[globalController.indexSelect.toInt()].listClaims!.length,
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
                      formatter.format((formatterBD.parse(adminController.players[globalController.indexSelect.toInt()].listClaims![index].date!))).toString(),
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
                          adminController.players[globalController.indexSelect.toInt()].listClaims![index].total.toString(),
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
                          adminController.players[globalController.indexSelect.toInt()].listClaims![index].totalManager!.toString(),
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
                          adminController.players[globalController.indexSelect.toInt()].listClaims![index].totalPlayer!.toString(),
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

  Widget _customDropDownExample(BuildContext context, Player? item, String itemDesignation) {
    if (item == null) {
      return Container();
    }

    return Container(
      child: (item.name == null)
      ? ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text("Sin seleccionar un becado"),
        )
      : ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text(item.name!),
        ),
    );
  }

  Widget _customPopupItemBuilderExample(BuildContext context, Player item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.name!),
        subtitle: Text(item.email!),
        trailing: Text(item.telegram!),
      ),
    );
  }

}