import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitchen_anywhere/common/route_generator.dart';
import 'package:kitchen_anywhere/model/userModel.dart';
import 'package:kitchen_anywhere/view/chef/chefMainScreen.dart';
import '../common/buttonStyle.dart';
import '../common/colorConstants.dart';
import '../common/constants.dart';
import '../common/textStyle.dart';
import '../common/util.dart';
import 'authentication/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'foodie/foodieMainScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    moveToNextScreen();
  }

  void moveToNextScreen() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var loginStatus = prefs.getBool('isLoggedin');

    if (loginStatus == null) loginStatus = false;
    try{
      if (loginStatus) {
        Constants.myName = prefs.getString('fullName')!;
        Constants.myEmail = prefs.getString('email')!;
        Constants.loggedInUserID = prefs.getString('userID')!;
        String fullName=prefs.getString('fullName')!;
        String email=prefs.getString('email')!;
        String address=prefs.getString('address')!;
        String phoneNo=prefs.getString('phoneNo')!;
        String postal_code=prefs.getString('postal_code')!;
        String userID=prefs.getString('userID')!;
        bool isChef = prefs.getBool('isChef')!;

        Constants.userdata = UserModel(userID,email,fullName,address,postal_code,phoneNo,isChef);
        var _duartion = new Duration(
          seconds: Constants.SPLASH_SCREEN_TIME,
        );
        Timer(_duartion, () async {

          if(Constants.userdata.isChef)
          {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                ChefMainPage()), (Route<dynamic> route) => false);
          }
          else
          {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                FoodieMainPage()), (Route<dynamic> route) => false);
          }
        });
      }
      else
      {
        var _duartion = new Duration(
          seconds: Constants.SPLASH_SCREEN_TIME,
        );
        Timer(_duartion, () async {

          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              LoginScreen()), (Route<dynamic> route) => false);
        });
      }
    }
    catch(e)
    {
      var _duartion = new Duration(
        seconds: Constants.SPLASH_SCREEN_TIME,
      );
      Timer(_duartion, () async {

        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            LoginScreen()), (Route<dynamic> route) => false);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    Constants.height = MediaQuery.of(context).size.height;
    Constants.width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      body: SafeArea(
        child: Stack(
          children: [
            Opacity(
          opacity: 0.2,
              child: Container(
                height: Constants.height,
                child: Image.asset('assets/images/background_kitchen.jpg',fit: BoxFit.fill,colorBlendMode: BlendMode.lighten

                  ,),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top:Constants.height/14),
                  child: Center(
                    child: SizedBox(
                      height: Constants.height/2,
                      child: Image.asset('assets/images/splashMainLogo.png'),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    child: Text('Welcome!',style: CustomTextStyle.splashWelcome(36, Constants.height, Constants.width,ColorConstants.secondaryColor)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:Constants.height/10),
                  child: Center(
                    child: centerButton(Constants.height/10,Constants.width*0.50,Constants.width*0.10,ColorConstants.secondaryColor,ColorConstants.whiteColor,"Lets start!",letsStart,context),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  letsStart()
  {
    print('welcome');

  }
}
