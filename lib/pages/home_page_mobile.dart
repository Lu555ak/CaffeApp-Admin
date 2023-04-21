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
      drawer: const Drawer(backgroundColor: secondaryColor),
      bottomNavigationBar: CurvedNavigationBar(
          height: 62,
          animationDuration: const Duration(milliseconds: 300),
          color: secondaryColor,
          backgroundColor: Colors.transparent,
          items: const [
            Icon(Icons.table_restaurant_rounded),
            Icon(Icons.menu_book_rounded),
            Icon(Icons.loyalty_rounded),
            Icon(Icons.quiz_rounded),
          ]),
    );
  }
}
