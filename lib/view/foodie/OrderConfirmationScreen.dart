

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderConfirmation extends StatefulWidget {
  const OrderConfirmation({Key? key}) : super(key: key);

  @override
  State<OrderConfirmation> createState() => _OrderConfirmationState();
}
class _OrderConfirmationState extends State<OrderConfirmation> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: Align(
            alignment: Alignment.topCenter,
            child:SafeArea(
              child:Container(
                  child: Column(
                    children: [
                      Text(
                          "Thank You!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24
                          ),
                      ),
                    ],
                  ),
                )
            )
        )
    );
  }
}