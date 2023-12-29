import 'package:flutter/material.dart';
import 'package:organized_you/responsive/responsive.dart';
import 'package:organized_you/ui/main/home/home_desktop_ui.dart';
import 'package:organized_you/ui/main/home/home_mobile_ui.dart';

class HomeUI extends StatelessWidget {
  const HomeUI({super.key});

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: HomeMobileUI(),
      desktop: HomeDesktopUI(),
    );
  }
}
