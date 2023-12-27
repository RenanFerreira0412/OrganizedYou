import 'package:flutter/material.dart';

class OrganizedYou extends StatelessWidget {
  const OrganizedYou({super.key});

  static String title = "OrganizedYou App";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Container(),
    );
  }
}
