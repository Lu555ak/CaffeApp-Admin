import 'package:caffe_app/utility/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:caffe_app/models/menu_model.dart';
import 'package:caffe_app/custom/confirm_button.dart';
import 'package:caffe_app/custom/small_icon_button.dart';
import 'package:caffe_app/custom/confirm_delete_window.dart';

class MenuPageMobile extends StatefulWidget {
  const MenuPageMobile({super.key});

  @override
  State<MenuPageMobile> createState() => _MenuPageMobileState();
}

class _MenuPageMobileState extends State<MenuPageMobile> {
  final createCategoryNameController = TextEditingController();

  final createItemNameControler = TextEditingController();
  final createItemPriceControler = TextEditingController();

  final editItemNameControler = TextEditingController();
  final editItemPriceControler = TextEditingController();

  @override
  void dispose() {
    createCategoryNameController.dispose();
    createItemNameControler.dispose();
    createItemPriceControler.dispose();
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
              "CATEGORIES: ${Menu().getCategoryCount()}\nITEMS: ${Menu().getTotalItemCount()}",
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
                itemCount: Menu().getCategoryCount() + 1,
                itemBuilder: ((context, index) {
                  if (index == Menu().getCategoryCount()) {
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _createCategory();
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
                                Menu().getCategory(index).getName(),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              children: [
                                ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: Menu()
                                            .getCategory(index)
                                            .getItemCount() +
                                        1,
                                    itemBuilder: (context, i) {
                                      if (Menu()
                                              .getCategory(index)
                                              .getItemCount() ==
                                          i) {
                                        return Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: InkWell(
                                            onTap: () {
                                              _createItem(index);
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
                                          onTap: () {
                                            _showItem(Menu()
                                                .getCategory(index)
                                                .getItem(i));
                                          },
                                          selectedTileColor: secondaryColor,
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SmallIconButton(
                                                  iconData: Icons.edit_rounded,
                                                  iconColor: secondaryColor,
                                                  iconSize: 25,
                                                  onTap: () {
                                                    _editItem(Menu()
                                                        .getCategory(index)
                                                        .getItem(i));
                                                  }),
                                              SmallIconButton(
                                                  iconData:
                                                      Icons.delete_rounded,
                                                  iconColor: dangerColor,
                                                  iconSize: 25,
                                                  onTap: () {
                                                    confirmDeleteWindow(context,
                                                        "Are you sure you want to delete this item?",
                                                        () {
                                                      setState(() {
                                                        Menu()
                                                            .getCategory(index)
                                                            .removeItem(i);
                                                      });
                                                    });
                                                  })
                                            ],
                                          ),
                                          title: Text(
                                            Menu()
                                                .getCategory(index)
                                                .getItem(i)
                                                .getName(),
                                            style: const TextStyle(
                                                color: secondaryColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          subtitle: Text(
                                              "${Menu().getCategory(index).getItem(i).getPrice().toString()} €",
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

  void _createCategory() {
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
              ConfirmButton(onPress: () {
                setState(() {
                  Menu().addCategory(
                      MenuCategory(createCategoryNameController.text));
                });
              })
            ])),
          );
        });
  }

  void _createItem(index) {
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
                ConfirmButton(onPress: () {
                  setState(() {
                    Menu().getCategory(index).addItem(MenuItem(
                        createItemNameControler.text,
                        double.parse(createItemPriceControler.text)));
                  });
                })
              ]),
            ),
          );
        });
  }

  void _showItem(MenuItem item) {
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
                  ListTile(
                    leading: const FittedBox(
                      child: Icon(
                        Icons.water_drop_rounded,
                        color: primaryColor,
                        size: 40,
                      ),
                    ),
                    title: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item.getName(),
                        style: const TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 30),
                      ),
                    ),
                    subtitle: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${item.getPrice()} €",
                        style: const TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w200,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  const Divider(
                    color: primaryColor,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Description: ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc accumsan urna nec enim rhoncus cursus.",
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

  void _editItem(MenuItem item) {
    editItemNameControler.text = "";
    editItemPriceControler.text = "";

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
                  "Edit item.",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                TextFormField(
                  controller: editItemNameControler,
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
                  controller: editItemPriceControler,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Price',
                  ),
                  autocorrect: false,
                ),
                ConfirmButton(onPress: () {
                  setState(() {
                    if (editItemPriceControler.text != "") {
                      item.setPrice(double.parse(editItemPriceControler.text));
                    }
                    if (editItemNameControler.text != "") {
                      item.setName(editItemNameControler.text);
                    }
                  });
                })
              ]),
            ),
          );
        });
  }
}
