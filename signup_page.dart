import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  bool _obscureText = true;
  bool isLoding = false;
  var bodycolore = Colors.white;

  final auth = Get.put(AuthController());
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        // leading: Builder(
        //   builder: (BuildContext context) {
        //     return GestureDetector(
        //       onTap: ()async{
        //         setState(() {
        //           Get.to(()=>loginpage());
        //         });
        //       },
        //       child: Padding(
        //         padding:  EdgeInsets.only(
        //           top: 12,
        //           left: 12,
        //           right: 12,
        //           bottom: 12,

        //         ),
        //         child: Image.asset("assets/Images/back.png",),
        //       ),
        //     );
        //   },
        // ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: EdgeInsets.only(
              top: 70,
              left: 8,
              right: 8,
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "Create New Account",
                      style: TextStyle(
                          fontSize: 30,
                          color: bodycolore,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Please Fil In The Form To Continue",
                      style: TextStyle(color: bodycolore.withOpacity(0.5)),
                    ),
                    SizedBox(height: 25),
                  ],
                ),
                TextFormField(
                    style: TextStyle(color: Colors.white),
                    // controller: namec,
                    controller: name,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(
                            color: Colors.white,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide:
                              BorderSide(color: Colors.white.withOpacity(0.5))),
                      hintText: "enter your name",
                      hintStyle: TextStyle(color: bodycolore.withOpacity(0.5)),
                      labelText: "Name",
                      labelStyle: TextStyle(color: bodycolore.withOpacity(0.5)),
                      prefixIcon: Icon(CupertinoIcons.profile_circled,
                          color: bodycolore),
                    ),
                    validator: (myvalue) {
                      if (myvalue!.isEmpty) {
                        return "Name Requried";
                      } else {
                        return null;
                      }
                    }),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // controller: emailc,
                  controller: email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(
                          color: Colors.white,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide:
                            BorderSide(color: Colors.white.withOpacity(0.5))),
                    hintText: "Enter your Emailid",
                    hintStyle: TextStyle(color: bodycolore.withOpacity(0.5)),
                    labelText: "Email",
                    labelStyle: TextStyle(color: bodycolore.withOpacity(0.5)),
                    prefixIcon:
                        Icon(CupertinoIcons.envelope, color: bodycolore),
                  ),
                  validator: (myvalue) => (myvalue!.isNotEmpty)
                      ? null
                      : "Please enter a valid email",
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  obscureText: _obscureText,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // controller: passwordc,
                  controller: password,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(
                          color: Colors.white,

                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide:
                            BorderSide(color: Colors.white.withOpacity(0.5))),
                    hintText: "Enter your Password",
                    hintStyle: TextStyle(color: bodycolore.withOpacity(0.5)),
                    labelText: "Password",
                    labelStyle: TextStyle(color: bodycolore.withOpacity(0.5)),
                    prefixIcon: Icon(CupertinoIcons.lock, color: bodycolore),
                    suffixIcon: IconButton(
                      color: bodycolore,
                      icon: Icon(_obscureText
                          ? Icons.visibility_off
                          : Icons.visibility),
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
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isLoding = true;
                      });
                      if (formkey.currentState!.validate()) {
                        auth.signInUser(
                            name.text, email.text, password.text, context);
                        // auth.storeUser(name.text, email.text, context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      shadowColor: Colors.white.withOpacity(0.5),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    child: !isLoding
                        ? Text(
                            "CREATE",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        : CircularProgressIndicator(
                            color: Colors.white,
                          ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Have an Account ? ",
                      style: TextStyle(
                        color: bodycolore,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          "SIGN IN",
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
