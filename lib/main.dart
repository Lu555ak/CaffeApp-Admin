import 'package:caffe_app/utility/constants.dart';
import 'package:flutter/material.dart';

import 'package:caffe_app/desktop/layout_desktop.dart';
import 'package:caffe_app/tablet/layout_tablet.dart';
import 'package:caffe_app/mobile/layout_mobile.dart';
import 'package:caffe_app/login_page.dart';

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
      home: Stack(children: const [
        Background(
          color: subColor,
          opacity: 0.75,
        ),
        //LoginPage(),
        CaffeApp(
          mobileLayout: LayoutMobile(),
          tabletLayout: LayoutTablet(),
          desktopLayout: LayoutDesktop(),
        ),
      ]),
    );
  }
}

class CaffeApp extends StatelessWidget {
  final Widget mobileLayout;
  final Widget tabletLayout;
  final Widget desktopLayout;

  const CaffeApp(
      {super.key,
      required this.mobileLayout,
      required this.tabletLayout,
      required this.desktopLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 450) {
        return mobileLayout;
      } else if (constraints.maxWidth > 400 && constraints.maxWidth <= 1100) {
        return tabletLayout;
      } else {
        return desktopLayout;
      }
    });
  }
}
