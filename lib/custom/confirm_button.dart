import 'package:flutter/material.dart';
import 'package:caffe_app/utility/constants.dart';

class ConfirmButton extends StatelessWidget {
  final Function onPress;

  const ConfirmButton({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(neutralColor)),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Cancel",
            style: TextStyle(color: secondaryColor),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(primaryColor)),
          onPressed: () {
            onPress();
            Navigator.pop(context);
          },
          child: const Text(
            "Confirm",
            style: TextStyle(color: secondaryColor),
          ),
        ),
      ],
    );
  }
}
