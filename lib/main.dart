import 'package:flutter/material.dart';
import 'package:health_manager/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Use a MaterialColor here
        fontFamily: 'Nunito', // Set Nunito as the default font
        scaffoldBackgroundColor: Colors.white, // Set background color to white
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white, // Set app bar background color to white
          iconTheme: IconThemeData(color: Colors.black), // Set app bar icon color to black
          titleTextStyle: TextStyle(
            color: Colors.black, // Set app bar title text color to black
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
