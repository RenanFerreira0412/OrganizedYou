import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:organized_you/controllers/task_controller.dart';
import 'package:organized_you/firebase_options.dart';
import 'package:organized_you/organized_you.dart';
import 'package:organized_you/services/auth_service.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthService()),
      ChangeNotifierProvider(create: (context) => TaskController()),
    ],
    child: const OrganizedYou(),
  ));
}
