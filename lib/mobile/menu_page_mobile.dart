import 'package:caffe_app/utility/constants.dart';
import 'package:flutter/material.dart';

class MenuPageMobile extends StatefulWidget {
  const MenuPageMobile({super.key});

  @override
  State<MenuPageMobile> createState() => _MenuPageMobileState();
}

class _MenuPageMobileState extends State<MenuPageMobile> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      "MENU",
      style: TextStyle(
          color: secondaryColor, fontSize: 30, backgroundColor: subColor),
    ));
  }
}
