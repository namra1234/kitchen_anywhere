import 'package:flutter/material.dart';
import 'package:kitchen_anywhere/common/buttonStyle.dart';
import 'package:kitchen_anywhere/common/colorConstants.dart';
import 'package:kitchen_anywhere/view/chef/chefMainScreen.dart';
import '../../common/TrioBorder.dart';
import '../../common/constants.dart';
import 'package:kitchen_anywhere/model/userModel.dart';
import 'package:kitchen_anywhere/repository/userRep.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/dishModel.dart';

class AddDishes extends StatefulWidget {
  const AddDishes({Key? key}) : super(key: key);

  @override
  _AddDishesState createState() => _AddDishesState();
}

class _AddDishesState extends State<AddDishes> {

  late TextEditingController dishTitleController,
      priceController,
      cusineController,
      numberOfDishes,
      description,
      dishImageLinkController;
  Diet? _diet = Diet.Vegetarian;
  Status? _status = Status.Active;

  String dishImageLink = "https://e1.pngegg.com/pngimages/621/910/png-clipart-food-2-food-thumbnail.png";

  late DishModel _dishModel;

  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();


  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ),);
  }

  @override
  void initState() {
    super.initState();

    dishTitleController = TextEditingController();
    priceController = TextEditingController();
    cusineController = TextEditingController();
    numberOfDishes = TextEditingController();
    description = TextEditingController();
    dishImageLinkController = TextEditingController();
  }

  void submitData(){
    setState(() {
      _dishModel = new DishModel(dishTitleController.text, dishImageLink, cusineController.text, description.text, int.parse(priceController.text), int.parse(numberOfDishes.text),int.parse(numberOfDishes.text), _diet == Diet.Vegetarian? true : false , _status == Status.Active ? true : false);
    });

  }

  @override
  void dispose() {
    super.dispose();

    // emailController.dispose();
    // passwordController.dispose();
  }

  imageBrowser() {
    print("Choose images");
  }



  @override
  Widget build(BuildContext context) {
    Constants.height = MediaQuery
        .of(context)
        .size
        .height;
    Constants.width = MediaQuery
        .of(context)
        .size
        .width;


    Widget mainTitle = Container(
      padding: EdgeInsets.only(top: 30, left: 30, right: 30),
      child: const Text("Make Dishes",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
            color: ColorConstants.customLightGreenColor
        ),
      ),
    );

    Widget subTitle = Container(
      padding: EdgeInsets.all(5),
      child: const Text("Reveal your spécialité",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 25,
            color: ColorConstants.greyColor
        ),
      ),
    );

    Widget dishtitleTextBox = Container(
      // decoration: TrioBorder(Colors.red),
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: TextFormField(
        controller: dishTitleController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelStyle:
          TextStyle(color: Colors.black),
          hintText: "Dish Title",
          labelText: "Dish Title",
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Field can not be empty";
          }

          return null;
        },
      ),
    );

    Widget imageUpload = Container(
      // decoration: TrioBorder(Colors.red),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            // padding: EdgeInsets.all(1),
            child: Image.asset('assets/images/fastfood.png', fit: BoxFit.fill,
              colorBlendMode: BlendMode.lighten,
              height: 100,
              width: 100,),
          ),
          Container(
            // padding: EdgeInsets.all(10),
              child: centerButton(
                  Constants.height / 20,
                  Constants.width * 0.35,
                  Constants.width * 0.12,
                  ColorConstants.secondaryColor,
                  ColorConstants.whiteColor,
                  "Browse Image",
                  imageBrowser,
                  context)
          )
        ],
      ),
    );

//-------------------

    Widget priceTextBox = Container(
      // decoration: TrioBorder(Colors.red),
      padding: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
      child: TextFormField(
        controller: priceController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelStyle:
          TextStyle(color: Colors.black),
          hintText: "Price",
          labelText: "Price per Dish",
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Field can not be empty";
          }

          return null;
        },
      ),
    );

    Widget dietRadioGrp = Container(
      // decoration: TrioBorder(Colors.red),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[

          Container(
            child: const Text('Diet:', style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorConstants.greyColor
            ),),
          ),

          Row(
            children: [
              Radio(
                value: Diet.Vegetarian,
                groupValue: _diet,
                onChanged: (Diet? value) {
                  setState(() {
                    _diet = value;
                  });
                },
              ),
              Text('Vegetarian'),
            ],
          ),

          Row(
            children: [
              Radio(
                value: Diet.NonVegetarian,
                groupValue: _diet,
                onChanged: (Diet? value) {
                  setState(() {
                    _diet = value;
                  });
                },
              ),
              Text('Non-Vegetarian'),
            ],
          )


        ],
      ),
    );

    Widget cusineTypeTextBox = Container(
      // decoration: TrioBorder(Colors.red),
      padding: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
      child: TextFormField(
        controller: cusineController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelStyle:
          TextStyle(color: Colors.black),
          hintText: "Type of Cusine",
          labelText: "Cusine",
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Field can not be empty";
          }

          return null;
        },
      ),
    );

    Widget statusRadioGrp = Container(
      // decoration: TrioBorder(Colors.red),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[

          Container(
            child: const Text('Status:', style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorConstants.greyColor
            ),),
          ),

          Row(
            children: [
              Radio(
                value: Status.Active,
                groupValue: _status,
                onChanged: (Status? value) {
                  setState(() {
                    _status = value;
                  });
                },
              ),
              Text('Vegetarian'),
            ],
          ),

          Row(
            children: [
              Radio(
                value: Status.Deactive,
                groupValue: _status,
                onChanged: (Status? value) {
                  setState(() {
                    _status = value;
                  });
                },
              ),
              Text('Deactive'),
            ],
          )
        ],
      ),
    );

    //-------------------

    Widget qntyPerDayUpload = Container(
      // decoration: TrioBorder(Colors.red),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Max Quantity (per Day): ",style: TextStyle(fontSize: 20,color: ColorConstants.greyColor),),
        SizedBox(
          width: 100,
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Qualntity',
              labelText: 'Quantity',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Field can not be empty";
              }

              return null;
            },
          ),
        ),



          ],),
    );

    Widget DescriptionTextBox = Container(
      // decoration: TrioBorder(Colors.red),
      padding: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
      child: TextFormField(
        controller: description,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelStyle:
          TextStyle(color: Colors.black),
          hintText: "Description",
          labelText: "Description",
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Field can not be empty";
          }

          return null;
        },
      ),
    );

    Widget SubmitButton = Container(
      // decoration: TrioBorder(Colors.red),
      padding: EdgeInsets.only(left: 10, right: 10),
      width: 1000,
      child: SizedBox(
        child: ElevatedButton(
          child: const Text('Submit',style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),),
          onPressed: (){
            showSnackBar("Dish added!");
          },
        ),
      ),
    );


    return Scaffold(
    backgroundColor: ColorConstants.whiteColor,
    body: SafeArea(
    child: ListView(
    children: [
    mainTitle,
    subTitle,
    dishtitleTextBox,
    imageUpload,
    priceTextBox,
    dietRadioGrp,
    cusineTypeTextBox,
    statusRadioGrp,
    qntyPerDayUpload,
      DescriptionTextBox,
      SubmitButton
    ],
    )
    ),
    );


  }


}

enum Diet { Vegetarian, NonVegetarian }

enum Status { Active, Deactive }
