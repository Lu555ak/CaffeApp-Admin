import 'package:caffe_app/utility/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:caffe_app/utility/constants.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({super.key, required this.onPress, this.alignCenter = true});
  final Function onPress;
  final bool alignCenter;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: (alignCenter) ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: <Widget>[
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(subColor2),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(AppLocalizations.of(context).translate("cancel_text"))),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(primaryColor),
              ),
              onPressed: () {
                onPress();
              },
              child: Text(AppLocalizations.of(context).translate("confirm_text"))),
        ),
      ],
    );
  }
}
