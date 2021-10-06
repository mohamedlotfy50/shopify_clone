import 'package:flutter/material.dart';
import 'package:shopify/presentation/screens/bottom_navigation_screen.dart';
import 'package:shopify/presentation/screens/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopify',
      theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.green,
          appBarTheme:
              AppBarTheme(color: Colors.white, elevation: 0, centerTitle: true),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.black38,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            filled: true,
            fillColor: Colors.white10,
            labelStyle: TextStyle(color: Colors.green),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.green, width: 2),
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedIconTheme: IconThemeData(color: Colors.green),
              unselectedIconTheme: IconThemeData(color: Colors.black26),
              selectedItemColor: Colors.green,
              unselectedItemColor: Colors.black26),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))))),
      home: LoginScreen(),
    );
  }
}
