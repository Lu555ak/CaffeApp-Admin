import 'package:caffe_app/utility/constants.dart';
import 'package:flutter/material.dart';

class ListViewAddButton extends StatelessWidget {
  const ListViewAddButton({super.key, required this.onTap});

  final Function onTap;

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
          decoration: const BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: const Icon(
            Icons.add_rounded,
            color: subColor,
            size: 35,
          ),
        ),
      ),
    );
  }
}
