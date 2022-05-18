import 'dart:math';

import 'package:badges/badges.dart';
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
import 'package:kitchen_anywhere/view/foodie/cartScreen.dart';
import 'package:kitchen_anywhere/view/foodie/foodieProfileScreen.dart';
import 'package:kitchen_anywhere/view/foodie/foodieSettingScreen.dart';
import 'package:kitchen_anywhere/view/foodie/viewDishDetails.dart';
import 'package:kitchen_anywhere/widget/BottomBar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'allDishScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FoodieMainPage extends StatefulWidget {
  @override
  _FoodieMainPageState createState() => _FoodieMainPageState();
}

class _FoodieMainPageState extends State<FoodieMainPage>
    with WidgetsBindingObserver {
  late int currentIndex;
  bool loading = true;
  int _current = 0;
  final List<String> imgList = [
    'https://www.wingsworldcuisine.ie/wp-content/uploads/2022/02/W2_Offer-Early-Bird-Offer-01012022.jpg',
    'https://www.wingsworldcuisine.ie/wp-content/uploads/2021/11/Wings-dubling-student-offer_19112021.jpg',
    'https://www.wingsworldcuisine.ie/wp-content/uploads/2021/11/Wings-dubling-student-offer_19112021.jpg'
    ];
  final CarouselController _controller = CarouselController();

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
    List<DishModel> dishdata = [];

    dishdata = await DishRepository().getAllDish();
    Constants.dish.clear();
    setState(() {
      Constants.dish.addAll(dishdata);
      loading = false;
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
        actions: [        Padding(
            padding: const EdgeInsets.only(top: 5, right: 20, left: 5),
            child: Container(
              child: Badge(
                position: BadgePosition.topEnd(top: 0, end: 0),
                badgeColor: Colors.red,
                badgeContent: Text(
                  Constants.cartList.length.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.shoppingBasket,
                    size: 25,
                  ),
                  onPressed: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => CartPage()),
                   ).then((value) {
                     setState(() {

                     });
                   });
                  },
                  color: Colors.white,
                  tooltip: 'Cart',
                ),

              ),
            ))],
      ),
      body: currentIndex == 0 ? Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Container(
              height: Constants.height*0.2,
              width: Constants.width*0.9,
              child: CarouselSlider(
                items: imgList
                    .map((item) => Container(
                  child: Center(
                      child:
                      Image.network(item, fit: BoxFit.cover, width: Constants.width*0.9)),
                ))
                    .toList(),
                carouselController: _controller,
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 1.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                        print(index);
                      });
                    }),
              ),
            ),
          ),
          Expanded(
            child:
            Container(
              child: FoodieMainPage(),
            )

            ,
          ),
        ],
      ) : currentIndex == 1 ? ProfilePage() : currentIndex == 3 ? FoodieSettingScreen() :ProfilePage()
      ,
    );
  }

  Widget BottomBar() {
    return BubbleBottomBar(
      hasNotch: true,
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

  Widget FoodieMainPage() {
    return Constants.dish.length != 0
        ? Column(

          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: Constants.height * 0.03,
                  left: Constants.width * 0.07,
                  right: Constants.width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text('Delicious dish', style: CustomTextStyle.mediumText(20, Constants.width)),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                           AllDishViewPage())).then((value) {
                             setState(() {

                             });
                      });
                    },
                    child: Container(
                      child: Text('View All',style: CustomTextStyle.regularText(12, Constants.width)
                          .apply(color: ColorConstants.primaryColor),),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(
                      top: Constants.height * 0.03,
                      left: Constants.width * 0.05,
                      right: Constants.width * 0.05),
                  child: Container(
                    child: GridView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                        gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 1.12,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                        itemCount: Constants.dish.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return DishView(Constants.dish[index], index);
                        }),
                  ),
                ),
            ),
          ],
        )
        : loading
            ? Center(
                child: CircularProgressIndicator(
                color: ColorConstants.primaryColor,
              ))
            : Center(
                child: Text("No Dish Available",
                    style: CustomTextStyle.mediumText(25, Constants.width)
                        .apply(fontStyle: FontStyle.italic)));
  }

  Widget DishView(DishModel dishModel, int index) {
    var imgDish = NetworkImage(dishModel.dishImageLink);
    int star = Random().nextInt(5);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ViewInDeatils(dish_: dishModel)),
        );
        print("taped");
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.only(right: 2, left: 2),
          decoration: BoxDecoration(
            color: dishModel.isActive
                ? ColorConstants.primaryColor.withOpacity(0.1)
                : Colors.red.withOpacity(0.1),
            shape: BoxShape.rectangle,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:10),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(dishModel.dishTitle,
                      textAlign: TextAlign.start,
                      style: CustomTextStyle.mediumText(15, Constants.width)),
                ),
              ),
              Row(
                children: [
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          dishModel.dishImageLink,
                          height: Constants.height * 0.12,
                          width: Constants.width * 0.17,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/images/background_kitchen.jpg',
                                  height: Constants.height * 0.12,
                                  width: Constants.width * 0.17,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: 10 ,bottom: 10),
                    child: Container(
                      height: Constants.height * 0.12,
                      width: Constants.width * 0.18,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text("\$ "+dishModel.price.toString(),
                                textAlign: TextAlign.start,
                                style: CustomTextStyle.mediumText(15, Constants.width)),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(dishModel.isVegetarian ? "vegetarian " : "Non-Veg.",
                                textAlign: TextAlign.start,
                                style: dishModel.isVegetarian
                                    ? CustomTextStyle.regularText(12, Constants.width)
                                        .apply(color: ColorConstants.primaryColor)
                                    : CustomTextStyle.regularText(12, Constants.width)
                                        .apply(color: Colors.red)),
                          ),
                          Container(
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
                                    height:20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: ColorConstants.primaryColor,
                                        shape: BoxShape.circle
                                    ),
                                    child: Center(child: Text('+',style: CustomTextStyle.regularText(12, Constants.width)
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
                                    height:25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                        color: ColorConstants.primaryColor,
                                        shape: BoxShape.circle
                                    ),
                                    child: Center(child: Text('-',style: CustomTextStyle.regularText(16, Constants.width)
                                        .apply(color: ColorConstants.whiteColor),)),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
