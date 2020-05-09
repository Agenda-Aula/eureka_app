import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget emailPasswordWidget(
    {TextEditingController emailController,
    TextEditingController passwordController}) {
  return Column(
    children: <Widget>[
      _entryEmail("Email", emailController),
      _entryPassword("Password", passwordController),
    ],
  );
}

Widget _entryPassword(String title, TextEditingController passwordController) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true))
      ],
    ),
  );
}

Widget _entryEmail(String title, TextEditingController emailController) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
            controller: emailController,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true))
      ],
    ),
  );
}
