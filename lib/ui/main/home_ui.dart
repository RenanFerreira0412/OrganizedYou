import 'package:flutter/material.dart';
import 'package:organized_you/services/auth_service.dart';
import 'package:organized_you/widgets/buttons.dart';
import 'package:provider/provider.dart';

class HomeUI extends StatelessWidget {
  const HomeUI({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    return Scaffold(
      body: Column(
        children: [
          PrimaryButton(labelText: 'Sair', onPressed: () => auth.logout())
        ],
      ),
    );
  }
}
