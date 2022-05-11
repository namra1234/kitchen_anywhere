import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitchen_anywhere/common/colorConstants.dart';
import 'package:kitchen_anywhere/common/constants.dart';
import 'package:kitchen_anywhere/common/textStyle.dart';
import 'package:kitchen_anywhere/model/dishModel.dart';
import 'package:kitchen_anywhere/repository/dishRep.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:kitchen_anywhere/view/authentication/login.dart';
import 'package:kitchen_anywhere/view/chef/addDishes.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:kitchen_anywhere/widget/BottomBar.dart';

import '../../common/buttonStyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChefSettingScreen extends StatefulWidget {
  @override
  _ChefSettingScreenState createState() => _ChefSettingScreenState();
}

class _ChefSettingScreenState extends State<ChefSettingScreen> with WidgetsBindingObserver {


  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:
            // currentIndex == 0 ?
            Container(
          child: ChefSettingScreen(),
        ));
  }

  Widget ChefSettingScreen()
  {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          InkWell(
            onTap: () async {
              SharedPreferences preferences = await SharedPreferences.getInstance();
              await preferences.clear();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  LoginScreen()), (Route<dynamic> route) => false);
            },
            child: Container(
              height: 50,
              color: Colors.green[100],
              child:  Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.logout),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Sign Out'),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
