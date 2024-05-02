import 'package:flutter/material.dart';
import 'package:movie/const/colors.dart';
import 'package:movie/view/movie/movies-screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colours.scafolldBgColor,
        useMaterial3: true,
      ),
      home: const MoviesScreen(),
    );
  }
}

