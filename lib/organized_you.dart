import 'package:flutter/material.dart';
import 'package:organized_you/utils/utils.dart';
import 'package:organized_you/widgets/auth_check.dart';

class OrganizedYou extends StatelessWidget {
  const OrganizedYou({super.key});

  static String title = "OrganizedYou";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        title: title,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AuthCheck());
  }
}
