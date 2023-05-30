import 'package:caffe_app/utility/constants.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

import 'package:caffe_app/custom/active_order_widget.dart';

import 'dart:convert';

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({super.key});

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  int activeOrderCount = 0;
  final ScrollController scrollController = ScrollController();

  var ordersRef = FirebaseDatabase.instance.ref().child('orders');

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
            "ACTIVE ORDERS: $activeOrderCount",
            style: const TextStyle(
                color: secondaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 15),
          ),
        ),
        SizedBox(
          height: 180,
          child: StreamBuilder(
            stream: ordersRef.onValue,
            builder: (context, snapshot) {
              activeOrderCount = snapshot.data?.snapshot.children.length ?? 0;
              var data = snapshot.data?.snapshot.value;
              if (data == null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text("Waiting for orders!"),
                      )
                    ],
                  ),
                );
              } else {
                var orders = data as Map;
                var keys = orders.keys.toList();

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: activeOrderCount,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ActiveOrderWidget(
                        onAccepted: () {
                          setState(() {
                            FirebaseDatabase.instance
                                .ref("orders/${keys[index]}/accepted")
                                .set(true);
                          });
                        },
                        onCompleted: () {
                          setState(() {
                            FirebaseDatabase.instance
                                .ref("orders/${keys[index]}")
                                .remove();
                          });
                        },
                        showOrder: () {},
                        table: orders[keys[index]]["table"],
                        acceptedMode: orders[keys[index]]["accepted"],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }

  void showOrderInfo() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(25),
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  ListTile(
                    leading: FittedBox(
                      child: Icon(
                        Icons.table_restaurant_rounded,
                        color: primaryColor,
                        size: 40,
                      ),
                    ),
                    title: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "23",
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
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
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Order: ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Empty!",
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: primaryColor, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
