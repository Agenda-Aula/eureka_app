import 'package:app/core/widgets/bezierContainer.dart';
import 'package:app/features/login/presentation/widgets/barrier.dart';
import 'package:app/features/login/presentation/widgets/create_account_label.dart';
import 'package:app/features/login/presentation/widgets/google_sign_in_button.dart';
import 'package:app/features/login/presentation/widgets/logo_name_label.dart';
import 'package:app/features/login/presentation/widgets/submit_button.dart';
import 'package:flutter/material.dart';


class SignInPage extends StatefulWidget {
  SignInPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: SizedBox(),
                ),
                LogoNameLabel(),
                SizedBox(
                  height: 50,
                ),
							//	entryEmail(_emailController, state),
							//	entryPassword(_pwController, state),
                SizedBox(
                  height: 20,
                ),
                SubmitButton(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.centerRight,
                  child: Text('Forgot Password ?',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                ),
                Barrier(),
                GoogleSignInButton(),
                Expanded(
                  flex: 2,
                  child: SizedBox(),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AccountLabel(),
          ),
          Positioned(top: 40, left: 0, child: BackButton()),
          Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer())
        ],
      ),
    )));
  }
}
