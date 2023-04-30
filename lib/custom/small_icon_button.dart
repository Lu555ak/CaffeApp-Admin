import 'package:flutter/material.dart';
import 'package:caffe_app/utility/constants.dart';

/*class SmallIconButton extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final Function onTap;

  const SmallIconButton(
      {super.key,
      required this.iconData,
      required this.iconColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap(),
        customBorder: const CircleBorder(),
        splashColor: primaryColor,
        child: FittedBox(
          child: Icon(
            iconData,
            color: iconColor,
            size: 35,
          ),
        ),
      ),
    );
  }
}*/

class SmallIconButton extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final Function onTap;
  final double iconSize;

  const SmallIconButton(
      {super.key,
      required this.iconData,
      required this.iconColor,
      required this.onTap,
      this.iconSize = 35});

  @override
  Widget build(BuildContext context) {
    return Material(
        shape: const CircleBorder(),
        color: Colors.transparent,
        child: IconButton(
          icon: Icon(
            iconData,
            color: iconColor,
          ),
          highlightColor: Colors.transparent,
          iconSize: iconSize,
          hoverColor: neutralColor.withOpacity(0.1),
          onPressed: () {
            onTap();
          },
        ));
  }
}
