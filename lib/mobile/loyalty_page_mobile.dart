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
  final roadMapControler = TextEditingController();
  int roadMapValue = 0;

  String? _result;

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
        height: 150,
        child: ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: roadMapValue,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: InkWell(
                    onTap: () {
                      _AddRoadMapItem();
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "142",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 65),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
      SizedBox(
        height: 50,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Road Map Days: ",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            width: 30,
            child: TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
              keyboardType: TextInputType.number,
              controller: roadMapControler,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              decoration: const InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: '-',
              ),
              autocorrect: false,
              onChanged: (value) {
                setState(() {
                  roadMapValue = int.parse(value);
                });
              },
            ),
          ),
        ]),
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

  void _AddRoadMapItem() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(25),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const Text(
                    "Road map item #1",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Text(_result ?? '', style: TextStyle(fontSize: 18)),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                    ),
                    onPressed: () async {
                      var result = await showSearch<String>(
                        context: context,
                        delegate: CustomDelegate(),
                      );
                      setState(() => _result = result);
                      Navigator.pop(context);
                    },
                    child: Text('Search'),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class CustomDelegate extends SearchDelegate<String> {
  List<String> data = [
    'A',
    'B',
    'C',
    'A',
    'B',
    'C',
    'A',
    'B',
    'C',
    'A',
    'B',
    'C',
    'A',
    'B',
    'C',
    'A',
    'B',
    'C',
    'A',
    'B',
    'C',
    'A',
    'B',
    'C'
  ];

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
            icon: Icon(
              Icons.clear,
              color: primaryColor,
            ),
            onPressed: () => query = '')
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
      icon: Icon(
        Icons.chevron_left,
        color: primaryColor,
      ),
      onPressed: () => close(context, ''));

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    var listToShow;
    if (query.isNotEmpty)
      listToShow =
          data.where((e) => e.contains(query) && e.startsWith(query)).toList();
    else
      listToShow = data;

    return ListView.builder(
      itemCount: listToShow.length,
      itemBuilder: (_, i) {
        var item = listToShow[i];
        return ListTile(
          tileColor: primaryColor,
          hoverColor: subColor2,
          title: Text(
            item,
            style: TextStyle(color: secondaryColor),
          ),
          onTap: () => close(context, item),
        );
      },
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
