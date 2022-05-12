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
import 'package:kitchen_anywhere/view/chef/chefProfileScreen.dart';
import 'package:kitchen_anywhere/view/chef/chefSettingScreen.dart';
import 'package:kitchen_anywhere/widget/BottomBar.dart';

import '../foodie/viewDishDetails.dart';

class ChefMainPage extends StatefulWidget {

  @override
  _ChefMainPageState createState() => _ChefMainPageState();
}

class _ChefMainPageState extends State<ChefMainPage>
    with WidgetsBindingObserver {

  int currentIndex=0;
  bool loading = true;

  @override
  void initState() {
    currentIndex = 0;
    getDishList();
    super.initState();
  }

   changePage(int? index) {
    setState(() {
      currentIndex = index!;
    });
  }

  getDishList() async {
    List<DishModel> dishdata=[];

    dishdata=await DishRepository().getAllDish();
    // dishdata=await DishRepository().getChefAllDish(Constants.userdata.userID);
    Constants.dish.clear();
    setState(() {
      Constants.dish.addAll(dishdata);
      loading=false;
    });
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.secondaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  AddDishes())).then((value) => {

            getDishList()
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomBar(),
      appBar: AppBar(
        backgroundColor: ColorConstants.secondaryColor,
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text("Kitchen Anywhere"),
            )
          ],
        ),
        elevation: 0.0,
        centerTitle: false,
      ),
      body:
      currentIndex == 0 ?
      Container(
        child: ChefMainPage(),
      ):
      currentIndex == 1 ?
      ChefProfilePage() : currentIndex == 3 ? ChefSettingScreen() : ViewInDeatils()
      ,

    );
  }

  Widget BottomBar()
  {
    return BubbleBottomBar(
      hasNotch: true,
      fabLocation: BubbleBottomBarFabLocation.end,
      opacity: .2,
      currentIndex: currentIndex,
      onTap: changePage,
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

  Widget ChefMainPage() {
    return Constants.dish.length != 0
        ? Padding(
            padding: EdgeInsets.only(
                top: Constants.height * 0.03,
                left: Constants.width * 0.05,
                right: Constants.width * 0.05),
            child: Container(
              child: ListView.builder(
                  itemCount: Constants.dish.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SwipeActionCell(
                            key: ObjectKey(Constants.dish[index]),

                            ///this key is necessary
                            trailingActions: <SwipeAction>[
                              SwipeAction(
                                  title: "delete",
                                  onTap: (CompletionHandler handler) async {
                                    Constants.dish.removeAt(index);
                                    setState(() {});
                                  },
                                  color: Colors.red),
                            ],
                            leadingActions: <SwipeAction>[
                              SwipeAction(
                                  title: "Edit",
                                  onTap: (CompletionHandler handler) async {
                                    showSnackBar("Edit "+ Constants.dish[index].dishTitle);
                                    setState(() {});
                                  },
                                  color: ColorConstants.primaryColor),
                            ],
                            child: ChefListView(Constants.dish[index], index)),
                        SizedBox(height: 15,)
                      ],
                    );
                  }),
            ),
          )
        : loading
            ? Center(
                child: CircularProgressIndicator(
                color: ColorConstants.primaryColor,
              ))
            : Center(
                child: Text("Please Add Dish",
                    style: CustomTextStyle.mediumText(25, Constants.width)
                        .apply(fontStyle: FontStyle.italic)));
  }

  Widget ChefListView(DishModel dishModel, int index) {
    var imgDish = NetworkImage(dishModel.dishImageLink);
    int star = Random().nextInt(5);
    return GestureDetector(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.only(right:2,left: 2),
          decoration: BoxDecoration(
            color: dishModel.isActive ? ColorConstants.primaryColor.withOpacity(0.1) : Colors.red.withOpacity(0.1),
            shape: BoxShape.rectangle,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    child: Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          dishModel.dishImageLink,
                          height: Constants.height * 0.12,
                          width: Constants.width * 0.17,
                          fit:BoxFit.fill,
                          errorBuilder: (context,error,stackTrace)
                          {
                          return Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset('assets/images/background_kitchen.jpg',
                                  height: Constants.height * 0.12,
                                    width: Constants.width * 0.17,
                                fit:BoxFit.fill,),
                            ),
                          );
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right:20,top:20),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(dishModel.dishTitle,
                                      textAlign: TextAlign.start,
                                      style: CustomTextStyle.mediumText(20, Constants.width)
                                  ),
                                  Container(child:
                                  Row(
                                    children: [
                                      for(int i=0;i<star;i++)
                                      Image.asset('assets/images/star.png',width: Constants.width*0.03,),
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right:20),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(dishModel.isVegetarian ? "Vegetarian " : "Non-Veg.",
                                      textAlign: TextAlign.start,
                                       style: dishModel.isVegetarian ? CustomTextStyle.regularText(15, Constants.width).apply(color: ColorConstants.primaryColor):CustomTextStyle.regularText(15, Constants.width).apply(color: Colors.red)),
                                  Text(dishModel.typeOfDish,
                                      textAlign: TextAlign.start,
                                      style: CustomTextStyle.regularText(15, Constants.width).apply(color: ColorConstants.blackColor)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom:20),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Expanded(
                              child: Text(dishModel.description,
                                   textAlign: TextAlign.start,
                                   style: CustomTextStyle.regularText(15, Constants.width)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
