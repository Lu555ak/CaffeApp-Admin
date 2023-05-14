import 'dart:ui';

import 'package:caffe_app/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../custom/confirm_button.dart';
import '../custom/listview_add_button.dart';
import '../custom/small_icon_button.dart';

class LoyaltyPageMobile extends StatefulWidget {
  const LoyaltyPageMobile({super.key});

  @override
  State<LoyaltyPageMobile> createState() => _LoyaltyPageMobileState();
}

class _LoyaltyPageMobileState extends State<LoyaltyPageMobile> {
  final formulaEditPriceControler = TextEditingController();
  final formulaEditPointsControler = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    formulaEditPriceControler.dispose();
    formulaEditPointsControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
            color: subColor2,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "FORMULA: ",
              style: const TextStyle(
                  color: secondaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
            Text(
              "1 € = 1 ◉",
              style: const TextStyle(
                  color: shinyColor, fontWeight: FontWeight.w800, fontSize: 15),
            ),
            SmallIconButton(
                iconData: Icons.edit,
                iconColor: secondaryColor,
                iconSize: 25,
                onTap: () {
                  _formulaEdit();
                }),
          ],
        ),
      ),
      SizedBox(
        height: 200,
        width: double.infinity,
        child: ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.vertical,
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
      ),
      ListViewAddButton(
        onTap: () {
          setState(() {});
        },
      ),
    ]));
  }

  void _formulaEdit() {
    formulaEditPriceControler.text = "";
    formulaEditPointsControler.text = "";

    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(25),
            child: SingleChildScrollView(
              child: Column(children: [
                const Text(
                  "Edit formula.",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 22,
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(2),
                            ],
                            keyboardType: TextInputType.number,
                            controller: formulaEditPriceControler,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: '-',
                            ),
                            autocorrect: false,
                          ),
                        ),
                        Text(
                          "€ = ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 22,
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(2),
                            ],
                            keyboardType: TextInputType.number,
                            controller: formulaEditPointsControler,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: '-',
                            ),
                            autocorrect: false,
                          ),
                        ),
                        Text(
                          "◉",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ]),
                ),
                ConfirmButton(onPress: () {
                  setState(() {
                    if (formulaEditPriceControler.text != "") {}
                    if (formulaEditPointsControler.text != "") {}
                    Navigator.of(context).pop();
                  });
                })
              ]),
            ),
          );
        });
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
