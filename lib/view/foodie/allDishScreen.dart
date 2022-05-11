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

class AllDishViewPage extends StatefulWidget {

  @override
  _AllDishViewPageState createState() => _AllDishViewPageState();
}

class _AllDishViewPageState extends State<AllDishViewPage>
    with WidgetsBindingObserver {

  bool loading = true;

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
      // currentIndex == 0 ?
      Container(
        child: AllDishViewPage(),
      )
      // : Container(
      //   child: AllDishViewPage(),
      // )
      ,

    );
  }



  Widget AllDishViewPage() {
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

                            child: AllDish(Constants.dish[index], index)),
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

  Widget AllDish(DishModel dishModel, int index) {
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
                                      for(int i=0;i<dishModel.start;i++)
                                      Image.asset('assets/images/star.png',width: Constants.width*0.03,),
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: Constants.width*0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      dishModel.qty++;
                                    });
                                  },
                                  child: Container(
                                    height:30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: ColorConstants.primaryColor,
                                        shape: BoxShape.circle
                                    ),
                                    child: Center(child: Text('+',style: CustomTextStyle.regularText(20, Constants.width)
                                        .apply(color: ColorConstants.whiteColor))),
                                  ),
                                )
                                ,
                                Container(
                                  child: Center(child: Text(dishModel.qty.toString())),
                                ),
                                InkWell(
                                  onTap: (){
                                    if(dishModel.qty>0)
                                    {
                                      setState(() {
                                        dishModel.qty--;
                                      });

                                    }
                                  },
                                  child: Container(
                                    height:30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: ColorConstants.primaryColor,
                                        shape: BoxShape.circle
                                    ),
                                    child: Center(child: Text('-',style: CustomTextStyle.regularText(20, Constants.width)
                                        .apply(color: ColorConstants.whiteColor),)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
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
                        SizedBox(height: 5,),
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
