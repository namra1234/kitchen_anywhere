import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitchen_anywhere/common/colorConstants.dart';
import 'package:kitchen_anywhere/common/constants.dart';
import 'package:kitchen_anywhere/common/textStyle.dart';
import 'package:kitchen_anywhere/model/dishModel.dart';
import 'package:kitchen_anywhere/repository/dishRep.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:kitchen_anywhere/view/chef/addDishes.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:kitchen_anywhere/widget/BottomBar.dart';

import '../../common/buttonStyle.dart';
import '../../model/userModel.dart';
import '../../repository/userRep.dart';

class ChefProfilePage extends StatefulWidget {
  @override
  _ChefProfilePageState createState() => _ChefProfilePageState();
}

class _ChefProfilePageState extends State<ChefProfilePage> with WidgetsBindingObserver {
  bool loading = true;
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController postal_code = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  String userType = "";

  @override
  void initState() {
    fullName.text=Constants.userdata.fullName;
    email.text=Constants.userdata.email;
    address.text=Constants.userdata.address;
    postal_code.text=Constants.userdata.postal_code;
    phoneNo.text=Constants.userdata.phoneNo;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void save()
  {
    UserModel userModel = UserModel(Constants.userdata.userID, Constants.userdata.email, fullName.text, address.text, postal_code.text, phoneNo.text, Constants.userdata.isChef);
    UserRepository().updateUser(userModel,Constants.userdata.userID);
    showSnackBar("Profile Updated Successfully.");
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
            SingleChildScrollView(
              child: Container(
          child: ChefProfilePage(),
        ),
            ));
  }

  Widget ChefProfilePage() {
    return Padding(
      padding: EdgeInsets.only(
          top: Constants.height * 0.03,
          left: Constants.width * 0.1,
          right: Constants.width * 0.1),
      child: Column(
        children: [
          GestureDetector(
              // onTap: () => imagePicker.showDialog(context),
              child: new Center(
                  child: Container(
                      height: Constants.width * 0.3,
                      width: Constants.width * 0.3,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage('assets/images/human.jpg')))))),
          Container(
            child: TextField(
              controller: fullName,
              decoration: InputDecoration(
                fillColor: Colors.green,
                disabledBorder: OutlineInputBorder(),
                labelText: 'Your Name',
              ),
            ),
          ),
          Container(
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                fillColor: Colors.green,
                disabledBorder: OutlineInputBorder(),
                labelText: 'Your Email',
              ),
            ),
          ),
          Container(
            child: TextField(
              controller: address,
              decoration: InputDecoration(
                fillColor: Colors.green,
                disabledBorder: OutlineInputBorder(),
                labelText: 'Your Address',
              ),
            ),
          ),
          Container(
            child: TextField(
              controller: postal_code,
              decoration: InputDecoration(
                fillColor: Colors.green,
                disabledBorder: OutlineInputBorder(),
                labelText: 'Your Postal Code',
              ),
            ),
          ),
          Container(
            child: TextField(
              controller: phoneNo,
              decoration: InputDecoration(
                fillColor: Colors.green,
                disabledBorder: OutlineInputBorder(),
                labelText: 'Your Phone Number',
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Container(
                  child: Text(" User Type :  ",style: CustomTextStyle.mediumText(15, Constants.width))
                ),
                Container(
                    child: Text(" Chef")
                )
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(top: 50),
            child: centerButton(
                Constants.height / 17,
                Constants.width * 0.50,
                Constants.width * 0.10,
                ColorConstants.secondaryColor,
                ColorConstants.whiteColor,
                "Save",
                save,
                context),
          ),
        ],
      ),
    );
  }
}
