import 'package:caffe_app/custom/circle_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:caffe_app/utility/constants.dart';

class ActiveOrderWidget extends StatelessWidget {
  const ActiveOrderWidget(
      {super.key,
      this.acceptedMode = false,
      required this.table,
      required this.showOrder,
      required this.onAccepted,
      required this.onCompleted});

  final bool acceptedMode;
  final int table;
  final Function showOrder;
  final Function onAccepted;
  final Function onCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        color: (acceptedMode) ? primaryColor : subColor2,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: subColor2.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(-5, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: (acceptedMode) ? successColor : secondaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.table_restaurant_rounded,
                      color: (acceptedMode) ? secondaryColor : subColor2,
                      size: 50,
                    ),
                    Text(
                      table.toString(),
                      style: TextStyle(
                          fontSize: 43,
                          fontWeight: FontWeight.w600,
                          color: (acceptedMode) ? secondaryColor : subColor2),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: (acceptedMode)
                      ? Align(
                          alignment: Alignment.topCenter,
                          child: IconButton(
                              onPressed: () {
                                showOrder();
                              },
                              icon: const Icon(
                                Icons.list,
                                color: secondaryColor,
                                size: 40,
                              )),
                        )
                      : Container(),
                ),
                Flexible(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: CircleIconButton(
                      iconData: (acceptedMode)
                          ? Icons.check_circle_outlined
                          : Icons.check,
                      iconColor: (acceptedMode) ? secondaryColor : subColor2,
                      buttonColor:
                          (acceptedMode) ? successColor : secondaryColor,
                      pressColor: (acceptedMode) ? subColor : primaryColor,
                      onPress: () {
                        if (acceptedMode) {
                          onCompleted();
                        } else {
                          onAccepted();
                        }
                      },
                    ),
                  ),
                ),
              ],
            )),
          )
        ],
      ),
    );
  }
}
