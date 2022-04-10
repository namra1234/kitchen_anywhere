import 'package:flutter/material.dart';
import 'package:kitchen_anywhere/common/buttonStyle.dart';
import 'package:kitchen_anywhere/common/colorConstants.dart';
import 'package:kitchen_anywhere/view/authentication/login.dart';
import '../../common/constants.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

enum UserType { chef, foodie }

class _SignupScreenState extends State<SignupScreen> {
  String name = "";
  bool changeButton = false;
  late TextEditingController emailController,
      passwordController,
      fullNameController,
      addressController,
      postalCodeController,
      phoneNoController,
      confirmPasswordController;

  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  UserType? _userType = UserType.chef;
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  register() async {
    if (_formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();
    fullNameController = TextEditingController();
    addressController = TextEditingController();
    postalCodeController = TextEditingController();
    phoneNoController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    addressController.dispose();
    postalCodeController.dispose();
    phoneNoController.dispose();
    confirmPasswordController.dispose();
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
                child: Image.asset(
                  'assets/images/background_kitchen.jpg',
                  fit: BoxFit.fill,
                  colorBlendMode: BlendMode.lighten,
                ),
              ),
            ),
            //debugShowCheckedModeBanner="false";
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/splashMainLogo.png",
                                  height: 250,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  "Welcome",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 17, horizontal: 20),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: emailController,
                                          decoration: const InputDecoration(
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                            hintText: "Username",
                                            labelText: "Enter Username",
                                          ),
                                          validator: (value) {
                                            String emailPattern =
                                                '([a-zA-Z0-9._-]+@[a-z]+\\.+[a-z]+)';
                                            RegExp regExp =
                                                RegExp(emailPattern);
                                            if (value!.isEmpty) {
                                              return "Field can not be empty";
                                            } else if (!regExp
                                                .hasMatch(value)) {
                                              return "Invalid email address";
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            name = value;
                                            setState(() {});
                                          },
                                        ),
                                        TextFormField(
                                          controller: fullNameController,
                                          decoration: const InputDecoration(
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                            hintText: "Fullname",
                                            labelText: "Enter Fullname",
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Field can not be empty";
                                            }

                                            return null;
                                          },
                                        ),
                                        TextFormField(
                                          controller: addressController,
                                          decoration: const InputDecoration(
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                            hintText: "Address",
                                            labelText: "Enter Address",
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Field can not be empty";
                                            }

                                            return null;
                                          },
                                        ),
                                        TextFormField(
                                          controller: postalCodeController,
                                          decoration: const InputDecoration(
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                            hintText: "Postal code",
                                            labelText: "Enter Postal Code",
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Field can not be empty";
                                            }

                                            return null;
                                          },
                                        ),
                                        TextFormField(
                                          controller: phoneNoController,
                                          decoration: const InputDecoration(
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                            hintText: "Phone No",
                                            labelText: "Enter Phone No",
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Field can not be empty";
                                            }

                                            return null;
                                          },
                                        ),
                                        TextFormField(
                                          controller: passwordController,
                                          obscureText: true,
                                          decoration: const InputDecoration(
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                            hintText: "Password",
                                            labelText: "Enter Password",
                                          ),
                                          validator: (value) {
                                            String passwordPattern =
                                                '((?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#\$%^&+=])(?=\\S+).{4,})';
                                            RegExp regExp =
                                                RegExp(passwordPattern);
                                            if (value!.isEmpty) {
                                              return "Field can not be empty";
                                            } else if (!regExp
                                                .hasMatch(value)) {
                                              return "Password is too weak";
                                            }

                                            return null;
                                          },
                                        ),
                                        TextFormField(
                                          controller: confirmPasswordController,
                                          obscureText: true,
                                          decoration: const InputDecoration(
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                            hintText: "Confirm Password",
                                            labelText: "Enter Confirm Password",
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Field can not be empty";
                                            } else if (value !=
                                                passwordController.text) {
                                              return "Confirm password must match password";
                                            }

                                            return null;
                                          },
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "User Type",
                                            style: TextStyle(
                                                fontSize: 17, color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                width:Constants.width/4,
                                                child: Expanded(
                                                    child: RadioListTile<UserType>(
                                                      contentPadding: EdgeInsets.only( // Add this
                                                          left: 0,
                                                          right: 0,
                                                          bottom: 0,
                                                          top: 0
                                                      ),
                                                      title:  Align(
                                                          alignment: Alignment(-5.1, 0),
                                                          child: Text('Chef')),
                                                      value: UserType.chef,
                                                      groupValue: _userType,
                                                      onChanged: (UserType? value) {
                                                        setState(() {
                                                          _userType = value;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                              ),
                                              Expanded(
                                                  child: RadioListTile<UserType>(
                                                    contentPadding: EdgeInsets.only( // Add this
                                                        left: 0,
                                                        right: 0,
                                                        bottom: 0,
                                                        top: 0
                                                    ),
                                                    title:  Align(
                                                        alignment: Alignment(-1.2, 0),
                                                        child: Text('Foodie')),
                                                    value: UserType.foodie,
                                                    groupValue: _userType,
                                                    onChanged: (UserType? value) {
                                                      setState(() {
                                                        _userType = value;
                                                      });
                                                    },
                                                  ),
                                                ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        centerButton(
                            Constants.height / 14,
                            Constants.width * 0.50,
                            Constants.width * 0.10,
                            ColorConstants.secondaryColor,
                            ColorConstants.whiteColor,
                            "Register",
                            register,
                            context),
                        SizedBox(height: 20.0),
                        Container(
                          width: Constants.width * 0.61,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Already have an account?",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                                },
                                child: Container(
                                  child: Text('Sign in',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Text(
                            "Or Sign up with",
                            style: TextStyle(fontSize: 17, color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: Constants.width * 0.28,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
            )
          ],
        ),
      ),
    );
  }

  letsStart() {
    print('welcome');
  }
}
