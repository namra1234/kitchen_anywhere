import 'package:flutter/material.dart';
import 'package:kitchen_anywhere/common/colorConstants.dart';
import 'package:material_color_gen/material_color_gen.dart';

import 'common/route_generator.dart';
import 'view/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Color theamecolor=ColorConstants.secondaryColor;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        primaryColor: theamecolor,
        primarySwatch: theamecolor.toMaterialColor(),
        textSelectionTheme: TextSelectionThemeData(
            cursorColor: theamecolor
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}