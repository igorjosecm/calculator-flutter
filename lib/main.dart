import 'package:calculator/screens/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      darkTheme:
          ThemeData(brightness: Brightness.dark, primarySwatch: Colors.grey),
      home: const MyHomePage(title: 'Calculator Home Page'),
    );
  }
}
