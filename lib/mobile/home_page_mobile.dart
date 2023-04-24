import 'package:caffe_app/utility/constants.dart';
import 'package:flutter/material.dart';

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({super.key});

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      "HOME PAGE",
      style: TextStyle(
          color: secondaryColor, fontSize: 30, backgroundColor: subColor),
    ));
  }
}
