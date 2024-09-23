import 'package:flutter/material.dart';
import 'package:flutter_brazil_soccer/screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        primaryColor: Colors.green[700],
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
