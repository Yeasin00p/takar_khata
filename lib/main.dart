import 'package:flutter/material.dart';
import 'package:takar_khata/core/navigation/bottom_nav_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Takar Khata',
      debugShowCheckedModeBanner: false,
      home: BottomNavScreen(),
    );
  }
}
