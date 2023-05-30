import 'dart:ui';

import 'package:caffe_app/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../custom/confirm_button.dart';
import '../custom/listview_add_button.dart';
import '../custom/road_map.dart';
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
  final roadMapControler = TextEditingController();
  final List<int> roadmap = [];

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
      const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "R O A D   M A P",
            style: TextStyle(
                color: primaryColor, fontSize: 24, fontWeight: FontWeight.w900),
          )),
      RoadMap(roadmap: roadmap),
      const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "L O Y A L  C U S T O M E R S",
            style: TextStyle(
                color: primaryColor, fontSize: 20, fontWeight: FontWeight.w900),
          )),
      Container(
        height: 250,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 0,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      title: Row(
                        children: [
                          Text(
                            "Ivan Ivić",
                            style: const TextStyle(
                                color: primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      trailing: Text(
                        "25 ◉",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    );
                  })),
            ),
          ),
        ),
      ),
      const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "F R E E  S T U F F",
            style: TextStyle(
                color: primaryColor, fontSize: 20, fontWeight: FontWeight.w900),
          )),
      Container(
        height: 300,
        child: ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 1,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 5),
              ),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {});
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: const FittedBox(
                            child: Icon(
                          Icons.add_rounded,
                          color: subColor,
                        )),
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Column(children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: const BoxDecoration(
                              color: secondaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Flexible(
                                    child: FittedBox(
                                      child: Icon(
                                        Icons.emoji_food_beverage_rounded,
                                        color: primaryColor,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        "1",
                                        style: const TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 50),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: const BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: ListTile(
                            title: Text(
                              "Jelen 0.5",
                              style: const TextStyle(
                                  color: secondaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                            trailing: Text(
                              "25 ◉",
                              style: const TextStyle(
                                  color: shinyColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  );
                }
              }),
        ),
      )
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
