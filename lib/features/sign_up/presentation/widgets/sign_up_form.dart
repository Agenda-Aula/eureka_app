import 'package:app/features/sign_up/presentation/bloc/sign_up_page_bloc.dart';
import 'package:app/features/sign_up/presentation/models/credential.dart';
import 'package:app/features/sign_up/presentation/widgets/sign_up_button.dart';
import 'package:app/features/sign_up/presentation/widgets/sign_up_email_passwor_field.dart';
import 'package:app/features/sign_up/presentation/widgets/sign_up_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpForm extends StatefulWidget {
  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  SignUpBloc _signUpBloc;

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    _signUpBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            emailController: _emailController,
            passwordController: _pwController,
          ),
          SizedBox(
            height: 20,
          ),
          SignUpButton(
            text: "Register now",
            onPressed: () {
              _signUpBloc.add(
                SignUpUser(
                  credential: Credential(
                    _emailController.text,
                    _pwController.text,
                  ),
                ),
              );
            },
          ),
          Expanded(
            flex: 2,
            child: SizedBox(),
          )
        ],
      ),
    );
  }
}
