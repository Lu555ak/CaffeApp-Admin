import 'package:flutter/material.dart';
import 'package:caffe_app/utility/constants.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({super.key, required this.onPress});
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(subColor2),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel', style: TextStyle(fontSize: 14)))),
        ),
        Expanded(
          child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primaryColor),
                  ),
                  onPressed: () {
                    onPress();
                  },
                  child:
                      const Text('Confirm', style: TextStyle(fontSize: 14)))),
        ),
      ],
    );
  }
}
