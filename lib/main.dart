import 'package:flutter/material.dart';

//import 'get_started_page.dart';
import 'app_page.dart';
import 'pages/home_page_desktop.dart';
import 'pages/home_page_mobile.dart';
import 'pages/home_page_tablet.dart';
import 'custom/background.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(children: [
        const Background(
          opacity: 0.75,
        ),
        CaffeApp(
          mobileLayout: const HomePageMobile(),
          tabletLayout: const HomePageTablet(),
          desktopLayout: const HomePageDesktop(),
        ),
      ]),
    );
  }
}
