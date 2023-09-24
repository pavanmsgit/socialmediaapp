import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialmediaapp/appColors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController(),
      confirmPasswordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isPasswordVisibleConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.secondaryColor,
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
          ),
          title: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.0,
              ),
              Center(
                child: Image.asset(
                  "assets/ORBIT 26.png",
                  width: screenSize.width * 0.5,
                  height: screenSize.height * 0.25,
                  fit: BoxFit.fitWidth,
                ),
              ),

              const SizedBox(
                height: 25.0,
              ),

              ///EMAIL
              Center(
                child: Container(
                  height: screenSize.height * 0.06,
                  width: screenSize.width * 0.9,
                  decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    cursorColor: AppColor.secondaryColor,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: AppColor.secondaryColor,
                        ),
                        hintText: "Enter email address"),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),

              ///PASSWORD
              Center(
                child: Container(
                  height: screenSize.height * 0.06,
                  width: screenSize.width * 0.9,
                  decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: TextField(
                    controller: passwordController,
                    cursorColor: AppColor.secondaryColor,
                    obscureText: isPasswordVisible,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: AppColor.secondaryColor,
                        ),
                        hintText: "Enter password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              if (isPasswordVisible) {
                                isPasswordVisible = false;
                              } else {
                                isPasswordVisible = true;
                              }
                            });
                          },
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility_rounded,
                            size: 22,
                            color: AppColor.secondaryColor,
                          ),
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),

              ///CONFIRM PASSWORD
              Center(
                child: Container(
                  height: screenSize.height * 0.06,
                  width: screenSize.width * 0.9,
                  decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: TextField(
                    controller: confirmPasswordController,
                    cursorColor: AppColor.secondaryColor,
                    obscureText: isPasswordVisibleConfirmPassword,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: AppColor.secondaryColor,
                        ),
                        hintText: "Confirm password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              if (isPasswordVisible) {
                                isPasswordVisibleConfirmPassword = false;
                              } else {
                                isPasswordVisibleConfirmPassword = true;
                              }
                            });
                          },
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility_rounded,
                            size: 22,
                            color: AppColor.secondaryColor,
                          ),
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),

              ///SIGN UP BUTTON
              GestureDetector(
                onTap: () {
                  registerTheUser();
                },
                child: Container(
                  width: screenSize.width * 0.5,
                  height: screenSize.height * 0.075,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        AppColor.primaryColorAlternative,
                        AppColor.primaryColor
                      ]),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Center(
                      child: Text(
                    "SIGN UP",
                    style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  registerTheUser() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    if (emailController.text == "") {
      Fluttertoast.showToast(
          msg: "Boss please enter email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.primaryColor,
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    } else if (passwordController.text == "") {
      Fluttertoast.showToast(
          msg: "Boss please enter password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.primaryColor,
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    } else if (confirmPasswordController.text == "") {
      Fluttertoast.showToast(
          msg: "Boss please enter confirm password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.primaryColor,
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    } else if (passwordController.text != confirmPasswordController.text) {
      Fluttertoast.showToast(
          msg: "Boss please check for passwords. They don't match",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.primaryColor,
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    }

    await firebaseFirestore.collection("users").add(
        {"email": emailController.text, "password": passwordController.text});

    Fluttertoast.showToast(
        msg: "Account created",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColor.primaryColor,
        textColor: Colors.black,
        fontSize: 16.0);

    Navigator.pop(context);

  }
}
