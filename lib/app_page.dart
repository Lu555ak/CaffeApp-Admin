import 'package:flutter/material.dart';

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
