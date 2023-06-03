import 'package:flutter/material.dart';
import 'package:caffe_app/utility/constants.dart';

class CreditsDisplay extends StatelessWidget {
  const CreditsDisplay({super.key, required this.euroAmount, required this.creditsAmount, required this.onClick});

  final int euroAmount;
  final int creditsAmount;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 75,
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
              color: subColor2,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.0), bottomRight: Radius.circular(25.0))),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Container(
              width: 350,
              height: 100,
              decoration: const BoxDecoration(color: subColor, borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "CREDITS",
                      style: TextStyle(color: subColor2, fontWeight: FontWeight.w600, fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: InkWell(
                      onTap: () {
                        onClick();
                      },
                      child: Container(
                        height: 75,
                        decoration: const BoxDecoration(
                            color: primaryColor, borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              Text(
                                "$euroAmount€",
                                style: const TextStyle(color: subColor, fontWeight: FontWeight.w600, fontSize: 35),
                              ),
                              const Icon(
                                Icons.arrow_right_rounded,
                                color: subColor,
                                size: 30,
                              ),
                              Text(
                                creditsAmount.toString(),
                                style: const TextStyle(color: shinyColor, fontWeight: FontWeight.w800, fontSize: 35),
                              ),
                              const Icon(
                                Icons.circle,
                                color: shinyColor,
                                size: 30,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
