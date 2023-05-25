import 'package:flutter/material.dart';

// ignore: camel_case_types
class themes {
  static Color Maincolor = const Color.fromARGB(180, 4, 253, 91);
  static Color secondColor = const Color.fromARGB(50, 4, 253, 91);
  static Color PikiaColor = const Color.fromARGB(255, 232, 254, 226);
  static Color black = const Color.fromARGB(255, 194, 190, 190);
  static Color white = Colors.white;

  static final ThemeData lightmode = ThemeData(
      primaryColor: themes.Maincolor,
      focusColor: themes.Maincolor,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.w400),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 5,
        centerTitle: false,
      ),
      textTheme: TextTheme(
          titleLarge: TextStyle(
              fontSize: 70,
              fontWeight: FontWeight.bold,
              color: themes.Maincolor),
          titleMedium: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),
          displaySmall: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
          titleSmall: const TextStyle(
              fontSize: 25, fontWeight: FontWeight.w400, color: Colors.white),
          displayLarge: const TextStyle(
              fontSize: 25, fontWeight: FontWeight.w400, color: Colors.black),
          displayMedium: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: themes.Maincolor),
          headlineSmall: const TextStyle(
            color: Colors.black,
            fontSize: 60,
            fontWeight: FontWeight.bold,
          )),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 2,
          selectedItemColor: Colors.blue, unselectedItemColor: Colors.grey), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: themes.Maincolor));
}
