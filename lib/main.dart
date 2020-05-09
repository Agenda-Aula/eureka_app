import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'features/welcome_page.dart';
import 'features/injection_container.dart' as di;

void main()async {
	await di.init();
	runApp(MyApp());
}

class MyApp extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
		final textTheme = Theme.of(context).textTheme;
		return MaterialApp(
			title: 'Flutter Demo',
			theme: ThemeData(
				primarySwatch: Colors.blue,
				textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
					body1: GoogleFonts.montserrat(textStyle: textTheme.body1),
				),
			),
			debugShowCheckedModeBanner: false,
			home: WelcomePage(),
		);
	}
}
