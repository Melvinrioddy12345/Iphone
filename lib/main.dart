import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apple Phones Sucre',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(  
          seedColor: const Color(0xFF1D1D1F),
          background: const Color(0xFFF5F5F7),
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
} 