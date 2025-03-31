import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:codeplasm/pages/loader_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  final themeMode = preferences.getBool('dark') ?? true;
  runApp(
    GetMaterialApp(
      home: LoaderScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.pink,
        colorScheme: const ColorScheme.dark(
          error: Colors.red,
          primary: Colors.pink,
          surface: Colors.black,
          secondary: Colors.pink,
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
      themeMode: themeMode ? ThemeMode.dark : ThemeMode.light,
      opaqueRoute: true,
    ),
  );
}
