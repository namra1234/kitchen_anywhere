import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

import '../common/colorConstants.dart';

Widget BottomBar(dynamic pressEvent(int) , int currentIndex)
{
  return BubbleBottomBar(
    hasNotch: true,
    fabLocation: BubbleBottomBarFabLocation.end,
    opacity: .2,
    currentIndex: currentIndex,
    // onTap: pressEvent,
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(16),
    ), //border radius doesn't work when the notch is enabled.
    elevation: 8,
    tilesPadding: EdgeInsets.symmetric(
      vertical: 8.0,
    ),
    items: <BubbleBottomBarItem>[
      BubbleBottomBarItem(
        backgroundColor: Colors.green,
        icon: Icon(
          Icons.food_bank_outlined,
          color: ColorConstants.primaryColor,
        ),
        activeIcon: Icon(
          Icons.food_bank_outlined,
          color: ColorConstants.primaryColor,
        ),
        title: Text("All Dish"),
      ),
      BubbleBottomBarItem(
          backgroundColor: Colors.green,
          icon: Icon(
            Icons.person,
            color: ColorConstants.primaryColor,
          ),
          activeIcon: Icon(
            Icons.person,
            color: ColorConstants.primaryColor,
          ),
          title: Text("Profile")),
      BubbleBottomBarItem(
          backgroundColor: Colors.green,
          icon: Icon(
            Icons.food_bank_outlined,
            color: ColorConstants.primaryColor,
          ),
          activeIcon: Icon(
            Icons.food_bank_outlined,
            color: ColorConstants.primaryColor,
          ),
          title: Text("Orders")),
      BubbleBottomBarItem(
          backgroundColor: Colors.green,
          icon: Icon(
            Icons.settings,
            color: ColorConstants.primaryColor,
          ),
          activeIcon: Icon(
            Icons.settings,
            color: ColorConstants.primaryColor,
          ),
          title: Text("Settings"))
    ],
  );
}