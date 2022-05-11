import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kitchen_anywhere/common/buttonStyle.dart';
import 'package:kitchen_anywhere/common/colorConstants.dart';
import 'package:kitchen_anywhere/repository/dishRep.dart';
import 'package:kitchen_anywhere/view/chef/chefMainScreen.dart';
import '../../common/TrioBorder.dart';
import '../../common/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';


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
  late File _image;
  bool uploadingImage = false;
  String uploadedFileURL = "";
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


  @override
  void dispose() {
    super.dispose();
    uploadedFileURL="";
  }

  void submitData(){

    if (_formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();

      double price = double.parse(priceController.text.toString());
      int dish = int.parse(numberOfDishes.text.toString());
      Random random = Random();
      int _randomNumber1 = random.nextInt(5);
      setState(() {
        DishRepository().createDish(DishModel(
            dishTitleController.text,
            uploadedFileURL=="" ? "https://e1.pngegg.com/pngimages/621/910/png-clipart-food-2-food-thumbnail.png" : uploadedFileURL,
            cusineController.text,
            description.text,
            price,
            dish,
            dish,
            _diet == Diet.Vegetarian ? true : false,
            _status == Status.Active ? true : false,
            Constants.loggedInUserID
            ,_randomNumber1, [] ,_randomNumber1
        ));
      });
      uploadedFileURL="";
      showSnackBar("Dish Added Successfully.");
      Navigator.of(context).pop();
    }
  }



  Future getImage() async {

    final picker = ImagePicker();

      final pickedFile = await picker.getImage(source: ImageSource.gallery);


    setState(() {
      uploadingImage = true;
    });
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageReference =
    FirebaseStorage.instance.ref().child(Constants.loggedInUserID+Constants.dish.length.toString());
    UploadTask uploadTask = storageReference.putFile(File(pickedFile!.path.toString()));
    await uploadTask.then((taskSnapshot) async {
      uploadedFileURL = await taskSnapshot.ref.getDownloadURL();
      // _showSnackBar("Successfully uploaded profile picture");
    }).catchError((e) {
      // _showSnackBar("Failed to upload profile picture");
    });
    setState(() {
      uploadingImage = false;
    });
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
            color: ColorConstants.primaryColor
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
      padding: EdgeInsets.only(top: 20,bottom: 20),
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
            return "Dish Title can not be empty";
          }

          return null;
        },
      ),
    );

    Widget imageUpload = Container(
      // decoration: TrioBorder(Colors.red),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // padding: EdgeInsets.all(1),
            child: uploadedFileURL  == "" ?

            Image.asset('assets/images/fastfood.png', fit: BoxFit.fill,
              colorBlendMode: BlendMode.lighten,
              height: 100,
              width: 100,) : Image.network(uploadedFileURL,height: 100,width: 100, fit: BoxFit.fill,)
          ),
          Container(
            // padding: EdgeInsets.all(10),
              child: centerButton(
                  Constants.height / 20,
                  Constants.width * 0.55,
                  Constants.width * 0.07,
                  ColorConstants.secondaryColor,
                  ColorConstants.whiteColor,
                  "Browse Image",
                  getImage,
                  context)
          )
        ],
      ),
    );

//-------------------

    Widget priceTextBox = Container(
      // decoration: TrioBorder(Colors.red),
      padding: EdgeInsets.only(bottom: 20, top: 20),
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
            return "Price can not be empty";
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
      padding: EdgeInsets.only(bottom: 10, top: 10),
      child: TextFormField(
        controller: cusineController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelStyle:
          TextStyle(color: Colors.black),
          hintText: "Type of Cusine",
          labelText: "Type of Cusine",
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Type of Cusine can not be empty";
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
            controller: numberOfDishes,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Qualntity',
              labelText: 'Quantity',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Add Quantity";
              }

              return null;
            },
          ),
        ),



          ],),
    );

    Widget DescriptionTextBox = Container(
      // decoration: TrioBorder(Colors.red),
      padding: EdgeInsets.only(bottom: 10, top: 10),
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
            return "Description can not be empty";
          }

          return null;
        },
      ),
    );

    Widget SubmitButton = Container(
      // padding: EdgeInsets.all(10),
        child: centerButton(
            Constants.height / 20,
            Constants.width * 0.35,
            Constants.width * 0.12,
            ColorConstants.secondaryColor,
            ColorConstants.whiteColor,
            "Add Dish",
            submitData,
            context)
    );


    return Scaffold(
    backgroundColor: ColorConstants.whiteColor,
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
    body: SafeArea(
    child: Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20),
          child: Column(
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
                SubmitButton,
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    )
    ),
    );


  }


}

enum Diet { Vegetarian, NonVegetarian }

enum Status { Active, Deactive }
