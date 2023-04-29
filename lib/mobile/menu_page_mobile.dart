import 'package:caffe_app/utility/constants.dart';
import 'package:flutter/material.dart';

class MenuPageMobile extends StatefulWidget {
  const MenuPageMobile({super.key});

  @override
  State<MenuPageMobile> createState() => _MenuPageMobileState();
}

class _MenuPageMobileState extends State<MenuPageMobile> {
  List<List<int>> exampleList = [];

  final createCategoryController = TextEditingController();

  @override
  void dispose() {
    createCategoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
              "CATEGORIES: ${exampleList.length}\nITEMS: ${_itemsCount()}",
              style: const TextStyle(
                  color: secondaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: exampleList.length + 1,
                itemBuilder: ((context, index) {
                  if (index == exampleList.length) {
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _createCategoryMenu();
                            //exampleList.add(List.empty(growable: true));
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: const Icon(
                            Icons.add_rounded,
                            color: subColor,
                            size: 35,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Theme(
                          data: ThemeData(
                              colorScheme: ColorScheme.fromSwatch()
                                  .copyWith(primary: secondaryColor)),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: ExpansionTile(
                              backgroundColor: primaryColor,
                              title: Text(
                                "Category ${index + 1}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              children: [
                                ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: exampleList[index].length + 1,
                                    itemBuilder: (context, i) {
                                      if (exampleList[index].length == i) {
                                        return Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                exampleList[index].add(
                                                    exampleList[index].length +
                                                        1);
                                              });
                                            },
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: secondaryColor,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                              ),
                                              child: const Icon(
                                                Icons.add_rounded,
                                                color: primaryColor,
                                                size: 25,
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return ListTile(
                                          selectedTileColor: secondaryColor,
                                          trailing: Icon(
                                            Icons.water_drop_rounded,
                                            color: secondaryColor,
                                          ),
                                          title: Text(
                                            "Item ${exampleList[index][i]}",
                                            style: TextStyle(
                                                color: secondaryColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          subtitle: Text("10€",
                                              style: TextStyle(
                                                  color: secondaryColor,
                                                  fontWeight: FontWeight.w200)),
                                        );
                                      }
                                    })
                              ],
                            ),
                          ),
                        ));
                  }
                })),
          )
        ],
      ),
    );
  }

  int _itemsCount() {
    int sum = 0;
    for (var element in exampleList) {
      sum += element.length;
    }
    return sum;
  }

  void _createCategoryMenu() {
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
                  "Create new category.",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                TextFormField(
                  controller: createCategoryController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Category name',
                  ),
                  autocorrect: false,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(neutralColor)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: secondaryColor),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(primaryColor)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Create",
                        style: TextStyle(color: secondaryColor),
                      ),
                    ),
                  ],
                )
              ]),
            ),
          );
        });
  }
}
