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

class ChefMainPage extends StatefulWidget {
  @override
  _ChefMainPageState createState() => _ChefMainPageState();
}

class _ChefMainPageState extends State<ChefMainPage>
    with WidgetsBindingObserver {

  List<DishModel> dish = [
    // DishModel("Pizza", "https://media.istockphoto.com/photos/cheesy-pepperoni-pizza-picture-id938742222?k=20&m=938742222&s=612x612&w=0&h=X5AlEERlt4h86X7U7vlGz3bDaDDGQl4C3MuU99u2ZwQ=",
    //     "Italian", "It is dish of Italian origin consisting of a bread dough topped with  olive oil, oregano, tomato, olives, mozzarella .", 10, 20, 3, true, true),
    // DishModel("Dhosa", "https://wallpaperaccess.com/full/6340449.jpg",
    //     "Italian", "A dosa is a thin flat bread originating from South India, made from a fermented batter predominantly consisting of lentils and rice.", 10, 20, 3, false, false),
    // DishModel("Pizza", "https://media.istockphoto.com/photos/cheesy-pepperoni-pizza-picture-id938742222?k=20&m=938742222&s=612x612&w=0&h=X5AlEERlt4h86X7U7vlGz3bDaDDGQl4C3MuU99u2ZwQ=",
    //     "Italian", "It is dish of Italian origin consisting of a bread dough topped with  olive oil, oregano, tomato, olives, mozzarella .", 10, 20, 3, true, true),
    // DishModel("Dhosa", "https://wallpaperaccess.com/full/6340449.jpg",
    //     "Italian", "A dosa is a thin flat bread originating from South India, made from a fermented batter predominantly consisting of lentils and rice.", 10, 20, 3, false, false),
    // DishModel("Pizza", "https://media.istockphoto.com/photos/cheesy-pepperoni-pizza-picture-id938742222?k=20&m=938742222&s=612x612&w=0&h=X5AlEERlt4h86X7U7vlGz3bDaDDGQl4C3MuU99u2ZwQ=",
    //     "Italian", "It is dish of Italian origin consisting of a bread dough topped with  olive oil, oregano, tomato, olives, mozzarella .", 10, 20, 3, true, true),
    // DishModel("Pizza", "https://media.istockphoto.com/photos/cheesy-pepperoni-pizza-picture-id938742222?k=20&m=938742222&s=612x612&w=0&h=X5AlEERlt4h86X7U7vlGz3bDaDDGQl4C3MuU99u2ZwQ=",
    //     "Italian", "It is dish of Italian origin consisting of a bread dough topped with  olive oil, oregano, tomato, olives, mozzarella .", 10, 20, 3, true, true),
  ];

  bool loading = true;
  @override
  void initState() {
    getDishList();
    super.initState();
  }

  getDishList() async {
    List<DishModel> dishdata=[];

    dishdata=await DishRepository().getAllDish();

    setState(() {
      dish.addAll(dishdata);
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
      body: Container(
        child: ChefMainPage(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.secondaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
              const AddDishes()));
        },
      ),
    );
  }

  Widget ChefMainPage() {
    return dish.length != 0
        ? Padding(
            padding: EdgeInsets.only(
                top: Constants.height * 0.03,
                left: Constants.width * 0.05,
                right: Constants.width * 0.05),
            child: Container(
              child: ListView.builder(
                  itemCount: dish.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SwipeActionCell(
                            key: ObjectKey(dish[index]),

                            ///this key is necessary
                            trailingActions: <SwipeAction>[
                              SwipeAction(
                                  title: "delete",
                                  onTap: (CompletionHandler handler) async {
                                    dish.removeAt(index);
                                    setState(() {});
                                  },
                                  color: Colors.red),
                            ],
                            leadingActions: <SwipeAction>[
                              SwipeAction(
                                  title: "Edit",
                                  onTap: (CompletionHandler handler) async {
                                    showSnackBar("Edit "+ dish[index].dishTitle);
                                    setState(() {});
                                  },
                                  color: ColorConstants.primaryColor),
                            ],
                            child: ChefListView(dish[index], index)),
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
