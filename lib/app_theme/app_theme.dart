import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      textTheme: TextTheme(
        headline6: TextStyle(color: Colors.black),
      ),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    iconTheme: IconThemeData(color: Colors.blue),
    primaryColor: Colors.blue,
    primaryColorLight: Colors.lightBlueAccent,
    bottomAppBarColor: Colors.white,
    tabBarTheme: TabBarTheme(
      labelStyle: TextStyle(
        fontSize: 8.8,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
      indicator: null,
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.black,
    ),
    cardColor: Colors.white,
    dialogBackgroundColor: Colors.white,
    unselectedWidgetColor: Colors.black,
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.black,
      contentTextStyle: TextStyle(color: Colors.white),
    ),
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    textTheme: TextTheme(
      headline6: TextStyle(color: Colors.black),
      button: TextStyle(
        fontFamily: 'Jost',
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.7,
        color: Colors.white,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF272928),
    appBarTheme: AppBarTheme(
      color: Colors.black,
      textTheme: TextTheme(
        headline6: TextStyle(color: Colors.white),
        button: TextStyle(
          fontFamily: 'Jost',
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.7,
          color: Colors.black,
        ),
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: TextTheme(
      headline6: TextStyle(color: Colors.white),
    ),
    primaryColor: Colors.white54,
    primaryColorLight: Colors.lightBlueAccent,
    bottomAppBarColor: Colors.black,
    tabBarTheme: TabBarTheme(
      labelStyle: TextStyle(
          fontSize: 8.8, fontWeight: FontWeight.bold, color: Colors.blue),
      indicator: null,
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.white,
    ),
    dividerColor: Colors.grey[800],
    cardColor: Colors.black,
    dialogBackgroundColor: Colors.grey[800],
    unselectedWidgetColor: Colors.white,
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.white,
      contentTextStyle: TextStyle(color: Colors.black),
    ),
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    ),
  );
}
