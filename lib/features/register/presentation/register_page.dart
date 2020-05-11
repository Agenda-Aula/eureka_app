import 'package:app/core/widgets/bezierContainer.dart';
import 'package:app/features/sign_up/presentation/bloc/bloc.dart';
import 'package:app/features/sign_up/presentation/bloc/register_bloc.dart';
import 'package:app/features/sign_up/presentation/widgets/register_account_label.dart';
import 'package:app/features/sign_up/presentation/widgets/register_back_button.dart';
import 'package:app/features/sign_up/presentation/widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection_container.dart';
import 'bloc/register_bloc.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<RegisterBloc>(
      create: (BuildContext context) => sl<RegisterBloc>(),
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              RegisterForm(),
              Align(
                alignment: Alignment.bottomCenter,
                child: loginAccountLabelWidget(context),
              ),
              Positioned(
                top: 40,
                left: 0,
                child: backButtonWidget(context),
              ),
              Positioned(
                top: -MediaQuery.of(context).size.height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: BezierContainer(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
