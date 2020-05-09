import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget signUpButton(BuildContext context) {
  return RaisedButton(
    onPressed: () {},
    textColor: Colors.white,
    padding: const EdgeInsets.all(0.0),
    child: Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color(0xfffbb448),
            Color(0xfff7892b),
          ],
        ),
      ),
      padding: const EdgeInsets.all(10.0),
      child: const Text(
        'Register now',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    ),
  );
}
