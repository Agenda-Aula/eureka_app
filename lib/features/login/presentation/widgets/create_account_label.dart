import 'package:app/features/register/presentation/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountLabel extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
			margin: EdgeInsets.symmetric(vertical: 20),
			alignment: Alignment.bottomCenter,
			child: Row(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					Text(
						'Don\'t have an account ?',
						style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
					),
					SizedBox(
						width: 10,
					),
					InkWell(
						onTap: () {
							Navigator.push(context,
								MaterialPageRoute(builder: (context) => RegisterPage()));
						},
						child: Text(
							'Register',
							style: TextStyle(
								color: Color(0xfff79c4f),
								fontSize: 13,
								fontWeight: FontWeight.w600),
						),
					)
				],
			),
		);
  }
}
