import 'package:caffe_app/utility/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:caffe_app/utility/constants.dart';

import 'package:caffe_app/mobile/home_page_mobile.dart';
import 'package:caffe_app/mobile/menu_page_mobile.dart';

import 'package:caffe_app/mobile/loyalty_page_mobile.dart';

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
    LoyaltyPageMobile(),
  ];
  static int currentPage = 0;
  String appBarText = "H O M E";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: secondaryColor,
        appBar: AppBar(
          elevation: 8,
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
                        bottom: Divider.createBorderSide(context, color: Colors.transparent),
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
                        title: Text(AppLocalizations.of(context).translate("home_text")),
                        onTap: () {
                          setState(() {
                            appBarText = AppLocalizations.of(context).translate("home_text");
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
                        title: Text(AppLocalizations.of(context).translate("menu_text")),
                        onTap: () {
                          setState(() {
                            appBarText = AppLocalizations.of(context).translate("menu_text");
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
                        title: Text(AppLocalizations.of(context).translate("tables_text")),
                        onTap: () {
                          setState(() {
                            appBarText = AppLocalizations.of(context).translate("tables_text");
                            currentPage = 2;
                            Navigator.pop(context);
                          });
                        },
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.loyalty_rounded,
                          color: primaryColor,
                        ),
                        title: Text(AppLocalizations.of(context).translate("loyalty_text")),
                        onTap: () {
                          setState(() {
                            appBarText = AppLocalizations.of(context).translate("loyalty_text");
                            currentPage = 3;
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
