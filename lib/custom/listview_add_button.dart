import 'package:caffe_app/utility/constants.dart';
import 'package:flutter/material.dart';

class ListViewAddButton extends StatelessWidget {
  ListViewAddButton(
      {super.key,
      required this.onTap,
      this.iconSize = 35,
      this.iconColor = subColor,
      this.boxColor = secondaryColor});

  final Function onTap;
  double iconSize;
  Color iconColor;
  Color boxColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Icon(
            Icons.add_rounded,
            color: iconColor,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
