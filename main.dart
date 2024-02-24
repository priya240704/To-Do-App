import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/screens/login_page.dart';
import 'package:todo_app/screens/my_home_page.dart';
import 'package:todo_app/screens/signup_page.dart';
import 'package:todo_app/screens/splash.dart';
import 'package:todo_app/service/theme.dart';
import 'package:todo_app/service/theme_Service.dart';

void main() async {
  //await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TODO LIST',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      //themeMode: ThemeMode.light,
      themeMode: ThemeService().theme,
     home: SplashScreen(),
      //home: firebaseAuth.currentUser == null ? LoginPage() : MyHomePage(),
    );
  }
}
