import 'package:app/core/widgets/bezierContainer.dart';
import 'package:app/features/sign_up/presentation/bloc/sign_up_page_bloc.dart';
import 'package:app/features/sign_up/presentation/widgets/sign_up_account_label.dart';
import 'package:app/features/sign_up/presentation/widgets/sign_up_back_button.dart';
import 'package:app/features/sign_up/presentation/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snack/snack.dart';

import '../../injection_container.dart';

class SignUpPage extends StatelessWidget {
  SnackBar _snackBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (BuildContext context) => sl<SignUpBloc>(),
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              BlocBuilder<SignUpBloc, SignUpState>(
                builder: (context, state) {
                  return _stateView(state, context);
                },
              ),
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

  Widget _stateView(SignUpState signUpState, BuildContext context) {
    if (signUpState is Loading) {
      return Container();
    } else if (signUpState is Loaded) {
      return Container(
        child: Text('Carregado e criado - '),
      );
    }
    return SignUpForm();
  }
}
