import 'package:flutter/material.dart';
//import 'package:caffe_app/custom/menu_drawer.dart';
import 'package:caffe_app/utility/constants.dart';

import 'package:caffe_app/mobile/home_page_mobile.dart';
import 'package:caffe_app/mobile/menu_page_mobile.dart';
import 'package:caffe_app/mobile/quiz_page_mobile.dart';
import 'package:caffe_app/mobile/loyalty_page_mobile.dart';
import 'package:caffe_app/mobile/settings_page_mobile.dart';
import 'package:caffe_app/mobile/table_page_mobile.dart';

class LayoutMobile extends StatefulWidget {
  const LayoutMobile({super.key});

  @override
  State<LayoutMobile> createState() => _LayoutMobileState();
}

class _LayoutMobileState extends State<LayoutMobile> {
  static const List<Widget> pages = [
    HomePageMobile(),
    MenuPageMobile(),
    TablePageMobile(),
    QuizPageMobile(),
    LoyaltyPageMobile(),
    SettingsPageMobile()
  ];
  static int currentPage = 0;
  String appBarText = "H O M E";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: primaryColor,
          iconTheme: const IconThemeData(
            color: secondaryColor,
          ),
          title: Text(
            appBarText,
            style: const TextStyle(color: secondaryColor),
          ),
        ),
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                DrawerHeader(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: Divider.createBorderSide(context,
                            color: Colors.transparent),
                      ),
                    ),
                    child: const Icon(
                      Icons.coffee,
                      size: 100,
                      color: primaryColor,
                    )),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Wrap(
                    runSpacing: 10,
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.home_rounded,
                          color: primaryColor,
                        ),
                        title: const Text("H O M E"),
                        onTap: () {
                          setState(() {
                            appBarText = "H O M E";
                            currentPage = 0;
                            Navigator.pop(context);
                          });
                        },
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.menu_book_rounded,
                          color: primaryColor,
                        ),
                        title: const Text("M E N U"),
                        onTap: () {
                          setState(() {
                            appBarText = "M E N U ";
                            currentPage = 1;
                            Navigator.pop(context);
                          });
                        },
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.table_restaurant_rounded,
                          color: primaryColor,
                        ),
                        title: const Text("T A B L E S"),
                        onTap: () {
                          setState(() {
                            appBarText = "T A B L E S";
                            currentPage = 2;
                            Navigator.pop(context);
                          });
                        },
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.quiz_rounded,
                          color: primaryColor,
                        ),
                        title: const Text("Q U I Z"),
                        onTap: () {
                          setState(() {
                            appBarText = "Q U I Z";
                            currentPage = 3;
                            Navigator.pop(context);
                          });
                        },
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.loyalty_rounded,
                          color: primaryColor,
                        ),
                        title: const Text("L O Y A L T Y"),
                        onTap: () {
                          setState(() {
                            appBarText = "L O Y A L T Y";
                            currentPage = 4;
                            Navigator.pop(context);
                          });
                        },
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.settings_rounded,
                          color: primaryColor,
                        ),
                        title: const Text("S E T T I N G S"),
                        onTap: () {
                          setState(() {
                            appBarText = "S E T T I N G S";
                            currentPage = 5;
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        body: pages[currentPage]);
  }
}
