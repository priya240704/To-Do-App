import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 10), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: Lottie.network('https://lottie.host/22403d64-ffa2-4232-b7aa-f6e8578664c4/mfqijuIPCg.json'),
      ),
    );
  }
}
