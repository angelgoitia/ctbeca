import 'package:ctbeca/views/login_widgets/buttonLogin.dart';
import 'package:ctbeca/views/login_widgets/formLogin.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>false,
      child: Center(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FormLogin(), //form login
                    ButtonLogin(), //button login //button Register
                  ]
                ),
              ),
            )
          ),
        ),
      )
    );
  }
}