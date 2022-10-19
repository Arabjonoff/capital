import 'package:flutter/material.dart';

class AppColor{

}

class AppTheme{
  static ThemeData light(){
    return ThemeData(
        brightness: Brightness.light,

    );
  }
  static ThemeData dark(){
    return ThemeData(
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
    );
  }
}