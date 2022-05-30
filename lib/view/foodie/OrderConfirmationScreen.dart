

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitchen_anywhere/view/foodie/foodieMainScreen.dart';
import 'package:lottie/lottie.dart';

import '../../common/buttonStyle.dart';
import '../../common/colorConstants.dart';
import '../../common/constants.dart';


class OrderConfirmation extends StatefulWidget {
  const OrderConfirmation({Key? key}) : super(key: key);

  @override
  State<OrderConfirmation> createState() => _OrderConfirmationState();
}
class _OrderConfirmationState extends State<OrderConfirmation> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: null,
        body: Align(
            alignment: Alignment.topCenter,
            child:SafeArea(
              child:Container(
                  child: Column(
                    children: [
                      Lottie.asset('assets/images/thankyou_animation.json',
                        width: 500,
                        height: 500),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                            "Your order is being prepared, pick up after 30 minutes.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                        ),
                      ),
                      SizedBox(height: 20),
                      centerButton(Constants.height/20,Constants.width*0.50,Constants.width*0.08,ColorConstants.secondaryColor,ColorConstants.whiteColor,"Back to Home",
                              () => {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        FoodieMainPage()))
                              },context),
                    ],
                  ),
                )
            )
        )
    );
  }
}