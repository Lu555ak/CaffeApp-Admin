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
    return const Center(
        child: Text(
      "SETTINGS PAGE",
      style: TextStyle(
          color: secondaryColor, fontSize: 30, backgroundColor: subColor),
    ));
  }
}
