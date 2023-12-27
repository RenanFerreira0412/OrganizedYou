import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:organized_you/firebase_options.dart';
import 'package:organized_you/organized_you.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const OrganizedYou());
}
