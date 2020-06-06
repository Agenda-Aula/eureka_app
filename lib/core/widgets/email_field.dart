import 'package:app/features/sign_up/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';

Widget entryEmail(TextEditingController emailController, RegisterState state) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Email",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            validator: (_) {
              return !state.isEmailValid ? 'Invalid Email' : null;
            },
            autovalidate: true,
            autocorrect: false,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true))
      ],
    ),
  );
}
