import 'dart:ui';

import 'package:flutter/material.dart';


Color bluishClr=Color(0xFF4e5ae8);
Color yellowClr=Color(0xFFFFB746);
Color pinkClr=Color(0xFFff4667);
Color white=Colors.white;
Color primaryClr=bluishClr;
Color darkGreyClr=Color(0xFF121212);
Color darkHeaderClr=Color(0xFF424242);

class Themes{
  static final light=ThemeData(
      backgroundColor:Colors.white,
      primaryColor:primaryClr,
      brightness: Brightness.light
  );
  static final dark=ThemeData(
      backgroundColor: darkGreyClr,
      primaryColor:  darkGreyClr,
      brightness: Brightness.dark
  );
}
