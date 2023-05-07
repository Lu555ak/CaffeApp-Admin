import 'package:caffe_app/utility/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({super.key});

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  final ScrollController scrollController = ScrollController();

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
          child: const Text(
            "ACTIVE ORDERS: ",
            style: TextStyle(
                color: secondaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 15),
          ),
        ),
        SizedBox(
          height: 200,
          width: double.infinity,
          child: ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 150,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
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
                            SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          padding: const EdgeInsets.all(25),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                ListTile(
                                                  leading: FittedBox(
                                                    child: Icon(
                                                      Icons
                                                          .table_restaurant_rounded,
                                                      color: primaryColor,
                                                      size: 40,
                                                    ),
                                                  ),
                                                  title: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "23",
                                                      style: TextStyle(
                                                          color: primaryColor,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 30),
                                                    ),
                                                  ),
                                                ),
                                                Divider(
                                                  color: primaryColor,
                                                ),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      "Order: ",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          color: primaryColor,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Text(
                                                    "Empty!",
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
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
                                const Icon(
                                  Icons.access_time_filled,
                                  color: subColor2,
                                  size: 33.5,
                                ),
                                const Text(" 2s"),
                                const Divider(
                                  color: primaryColor,
                                  indent: 5,
                                  endIndent: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 40),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          const CircleBorder()),
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.all(10)),
                                      backgroundColor:
                                          MaterialStateProperty.all(subColor2),
                                      overlayColor: MaterialStateProperty
                                          .resolveWith<Color?>((states) {
                                        if (states
                                            .contains(MaterialState.pressed)) {
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
                      ),
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
