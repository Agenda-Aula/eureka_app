import 'package:app/features/sign_in/sign_in_page.dart';
import 'package:app/core/widgets/bezierContainer.dart';
import 'package:app/features/sign_up/presentation/widgets/sign_up_account_label.dart';
import 'package:app/features/sign_up/presentation/widgets/sign_up_button.dart';
import 'package:app/features/sign_up/presentation/widgets/sign_up_email_passwor_field.dart';
import 'package:app/features/sign_up/presentation/widgets/sign_up_form.dart';
import 'package:app/features/sign_up/presentation/widgets/sign_up_title.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _pwController = new TextEditingController();

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          signUpForm(
              context: context,
              emailController: _emailController,
              passwordController: _pwController),
          Align(
            alignment: Alignment.bottomCenter,
            child: loginAccountLabelWidget(context),
          ),
          Positioned(top: 40, left: 0, child: _backButton()),
          Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer())
        ],
      ),
    )));
  }
}
