import 'package:caffe_app/utility/constants.dart';
import 'package:flutter/material.dart';

class SettingsPageMobile extends StatefulWidget {
  const SettingsPageMobile({super.key});

  @override
  State<SettingsPageMobile> createState() => _SettingsPageMobileState();
}

class _SettingsPageMobileState extends State<SettingsPageMobile> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
            color: subColor2,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.0), bottomRight: Radius.circular(25.0))),
        child: const Text(
          "HI @USER!",
          style: TextStyle(color: secondaryColor, fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: const Row(children: [
            Text(
              "Language: ",
              style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500, fontSize: 13),
            ),
          ]),
        ),
      )
    ]);
  }
}
