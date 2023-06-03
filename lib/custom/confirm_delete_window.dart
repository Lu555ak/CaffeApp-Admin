import 'package:caffe_app/utility/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:caffe_app/utility/constants.dart';

void confirmDeleteWindow(context, String text, Function onPressed) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  text,
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                const SizedBox(height: 10),
                TextButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(dangerColor)),
                  onPressed: () {
                    onPressed();
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppLocalizations.of(context).translate("delete_text"),
                    style: const TextStyle(color: secondaryColor),
                  ),
                )
              ],
            ),
          ),
        );
      });
}
