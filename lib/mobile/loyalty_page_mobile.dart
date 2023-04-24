import 'package:caffe_app/utility/constants.dart';
import 'package:flutter/material.dart';

class LoyaltyPageMobile extends StatefulWidget {
  const LoyaltyPageMobile({super.key});

  @override
  State<LoyaltyPageMobile> createState() => _LoyaltyPageMobileState();
}

class _LoyaltyPageMobileState extends State<LoyaltyPageMobile> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      "LOYALTY PAGE",
      style: TextStyle(
          color: secondaryColor, fontSize: 30, backgroundColor: subColor),
    ));
  }
}
