import 'package:caffe_app/utility/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:caffe_app/models/menu_model.dart';
import 'package:caffe_app/custom/confirm_button.dart';
import 'package:caffe_app/custom/small_icon_button.dart';
import 'package:caffe_app/custom/confirm_delete_window.dart';
import 'package:caffe_app/custom/listview_add_button.dart';

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
  final editItemDiscountControler = TextEditingController();

  final _formKeyName = GlobalKey<FormState>();
  final _formKeyPrice = GlobalKey<FormState>();
  final _formKeyCategory = GlobalKey<FormState>();

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
            child: Column(
              children: [
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: Menu().getCategoryCount(),
                    itemBuilder: ((context, index) {
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
                                  Menu().getCategoryAt(index).getName(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                children: [
                                  ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: Menu()
                                          .getCategoryAt(index)
                                          .getItemCount(),
                                      itemBuilder: (context, i) {
                                        return ListTile(
                                          onTap: () {
                                            _showItem(Menu()
                                                .getCategoryAt(index)
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
                                                        .getCategoryAt(index)
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
                                                            .getCategoryAt(
                                                                index)
                                                            .removeItem(i);
                                                      });
                                                    });
                                                  })
                                            ],
                                          ),
                                          title: Text(
                                            Menu()
                                                .getCategoryAt(index)
                                                .getItem(i)
                                                .getName(),
                                            style: const TextStyle(
                                                color: secondaryColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          subtitle: Text(
                                              "${Menu().getCategoryAt(index).getItem(i).getPrice().toString()} €",
                                              style: const TextStyle(
                                                  color: secondaryColor,
                                                  fontWeight: FontWeight.w300)),
                                        );
                                      }),
                                  Padding(
                                    padding: const EdgeInsets.all(padding1),
                                    child: Row(
                                      children: [
                                        Flexible(
                                            flex: 4,
                                            child: ListViewAddButton(
                                              onTap: () {
                                                _createItem(index);
                                              },
                                            )),
                                        Flexible(
                                            flex: 1,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: SmallIconButton(
                                                  iconData: Icons.edit_rounded,
                                                  iconColor: secondaryColor,
                                                  onTap: () {
                                                    _showCategory(index, true);
                                                  }),
                                            )),
                                        Flexible(
                                            flex: 1,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: SmallIconButton(
                                                  iconData:
                                                      Icons.delete_rounded,
                                                  iconColor: dangerColor,
                                                  onTap: () {
                                                    confirmDeleteWindow(context,
                                                        "Are you sure you want to delete this category?",
                                                        () {
                                                      setState(() {
                                                        Menu().removeCategoryAt(
                                                            index);
                                                      });
                                                    });
                                                  }),
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ));
                    })),
                Padding(
                  padding: const EdgeInsets.all(padding1),
                  child: ListViewAddButton(
                    onTap: () {
                      setState(() {
                        _showCategory(-1, false);
                      });
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showCategory(int index, bool editCategory) {
    createCategoryNameController.text = "";

    if (editCategory) {
      createCategoryNameController.text = Menu().getCategoryAt(index).getName();
    }

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: const EdgeInsets.all(25),
              child: SingleChildScrollView(
                  child: Column(children: [
                Text(
                  (editCategory) ? "Edit category." : "Create new category.",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ),
                Form(
                  key: _formKeyCategory,
                  child: TextFormField(
                    controller: createCategoryNameController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'Category name',
                    ),
                    autocorrect: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter category name!';
                      }
                      return null;
                    },
                  ),
                ),
                ConfirmButton(onPress: () {
                  if (_formKeyCategory.currentState!.validate()) {
                    setState(() {
                      if (editCategory) {
                        Menu()
                            .getCategoryAt(index)
                            .setName(createCategoryNameController.text);
                      } else {
                        Menu().addCategory(
                            MenuCategory(createCategoryNameController.text));
                      }
                      Navigator.of(context).pop();
                    });
                  }
                }),
              ])),
            ),
          );
        });
  }

  void _createItem(index) {
    createItemNameControler.text = "";
    createItemPriceControler.text = "";

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: const EdgeInsets.all(25),
              child: SingleChildScrollView(
                child: Column(children: [
                  const Text(
                    "Create new item.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Form(
                    key: _formKeyName,
                    child: TextFormField(
                      controller: createItemNameControler,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Item name',
                      ),
                      autocorrect: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some name!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Form(
                    key: _formKeyPrice,
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      controller: createItemPriceControler,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Price',
                      ),
                      autocorrect: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some price!';
                        }
                        return null;
                      },
                    ),
                  ),
                  ConfirmButton(
                    onPress: () {
                      if (_formKeyName.currentState!.validate() &&
                          _formKeyPrice.currentState!.validate()) {
                        setState(() {
                          Menu().getCategoryAt(index).addItem(MenuItem(
                              createItemNameControler.text,
                              double.parse(createItemPriceControler.text)));
                          Navigator.of(context).pop();
                        });
                      }
                    },
                  )
                ]),
              ),
            ),
          );
        });
  }

  void _showItem(MenuItem item) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
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
            ),
          );
        });
  }

  void _editItem(MenuItem item) {
    editItemNameControler.text = "";
    editItemPriceControler.text = "";

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
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
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                    controller: editItemDiscountControler,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'Discount',
                    ),
                    autocorrect: false,
                  ),
                  ConfirmButton(onPress: () {
                    setState(() {
                      if (editItemPriceControler.text != "") {
                        item.setPrice(
                            double.parse(editItemPriceControler.text));
                      }
                      if (editItemNameControler.text != "") {
                        item.setName(editItemNameControler.text);
                      }
                      Navigator.of(context).pop();
                    });
                  })
                ]),
              ),
            ),
          );
        });
  }
}
