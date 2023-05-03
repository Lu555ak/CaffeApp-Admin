import 'package:caffe_app/utility/constants.dart';
import 'package:flutter/material.dart';

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({super.key});

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
              color: subColor2,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0))),
          child: Text(
            "ACTIVE ORDERS: ",
            style: const TextStyle(
                color: secondaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 15),
          ),
        ),
        Container(
          height: 200,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                width: 150,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.table_restaurant_rounded,
                                      color: subColor2,
                                      size: 35,
                                    ),
                                    Text(
                                      "23",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: primaryColor,
                                indent: 20,
                                endIndent: 20,
                              ),
                              Container(
                                width: 150,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(primaryColor),
                                  ),
                                  child: const Text('VIEW MORE'),
                                ),
                              ),
                              const Divider(
                                color: primaryColor,
                                indent: 20,
                                endIndent: 20,
                              ),
                              Row(
                                children: [
                                  const Divider(
                                    color: primaryColor,
                                    indent: 5,
                                    endIndent: 5,
                                  ),
                                  Icon(
                                    Icons.access_time_filled,
                                    color: subColor2,
                                    size: 33.5,
                                  ),
                                  Text(" 2s"),
                                  const Divider(
                                    color: primaryColor,
                                    indent: 5,
                                    endIndent: 5,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 40),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                            const CircleBorder()),
                                        padding: MaterialStateProperty.all(
                                            const EdgeInsets.all(10)),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                subColor2),
                                        overlayColor: MaterialStateProperty
                                            .resolveWith<Color?>((states) {
                                          if (states.contains(
                                              MaterialState.pressed)) {
                                            return subColor;
                                          }
                                          return null;
                                        }),
                                      ),
                                      child: const Icon(Icons.check),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                );
              }),
        )
      ],
    );
  }
}
