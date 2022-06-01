import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitchen_anywhere/model/OrderModel.dart';
import 'dart:math';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:badges/badges.dart';
import '../../common/constants.dart';
import '../../repository/orderRep.dart';

class FoodieOrderView extends StatefulWidget {
  const FoodieOrderView({Key? key}) : super(key: key);

  @override
  State<FoodieOrderView> createState() => _FoodieOrderViewState();
}

class _FoodieOrderViewState extends State<FoodieOrderView> {
  int _focusedIndex = 0;
  bool loading = true;


  @override
  void initState() {
    super.initState();
    // for (int i = 0; i < 30; i++) {
    //   data.add(Random().nextInt(100) + 1);
    // }
    getOrderList();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ScrollSnapList(
                onItemFocus: _onItemFocus,
                itemBuilder: _buildItemList,
                itemSize: 200,
                // dynamicItemSize: true,
                onReachEnd: () {
                  print('Done!');
                },
                itemCount: Constants.AllOrderList.length,
              ),
            ),
            _buildItemDetail(),
          ],
        ),
      ),
    );
  }

  void _onItemFocus(int index) {
    setState(() {
      _focusedIndex = index;
    });
  }

  Widget _buildItemDetail() {
    if (Constants.AllOrderList.length > _focusedIndex) {
      print("-----------------");
      print(Constants.AllOrderList[_focusedIndex].dishList[0].qty);

      return Container(
        height: 270,
        // child: Text("index $_focusedIndex: ${Constants.AllOrderList[_focusedIndex]}"),
        child: Container(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: Constants.AllOrderList[_focusedIndex].dishList.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Container(
                  decoration: BoxDecoration(color: Color.fromRGBO(238, 238, 238, .9),borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    leading: Container(
                      width: 100,
                      // padding: EdgeInsets.only(right: 12.0),
                      decoration: new BoxDecoration(
                          border: new Border(
                              right: new BorderSide(width: 1.0, color: Colors.white24))),
                      child: ClipRRect(child: Image.network(Constants.AllOrderList[_focusedIndex].dishList[index].dishImageLink,fit: BoxFit.fill,),borderRadius: BorderRadius.circular(15),),
                    ),
                    title: Text(
                      Constants.AllOrderList[_focusedIndex].dishList[index].dishTitle,
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                    subtitle: Column(
                        children:[
                          Row(
                            children: <Widget>[
                              Text(" Qty : ", style: TextStyle(color: Colors.black)),
                              Text(Constants.AllOrderList[_focusedIndex].dishList[index].qty.toString(), style: TextStyle(color: Colors.black))
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(" Price ", style: TextStyle(color: Colors.black)),
                              Text(Constants.AllOrderList[_focusedIndex].dishList[index].price.toString(), style: TextStyle(color: Colors.black))
                            ],
                          ),
                        ]
                    ),
                    trailing: Constants.AllOrderList[_focusedIndex].dishList[index].isVegetarian ?
                    Text("Veg",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),)
                        :
                    Text("Non-Veg",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
                  ),
                ),);
            },
          ),
        ),
      );
    }

    return Container(
      height: 150,
      child: Text("No Data"),
    );
  }

  Widget _buildItemList(BuildContext context, int index) {

    if (index == Constants.AllOrderList.length)
      return Center(
        child: CircularProgressIndicator(),
      );
    return Container(
      // width: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // color: Colors.yellow,
            width: 270,
            height: 320,
            margin: EdgeInsets.only(left: 5,right: 5),
            child: Center(
              child: Container(
                width: 300,
                child: Badge(
                  badgeContent: Text((index + 1).toString(),style: TextStyle(color: Colors.white),),
                  animationType: BadgeAnimationType.scale,
                  badgeColor: Colors.deepPurple,
                  child: Card(
                    elevation: 50,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Constants.AllOrderList[index].orderStatus == "pending" ? Color.fromRGBO(239, 234, 216, 1) : Color.fromRGBO(153, 196, 200, 1),
                    // color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              Text("Order ID# "),
                              Flexible(child: Text(Constants.AllOrderList[index].orderId,style: TextStyle(fontWeight: FontWeight.bold),)),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Text("Foodie# "),
                              Text(Constants.AllOrderList[index].nameOfFoodie,style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Text("Contact No:"),
                              Text(Constants.AllOrderList[index].contactOfFoodie,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Text("Order Date# "),
                              Flexible(child: Text(Constants.AllOrderList[index].orderDate.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Text("Order Status: "),
                              // Image.network("https://cdn.dribbble.com/users/107759/screenshots/2436386/media/9a15f02d7c68adaf9af951c97615076f.gif",width: 100,height: 100,fit: BoxFit.cover,),
                              AnimatedTextKit(
                                repeatForever: true,
                                  animatedTexts: [
                                    ScaleAnimatedText(Constants.AllOrderList[index].orderStatus,textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Constants.AllOrderList[index].orderStatus == "pending" ? Colors.red : Color.fromRGBO(111, 76, 91, 1))),
                                    ScaleAnimatedText(Constants.AllOrderList[index].orderStatus,textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Constants.AllOrderList[index].orderStatus == "pending" ? Colors.red : Color.fromRGBO(111, 76, 91, 1))),
                                    ScaleAnimatedText(Constants.AllOrderList[index].orderStatus,textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Constants.AllOrderList[index].orderStatus == "pending" ? Colors.red : Color.fromRGBO(111, 76, 91, 1))),
                                  ]
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          // OutlinedButton(
                          //   onPressed: () {
                          //     debugPrint(Constants.AllOrderList[index].orderId);
                          //   },
                          //   child: const Text('See Details'),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }


  void getOrderList() async {
    List<OrderModel> orderData = [];
      if(Constants.userdata.isChef)
        {
          print("-------------- chef orders -----------" + Constants.userdata.userID);
          orderData = await OrderRepository().getChefAllDish(Constants.userdata.userID);

          orderData.sort((a, b) => b.orderDate.compareTo(a.orderDate));
        }
      else
        {
          print("-------------- foodie orders -----------");
          orderData = await OrderRepository().getFoodieAllDish(Constants.userdata.userID);
        }

    // dishdata=await DishRepository().getChefAllDish(Constants.userdata.userID);
    Constants.AllOrderList.clear();
    setState(() {
      Constants.AllOrderList.addAll(orderData);
      loading = false;
    });
  }

}



