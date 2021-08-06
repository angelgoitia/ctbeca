import 'package:ctbeca/env.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Navbar extends StatefulWidget {
  Navbar({Key? key}) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => launch("http://$url"),
          child: Padding(
            padding: EdgeInsets.only(top: 35, left: 30),
            child: Container(
              child: Image(
                image: AssetImage("assets/logo/logo.png"),
                width: size.width/3.5,
              ),
            )
          )
        ),
        Padding(
          padding: EdgeInsets.only(top:30, right:20),
          child: IconButton(
            iconSize: size.width / 10,
            icon: ImageIcon(
              AssetImage('assets/icons/salir.png',),
              size: size.width/16,
            ),
            onPressed: () {
              
                //exit();
            }
          )
        ),
      ],
    );
  }
}