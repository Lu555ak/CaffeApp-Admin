import 'package:caffe_app/utility/constants.dart';
import 'package:flutter/material.dart';

import '../custom/small_icon_button.dart';

class LoyaltyPageMobile extends StatefulWidget {
  const LoyaltyPageMobile({super.key});

  @override
  State<LoyaltyPageMobile> createState() => _LoyaltyPageMobileState();
}

class _LoyaltyPageMobileState extends State<LoyaltyPageMobile> {
  final priceController = TextEditingController();

  @override
  void dispose() {
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
            color: subColor2,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "LOYALTY FORMULA: ",
              style: const TextStyle(
                  color: secondaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
            Text(
              "4 € = 1 POINT",
              style: const TextStyle(
                  color: shinyColor, fontWeight: FontWeight.w800, fontSize: 15),
            ),
            SmallIconButton(
                iconData: Icons.edit,
                iconColor: secondaryColor,
                iconSize: 25,
                onTap: () {}),
          ],
        ),
      )
    ]));
  }
}
