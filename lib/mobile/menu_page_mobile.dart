import 'package:caffe_app/utility/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:caffe_app/models/menu_model.dart';

class MenuPageMobile extends StatefulWidget {
  const MenuPageMobile({super.key});

  @override
  State<MenuPageMobile> createState() => _MenuPageMobileState();
}

class _MenuPageMobileState extends State<MenuPageMobile> {
  final createCategoryNameController = TextEditingController();
  final createItemNameControler = TextEditingController();
  final createItemPriceControler = TextEditingController();

  @override
  void dispose() {
    createCategoryNameController.dispose();
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
              "CATEGORIES: ${Menu().menu.length}\nITEMS: ${Menu().itemCount()}",
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
                itemCount: Menu().getMenu().length + 1,
                itemBuilder: ((context, index) {
                  if (index == Menu().menu.length) {
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _createCategoryMenu();
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
                                Menu().getMenu()[index].name,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              children: [
                                ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: Menu()
                                            .getMenu()[index]
                                            .getCategory()
                                            .length +
                                        1,
                                    itemBuilder: (context, i) {
                                      if (Menu()
                                              .getMenu()[index]
                                              .getCategory()
                                              .length ==
                                          i) {
                                        return Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: InkWell(
                                            onTap: () {
                                              _createItemMenu(index);
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
                                          trailing: const Icon(
                                            Icons.water_drop_rounded,
                                            color: secondaryColor,
                                          ),
                                          title: Text(
                                            Menu()
                                                .getMenu()[index]
                                                .getCategory()[i]
                                                .name,
                                            style: const TextStyle(
                                                color: secondaryColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          subtitle: Text(
                                              "${Menu().getMenu()[index].getCategory()[i].price.toString()} €",
                                              style: const TextStyle(
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

  void _createCategoryMenu() {
    createCategoryNameController.text = "";
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
                  controller: createCategoryNameController,
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
                        setState(() {
                          Menu().addCategory(
                              MenuCategory(createCategoryNameController.text));
                        });
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

  void _createItemMenu(index) {
    createItemNameControler.text = "";
    createItemPriceControler.text = "";

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
                  "Create new item.",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                TextFormField(
                  controller: createItemNameControler,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Item name',
                  ),
                  autocorrect: false,
                ),
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                  controller: createItemPriceControler,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Price',
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
                        setState(() {
                          Menu().getMenu()[index].addItem(MenuItem(
                              createItemNameControler.text,
                              double.parse(createItemPriceControler.text)));
                        });
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
