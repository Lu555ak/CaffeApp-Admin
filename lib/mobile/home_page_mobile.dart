import 'package:caffe_app/models/menu_model.dart';
import 'package:caffe_app/utility/constants.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

import 'package:caffe_app/custom/active_order_widget.dart';

import 'package:caffe_app/custom/menu_item.dart';

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
            child: StreamBuilder(
              stream: ordersRef.onValue,
              builder: (context, snapshot) {
                return Text(
                  "ACTIVE ORDERS: ${snapshot.data?.snapshot.children.length ?? 0}",
                  style: const TextStyle(
                      color: secondaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                );
              },
            )),
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
                        showOrder: () {
                          Map<dynamic, dynamic> emptyMap = {};
                          _showOrderInfo(orders[keys[index]]["cart"],
                              orders[keys[index]]["creditCart"] ?? emptyMap);
                        },
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

  void _showOrderInfo(
      Map<dynamic, dynamic> orders, Map<dynamic, dynamic> creditOrder) {
    var keys = orders.keys.toList();
    var creditKeys = creditOrder.keys.toList();

    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(25),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "O R D E R",
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                  const Divider(
                    color: primaryColor,
                    indent: 10,
                    endIndent: 10,
                    thickness: 2,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: keys.length,
                    itemBuilder: (context, index) {
                      return MenuItemWidget(
                          menuItem: Menu().getMenuItemWithName(keys[index]),
                          cartMode: true,
                          cartAmount: orders[keys[index]],
                          onPress: () {});
                    },
                  ),
                  (creditOrder.isNotEmpty)
                      ? Column(
                          children: [
                            const Text(
                              "C R E D I T   O R D E R",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500),
                            ),
                            const Divider(
                              color: primaryColor,
                              indent: 10,
                              endIndent: 10,
                              thickness: 2,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: creditKeys.length,
                              itemBuilder: (context, index) {
                                return MenuItemWidget(
                                    menuItem: Menu()
                                        .getMenuItemWithName(creditKeys[index]),
                                    cartMode: true,
                                    cartAmount: creditOrder[creditKeys[index]],
                                    onPress: () {});
                              },
                            )
                          ],
                        )
                      : Container()
                ],
              ),
            ),
          );
        });
  }
}
