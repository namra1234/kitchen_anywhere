import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitchen_anywhere/common/buttonStyle.dart';
import 'package:kitchen_anywhere/common/colorConstants.dart';
import 'package:kitchen_anywhere/common/constants.dart';
import 'package:kitchen_anywhere/common/textStyle.dart';
import 'package:kitchen_anywhere/model/dishModel.dart';
import 'package:kitchen_anywhere/repository/dishRep.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:kitchen_anywhere/repository/orderRep.dart';
import 'package:kitchen_anywhere/view/foodie/OrderConfirmationScreen.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../model/OrderModel.dart';

class CartPage extends StatefulWidget {

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with WidgetsBindingObserver
{

  bool loading = false;
  double subtotal = 0;
  double tax = 0;
  double total = 0;
  late Razorpay _razorpay;
  @override
  void initState() {
    calculatePrice();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlerPaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlerErrorFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlerExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void calculatePrice()
  {
    subtotal=0;
    Constants.cartList.forEach((element) {
      subtotal += (element.price*element.qty);
    });

    setState(() {
      subtotal = double.parse(((subtotal)).toStringAsFixed(2));
      tax = double.parse(((subtotal)*0.10).toStringAsFixed(2));
      total = double.parse(((tax+subtotal)).toStringAsFixed(2));
    });
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
        child: CartPage(),
      )
      // : Container(
      //   child: CartPage(),
      // )
      ,

    );
  }

void checkout()
{

  var options = {
    'key': 'rzp_test_5Pxl7JMkLPQDPZ',
    'amount':  (total*100).round(),
    'name': 'Kitchen Anywhere',
    'description': 'Payment for Kitchen App',
    'currency': 'CAD',
    'prefill': {
      'contact': "" + Constants.userdata.phoneNo,
      'email': Constants.userdata.email,
      'method': 'card'
     },
     'remember_customer':true
  };

  try {
    _razorpay.open(options);
  } catch (e) {
    print("error"+ e.toString());
    debugPrint('Error: e');
  }
}
  void _handlerPaymentSuccess(PaymentSuccessResponse response){
    showSnackBar("Payment successful");
    DateTime now = new DateTime.now();
    Random random = new Random();
    int x = random.nextInt(10000);
    addOrderToFirebase(OrderModel(Constants.cartList[0].id.toString(),Constants.userdata.phoneNo,Constants.cartList,Constants.userdata.fullName,now,Constants.userdata.userID+x.toString(),"pending",Constants.userdata.userID));

  }
  void addOrderToFirebase(OrderModel orderModel){
    List<Map> dishListMap = [];
    orderModel.dishList.forEach((DishModel dish) {
      Map dishMap = dish.toJson();
      dishListMap.add(dishMap);
    });
    setState(() {
      OrderRepository().createOrder({
        'chefId': orderModel.chefId,
        'contactOfFoodie': orderModel.contactOfFoodie,
        'dishList':dishListMap,
        'nameOfFoodie':orderModel.nameOfFoodie,
        'orderDate': orderModel.orderDate,
        'orderId': orderModel.orderId,
        'orderStatus':orderModel.orderStatus,
        'userId': orderModel.userId
      });
      Constants.cartList.clear();
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OrderConfirmation()),
    );
  }
  void _handlerErrorFailure(PaymentFailureResponse response){
    print(response.message);
    showSnackBar("Payment error");
  }
  void _handlerExternalWallet(ExternalWalletResponse response){
    showSnackBar("External Wallet");
  }
  Widget CartPage() {
    return Constants.cartList.length != 0
        ? Padding(
            padding: EdgeInsets.only(
                top: Constants.height * 0.01,
                left: Constants.width * 0.05,
                right: Constants.width * 0.05),
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Products in Your Cart",
                              textAlign: TextAlign.start,
                              style: CustomTextStyle.mediumText(15, Constants.width),),
                          Text(Constants.cartList.length.toString()+" items",
                              textAlign: TextAlign.start,
                              style: CustomTextStyle.regularText(15, Constants.width).apply(color: ColorConstants.blackColor)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: Constants.cartList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SwipeActionCell(
                                  key: ObjectKey(Constants.cartList[index]),

                                  child: AllDish(Constants.cartList[index], index)),
                              SizedBox(height: 15,)
                            ],
                          );
                        }),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 10,right: 10,top: 10),
                    child: Container(

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("SubTotal",
                            textAlign: TextAlign.start,
                            style: CustomTextStyle.mediumText(15, Constants.width),),
                          Text("\$ "+subtotal.toString(),
                              textAlign: TextAlign.start,
                              style: CustomTextStyle.regularText(15, Constants.width).apply(color: ColorConstants.blackColor)),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 10,right: 10,top: 5),
                    child: Container(

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tax",
                            textAlign: TextAlign.start,
                            style: CustomTextStyle.mediumText(15, Constants.width),),
                          Text("\$ "+tax.toString(),
                              textAlign: TextAlign.start,
                              style: CustomTextStyle.regularText(15, Constants.width).apply(color: ColorConstants.blackColor)),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 10,right: 10,top: 5),
                    child: Container(

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total",
                            textAlign: TextAlign.start,
                            style: CustomTextStyle.mediumText(25, Constants.width),),
                          Text("\$ "+total.toString(),
                              textAlign: TextAlign.start,
                              style: CustomTextStyle.regularText(25, Constants.width).apply(color: ColorConstants.blackColor)),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: centerButton(Constants.height/17,Constants.width*0.80,Constants.width*0.06,ColorConstants.secondaryColor,ColorConstants.whiteColor,"ChekOut",checkout,context),
                  ),

                ],
              ),
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
                                  InkWell(
                                      onTap: (){
                                        setState(() {
                                          Constants.cartList.remove(dishModel);
                                          calculatePrice();

                                            if(Constants.cartList.length==0)
                                            {
                                              loading = false;
                                            }

                                        });
                                      },
                                      child: Container(child:Icon(Icons.cancel_outlined,color: ColorConstants.primaryColor,)))
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                                          calculatePrice();
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
                                    ),
                                    Container(
                                      child: Center(child: Text(dishModel.qty.toString())),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        if(dishModel.qty>1)
                                        {
                                          setState(() {
                                            dishModel.qty--;
                                            calculatePrice();
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
                            Text("\$ "+dishModel.price.toString(),
                                textAlign: TextAlign.start,
                                style: CustomTextStyle.regularText(15, Constants.width)),
                          ],
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
