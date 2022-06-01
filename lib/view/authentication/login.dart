import 'package:flutter/material.dart';
import 'package:kitchen_anywhere/common/buttonStyle.dart';
import 'package:kitchen_anywhere/common/colorConstants.dart';
import 'package:kitchen_anywhere/view/chef/chefMainScreen.dart';
import 'package:kitchen_anywhere/view/foodie/foodieMainScreen.dart';
import '../../common/constants.dart';
import 'package:kitchen_anywhere/model/userModel.dart';
import 'package:kitchen_anywhere/repository/userRep.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String name = "";
  bool changeButton = false;
  late TextEditingController emailController, passwordController;

   final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();


  void showSnackBar(String message) {



    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ),);

  }

  login () async{
    if(_formKey.currentState!.validate()){
      print('welcome');
      FocusManager.instance.primaryFocus?.unfocus();

      FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: emailController.text.trim(), password: passwordController.text)
          .then((value) async {
        Constants.loggedInUserID = FirebaseAuth.instance.currentUser!.uid;

        await UserRepository().getUser(Constants.loggedInUserID);

        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool('isLoggedin', true);

        preferences.setString(
            'fullName', Constants.userdata.fullName);
        preferences.setString('email', Constants.userdata.email);
        preferences.setString('address', Constants.userdata.address);
        preferences.setString('phoneNo', Constants.userdata.phoneNo);
        preferences.setString('postal_code', Constants.userdata.postal_code);
        preferences.setString('userID', Constants.loggedInUserID);
        preferences.setBool('isChef', Constants.userdata.isChef);

        Constants.myName = Constants.userdata.fullName;
        Constants.myEmail = Constants.userdata.email;

        showSnackBar("Login Successfully");

        if(Constants.userdata.isChef)
          {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                ChefMainPage()), (Route<dynamic> route) => false);
          }
        else
          {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                FoodieMainPage()), (Route<dynamic> route) => false);
          }



      }).catchError((e) {
        showSnackBar(e.message);
      });

  }
  }

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();

  }

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Constants.height = MediaQuery.of(context).size.height;
    Constants.width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      body: SafeArea(
        child: Stack(
          children: [
            Opacity(
          opacity: 0.2,
              child: SizedBox(
                height: Constants.height,
                child: Image.asset('assets/images/background_kitchen.jpg',fit: BoxFit.fill,colorBlendMode: BlendMode.lighten
                  ,),
              ),
            ),
            //debugShowCheckedModeBanner="false";
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: Constants.height*0.63,
                    child: Form(
                         key: _formKey,
                      child: Center(
                        child: Column(
                            children:<Widget> [
                              Image.asset("assets/images/splashMainLogo.png",
                              height: 250,fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                               Text(
                                "Welcome",
                                style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              ),

                              Center(
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(vertical: 17,horizontal: 20),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: emailController,
                                        decoration: const InputDecoration(
                                          labelStyle: TextStyle(color: Colors.black),
                                          hintText: "Username",
                                          labelText: "Enter Username",
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Username can not be empty";
                                          }
                                           return null;
                                         },
                                        onChanged: (value){
                                          name = value;
                                          setState(() {});
                                        },
                                      ),
                                      TextFormField(
                                        controller: passwordController,
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                          labelStyle:TextStyle(color: Colors.black),
                                          hintText: "Password",
                                          labelText: "Enter Password",
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Password can not be empty";
                                          }

                                          return null;
                                        },
                                      ),


                                    ],
                                  ),
                                ),
                              ),

                            ],
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    onPressed: () {},
                    child:  Text(
                      'Forgot Password?', style: TextStyle(
                        color: Colors.green,fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),

                  centerButton(Constants.height/14,Constants.width*0.50,Constants.width*0.10,ColorConstants.secondaryColor,ColorConstants.whiteColor,"Login",login,context),

                  SizedBox(
                      height: 20.0),
                  Container(
                    width: Constants.width*0.6   ,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text(
                              "Don't have an account?",style: TextStyle(
                                fontSize: 17,color: Colors.black),
                            ),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                            const SignupScreen()));
                          },
                          child: Container(
                            child: Text('Sign up', style: TextStyle(
                                color: Colors.green,fontWeight: FontWeight.bold)),
                          ),
                        ),
                        // TextButton(
                        //   style: TextButton.styleFrom(
                        //     textStyle: const TextStyle(fontSize: 18),
                        //   ),
                        //   onPressed: () {
                        //     Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                        //         SignupScreen()));
                        //   },
                        //   child: const Text('Sign up', style: TextStyle(
                        //       color: Colors.green,fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Center(
                    child: Text(
                      "Or Sign in with",style: TextStyle(
                        fontSize: 17,color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  // Container(
                  //   width: Constants.width*0.28,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children:[
                  //       Ink(
                  //         decoration: const ShapeDecoration(
                  //           color: Colors.green,
                  //           shape: CircleBorder(),
                  //         ),
                  //         child: IconButton(
                  //           icon: const Icon(Icons.facebook),
                  //           color: Colors.black,
                  //           onPressed: () {},
                  //         ),
                  //       ),
                  //       Ink(
                  //         decoration: const ShapeDecoration(
                  //           color: Colors.green,
                  //           shape: CircleBorder(),
                  //         ),
                  //         child: IconButton(
                  //           icon: const Icon(Icons.inbox),
                  //           color: Colors.black,
                  //           onPressed: () {},
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 30)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  letsStart()
  {
    print('welcome');
  }

}
