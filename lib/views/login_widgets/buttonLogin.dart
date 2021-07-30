import 'package:ctbeca/env.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode()); //save the keyboard
        //TODO: click botton
      },
      child: Container(
        width:size.width - 100,
        height: 15,
        decoration: BoxDecoration(
          border: Border.all(
            color: colorPrimary, 
            width: 1.0,
          ),
          color: colorPrimary,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(5, 5),
              blurRadius: 10,
            )
          ],
        ),
        child: Center(
          child: AutoSizeText(
            'Ingresar',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontFamily: 'MontserratSemiBold',
            ),
            maxFontSize: 14,
            minFontSize: 14,
          ),
        ),
      ),
    );
  }
}