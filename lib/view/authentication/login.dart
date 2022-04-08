import 'package:flutter/material.dart';
import 'package:kitchen_anywhere/common/buttonStyle.dart';
import 'package:kitchen_anywhere/common/colorConstants.dart';
import '../../common/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String name = "";
  bool changeButton = false;

   final _formKey = GlobalKey<FormState>();

   login () async{
    if(_formKey.currentState!.validate()){
      setState(() {
       changeButton = true;
       });
        //await Future.delayed(const Duration(seconds: 1));
       //  Navigator.pushNamed(context, )
      setState(() {
  changeButton = false;
  });
  }
  }

  @override
  void initState() {
    super.initState();
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
                                "Welcome $name",
                                style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              ),

                              Center(
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(vertical: 17,horizontal: 20),
                                  child: Column(
                                    children: [
                                      TextFormField(
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
                                          else if(value.length < 8) {
                                            return "Password length should be atleast 8";
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
                        Text('Sign up', style: TextStyle(
                            color: Colors.green,fontWeight: FontWeight.bold)),
                        // TextButton(
                        //   style: TextButton.styleFrom(
                        //     textStyle: const TextStyle(fontSize: 18),
                        //   ),
                        //   onPressed: () {},
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

                  Container(
                    width: Constants.width*0.28,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        Ink(
                          decoration: const ShapeDecoration(
                            color: Colors.green,
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.facebook),
                            color: Colors.black,
                            onPressed: () {},
                          ),
                        ),
                        Ink(
                          decoration: const ShapeDecoration(
                            color: Colors.green,
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.inbox),
                            color: Colors.black,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
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
