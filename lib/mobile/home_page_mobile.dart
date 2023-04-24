import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../utility/constants.dart';

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({super.key});

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: secondaryColor,
        iconTheme: const IconThemeData(
          color: primaryColor,
        ),
        title: const Text(
          "A P P B A R",
          style: TextStyle(color: primaryColor),
        ),
      ),
      drawer: Drawer(
        backgroundColor: secondaryColor,
        child: Column(children: const [
          DrawerHeader(
              child: Icon(
            Icons.coffee_rounded,
            size: 100,
            color: primaryColor,
          )),
          ListTile(
            leading: Icon(Icons.table_restaurant_rounded, color: primaryColor),
            title: Text(
              "T A B L E S",
              style: TextStyle(fontSize: 15, color: primaryColor),
            ),
          ),
          ListTile(
            leading: Icon(Icons.menu_book_rounded, color: primaryColor),
            title: Text(
              "M E N U",
              style: TextStyle(fontSize: 15, color: primaryColor),
            ),
          ),
          ListTile(
            leading: Icon(Icons.quiz_rounded, color: primaryColor),
            title: Text(
              "Q U I Z",
              style: TextStyle(fontSize: 15, color: primaryColor),
            ),
          ),
          ListTile(
            leading: Icon(Icons.loyalty_rounded, color: primaryColor),
            title: Text(
              "L O Y A L T Y",
              style: TextStyle(fontSize: 15, color: primaryColor),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings_rounded, color: primaryColor),
            title: Text(
              "S E T T I N G S",
              style: TextStyle(fontSize: 15, color: primaryColor),
            ),
          ),
        ]),
      ),
      bottomNavigationBar: CurvedNavigationBar(
          height: 62,
          animationDuration: const Duration(milliseconds: 300),
          color: secondaryColor,
          backgroundColor: Colors.transparent,
          items: const [
            Icon(Icons.home_rounded),
          ]),
    );
  }
}
