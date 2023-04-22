import 'package:flutter/material.dart';

//import 'get_started_page.dart';

import 'desktop/home_page_desktop.dart';
import 'mobile/home_page_mobile.dart';
import 'tablet/home_page_tablet.dart';
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

class CaffeApp extends StatelessWidget {
  final Widget mobileLayout;
  final Widget tabletLayout;
  final Widget desktopLayout;

  CaffeApp(
      {required this.mobileLayout,
      required this.tabletLayout,
      required this.desktopLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 400) {
        return mobileLayout;
      } else if (constraints.maxWidth > 400 && constraints.maxWidth <= 1100) {
        return tabletLayout;
      } else {
        return desktopLayout;
      }
    });
  }
}
