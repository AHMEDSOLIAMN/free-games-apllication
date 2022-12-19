import 'package:flutter/material.dart';
import 'package:free_to_game/core/app_colors.dart';
import 'package:hexcolor/hexcolor.dart';

class MyTheme {
  ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: MyColors().scaffoldColor,
    primarySwatch: MyColors().primaryColor,
  );
  ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey,
    primarySwatch: MyColors().primaryColor,
  );
}
