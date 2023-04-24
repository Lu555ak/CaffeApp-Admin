import 'package:caffe_app/utility/constants.dart';
import 'package:flutter/material.dart';

class TablePageMobile extends StatefulWidget {
  const TablePageMobile({super.key});

  @override
  State<TablePageMobile> createState() => _TablePageMobileState();
}

class _TablePageMobileState extends State<TablePageMobile> {
  List<int> exampleList = [];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: exampleList.length + 1,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          if (index == exampleList.length) {
            return Padding(
              padding: const EdgeInsets.all(25.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    exampleList.add(exampleList.length + 1);
                  });
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                            color: primaryColor,
                            spreadRadius: 3,
                            blurRadius: 4,
                            offset: Offset(1, 1))
                      ]),
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
                    color: secondaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                          color: primaryColor,
                          spreadRadius: 3,
                          blurRadius: 4,
                          offset: Offset(1, 1))
                    ]),
                child: Row(children: [
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Flexible(
                            child: FittedBox(
                              child: Icon(
                                Icons.table_restaurant_outlined,
                                color: secondaryColor,
                                size: 40,
                              ),
                            ),
                          ),
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                exampleList[index].toString(),
                                style: const TextStyle(
                                    color: secondaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 50),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              showEditTableSheet();
                            },
                            customBorder: const CircleBorder(),
                            splashColor: subColor,
                            child: const FittedBox(
                              child: Icon(
                                Icons.edit_rounded,
                                color: primaryColor,
                                size: 35,
                              ),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                exampleList.remove(index + 1);
                              });
                            },
                            customBorder: const CircleBorder(),
                            splashColor: subColor,
                            child: const FittedBox(
                              child: Icon(
                                Icons.delete_rounded,
                                color: Color.fromARGB(255, 136, 51, 51),
                                size: 35,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            );
          }
        });
  }

  void showEditTableSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: secondaryColor,
            child: Column(
              children: const [
                ListTile(
                  title: Text("EDIT ME"),
                )
              ],
            ),
          );
        });
  }
}
