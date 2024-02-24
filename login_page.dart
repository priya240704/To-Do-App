import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/auth.dart';
import 'package:todo_app/screens/my_home_page.dart';
import 'package:todo_app/screens/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  bool isLoding = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final auth = Get.put(AuthController());

  var bodycolore = Colors.white;
  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.only(
              top: 120,
              left: 10,
              right: 10,
            ),
            child: Column(
              children: [
                Text(
                  "Welcome Back!",
                  style: TextStyle(
                      fontSize: 30,
                      color: bodycolore,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 3),
                Text("Please Sign in to Your Account",
                    style: TextStyle(color: Colors.white)),
                SizedBox(height: 10),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // controller: emalic,
                  controller: email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.white,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(color: Colors.white.withOpacity(0.5))),
                    hintText: "Enter your Email id",
                    hintStyle: TextStyle(color: bodycolore.withOpacity(0.5)),
                    labelText: "Email",
                    labelStyle: TextStyle(color: bodycolore.withOpacity(0.5)),
                    prefixIcon:
                        Icon(CupertinoIcons.envelope, color: bodycolore),
                  ),
                  validator: (myvalue) {
                    if (myvalue!.isEmpty) {
                      return "Email Requried";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  obscureText: _obscureText,
                  //autovalidateMode: AutovalidateMode.onUserInteraction,
                  //controller: passc,
                  controller: password,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.white,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(color: Colors.white.withOpacity(0.5))),
                    hintText: "Enter your Password",
                    hintStyle: TextStyle(color: bodycolore.withOpacity(0.5)),
                    labelText: "Password",
                    labelStyle: TextStyle(color: bodycolore.withOpacity(0.5)),
                    prefixIcon: Icon(CupertinoIcons.lock, color: bodycolore),
                    suffixIcon: IconButton(
                      color: bodycolore,
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  validator: (myvalue) {
                    if (myvalue!.isEmpty) {
                      return "Password Requried";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 15),
                Container(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isLoding = true;
                      });
                      if (formKey.currentState!.validate()) {
                        auth.loginUser(email.text, password.text);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                    child: !isLoding
                        ? Text(
                            "SIGN IN",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        : CircularProgressIndicator(
                            color: Colors.white,
                          ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't Have an Account ? ",
                      style: TextStyle(
                        color: bodycolore,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(SignUpPage());
                        },
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


