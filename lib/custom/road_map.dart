import 'package:caffe_app/custom/custom_scroll_behavior.dart';
import 'package:flutter/material.dart';

import 'package:caffe_app/utility/constants.dart';

class RoadMap extends StatelessWidget {
  const RoadMap({super.key, required this.roadmap});

  final List<int> roadmap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Row(
        children: [
          ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: roadmap.length,
                itemBuilder: (context, index) {
                  if (roadmap[index] != 0) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, bottom: 10, top: 10),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          border: Border.all(color: primaryColor, width: 10),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                          boxShadow: [
                            BoxShadow(
                              color: subColor2.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(-5, 5),
                            ),
                          ],
                        ),
                        child: Center(
                            child: Text("${roadmap[index]}.",
                                style: const TextStyle(
                                    color: primaryColor,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w900))),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, bottom: 40, top: 40),
                      child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            border: Border.all(color: primaryColor, width: 8),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            boxShadow: [
                              BoxShadow(
                                color: subColor2.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(-5, 5),
                              ),
                            ],
                          )),
                    );
                  }
                },
              ),
            ),
          ),
          FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color: subColor2.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(-5, 5),
                      ),
                    ],
                  ),
                  child: const FittedBox(
                      child: Icon(
                    Icons.add_rounded,
                    color: subColor,
                  )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
