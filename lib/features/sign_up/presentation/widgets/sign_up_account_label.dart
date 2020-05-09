import 'package:app/features/sign_in/sign_in_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget loginAccountLabelWidget(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 20),
    alignment: Alignment.bottomCenter,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Already have an account ?',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignInPage()));
          },
          child: Text(
            'Login',
            style: TextStyle(
                color: Color(0xfff79c4f),
                fontSize: 13,
                fontWeight: FontWeight.w600),
          ),
        )
      ],
    ),
  );
}
