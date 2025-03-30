import 'package:codeplasm/pages/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.pink,
        colorScheme: const ColorScheme.dark(
          primary: Colors.pink,
          secondary: Colors.pink,
          surface: Colors.black,
          error: Colors.red,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
      ),
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
      popGesture: true,
      themeMode: ThemeMode.dark,
      opaqueRoute: true,
    ),
  );
}
