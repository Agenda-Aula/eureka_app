import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  SignUpButton({@required this.onPressed, @required this.text});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: this.onPressed,
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
        child: Text(
          this.text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
