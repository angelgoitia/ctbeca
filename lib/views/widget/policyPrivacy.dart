
import 'package:ctbeca/views/widget/policyPrivacyWidget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PolicyPrivacy extends StatelessWidget {
  const PolicyPrivacy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
      child: Center(
        child: RichText(
          text: TextSpan(
            text: 'Al hacer clic en la opción de ingresar, aceptas la ',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'MontserratSemiBold',
            ),
            children: <TextSpan>[
              TextSpan(text: ' Privacidad ',
                style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'MontserratSemiBold',
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline
                ),
                recognizer: TapGestureRecognizer()
                ..onTap = () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return PolicyPrivacyWidget(
                        mdFileName: 'policyPrivacy.md',
                      );
                    },
                  );
                }
              ),
              TextSpan(
                text: 'de CTBeca.',
                style: TextStyle(
                  fontFamily: 'MontserratSemiBold',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}