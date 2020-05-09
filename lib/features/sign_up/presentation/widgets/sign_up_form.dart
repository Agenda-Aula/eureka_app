import 'package:app/features/sign_up/presentation/widgets/sign_up_button.dart';
import 'package:app/features/sign_up/presentation/widgets/sign_up_email_passwor_field.dart';
import 'package:app/features/sign_up/presentation/widgets/sign_up_title.dart';
import 'package:flutter/cupertino.dart';

Widget signUpForm(
    {BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: SizedBox(),
        ),
        signUpTitleWidget(context),
        SizedBox(
          height: 50,
        ),
        emailPasswordWidget(
          emailController: emailController,
          passwordController: passwordController,
        ),
        SizedBox(
          height: 20,
        ),
        signUpButton(context),
        Expanded(
          flex: 2,
          child: SizedBox(),
        )
      ],
    ),
  );
}
