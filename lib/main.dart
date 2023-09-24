import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialmediaapp/appColors.dart';
import 'package:socialmediaapp/firebase_options.dart';
import 'package:socialmediaapp/homePage.dart';
import 'package:socialmediaapp/signUpPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orbit26',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.secondaryColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Image.asset(
                "assets/ORBIT 26.png",
                width: screenSize.width * 0.5,
                height: screenSize.height * 0.5,
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
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
            SizedBox(
              height: 20.0,
            ),
            Container(
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
                    prefixIcon: Icon(
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
            SizedBox(
              height: 40.0,
            ),

            ///LOGIN BUTTON
            GestureDetector(
              onTap: (){
                loginUser();
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
                  "LOGIN",
                  style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),

            SizedBox(
              height: 40.0,
            ),

            ///SIGN UP TEXT BUTTON
            GestureDetector(
              onTap: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage()));
              },
              child: Container(
                width: screenSize.width * 0.5,
                height: screenSize.height * 0.075,
                child: Center(
                    child: Text(
                  "Sign Up ?",
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
              ),
            )
          ],
        ),
      ),
    ));
  }


  loginUser() async {

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
    }


    var res = await firebaseFirestore
        .collection("users")
        .where("email", isEqualTo: emailController.text)
        .get();


    if(res.docs.length == 0){
      Fluttertoast.showToast(
          msg: "Boss user does not exist",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.primaryColor,
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    }else if(res.docs.length == 1){
      Fluttertoast.showToast(
          msg: "Logged In",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.primaryColor,
          textColor: Colors.black,
          fontSize: 16.0);

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HomePage()));


    }

    print("THIS IS RES ${res.docs}");

  }

}
