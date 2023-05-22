import 'package:caffe_app/utility/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:caffe_app/models/menu_model.dart';
import 'package:caffe_app/custom/confirm_button.dart';
import 'package:caffe_app/custom/small_icon_button.dart';
import 'package:caffe_app/custom/confirm_delete_window.dart';
import 'package:caffe_app/custom/listview_add_button.dart';
import 'package:caffe_app/custom/discount_component.dart';

class MenuPageMobile extends StatefulWidget {
  const MenuPageMobile({super.key});

  @override
  State<MenuPageMobile> createState() => _MenuPageMobileState();
}

class _MenuPageMobileState extends State<MenuPageMobile> {
  final _createCategoryNameController = TextEditingController();
  final _showItemNameControler = TextEditingController();
  final _showItemPriceControler = TextEditingController();

  final _searchBarController = TextEditingController();

  final _showItemFormKey = GlobalKey<FormState>();

  bool searchBarFilter(String input) {
    String searchBarText =
        _searchBarController.text.replaceAll(RegExp(r"\s+"), "").toLowerCase();
    String itemName = input.replaceAll(RegExp(r"\s+"), "").toLowerCase();

    if (searchBarText.isEmpty || itemName.contains(searchBarText)) {
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    _createCategoryNameController.dispose();
    _showItemNameControler.dispose();
    _showItemPriceControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _searchBarController,
              decoration: const InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                prefixIconColor: primaryColor,
                labelStyle: TextStyle(color: primaryColor),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: subColor2),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 4, color: subColor2),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
              ),
              autocorrect: false,
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
            child: Column(
              children: [
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: Menu().getMenuLength,
                    itemBuilder: ((context, index) {
                      if (searchBarFilter(
                          Menu().getMenuItemAt(index).getName)) {
                        return ListTile(
                            title: Row(
                              children: [
                                Text(
                                  Menu().getMenuItemAt(index).getName,
                                  style: const TextStyle(
                                      color: primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: DiscountComponent(
                                        discount: Menu()
                                            .getMenuItemAt(index)
                                            .getDiscount))
                              ],
                            ),
                            subtitle: (Menu()
                                        .getMenuItemAt(index)
                                        .getDiscount ==
                                    0)
                                ? Text(
                                    "${Menu().getMenuItemAt(index).getPrice}€",
                                    style: const TextStyle(
                                        color: primaryColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  )
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                          "${Menu().getMenuItemAt(index).getPrice}€",
                                          style: const TextStyle(
                                              color: primaryColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationThickness: 3)),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                            "${Menu().getMenuItemAt(index).getPriceDiscount}€",
                                            style: const TextStyle(
                                                color: dangerColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500)),
                                      )
                                    ],
                                  ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                (Menu().getMenuItemAt(index).getFeatured)
                                    ? const Icon(Icons.star)
                                    : Container(),
                                ElevatedButton(
                                  onPressed: () {
                                    _showItem(index, true);
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        const CircleBorder()),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.all(5)),
                                    backgroundColor:
                                        MaterialStateProperty.all(primaryColor),
                                    overlayColor: MaterialStateProperty
                                        .resolveWith<Color?>((states) {
                                      if (states
                                          .contains(MaterialState.pressed)) {
                                        return subColor2;
                                      }
                                      return null;
                                    }),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: secondaryColor,
                                  ),
                                )
                              ],
                            ));
                      } else {
                        return Container();
                      }
                    })),
                Padding(
                  padding: const EdgeInsets.all(padding1),
                  child: ListViewAddButton(
                    boxColor: primaryColor,
                    onTap: () {
                      _showItem(-1, false);
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

  /*void _showCategory(int index, bool editCategory) {
    _createCategoryNameController.text = "";

    if (editCategory) {
      _createCategoryNameController.text =
          Menu().getCategoryAt(index).getName();
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
                    controller: _createCategoryNameController,
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
                            .setName(_createCategoryNameController.text);
                      } else {
                        Menu().addCategory(
                            MenuCategory(_createCategoryNameController.text));
                      }
                      Navigator.of(context).pop();
                    });
                  }
                }),
              ])),
            ),
          );
        });
  }*/

  void _showItem(int index, bool editMode) {
    _showItemNameControler.text = "";
    _showItemPriceControler.text = "";
    double discountSlider = 0;
    bool featuredSwitch = false;

    if (editMode) {
      MenuItem menuItem = Menu().getMenuItemAt(index);
      _showItemNameControler.text = menuItem.getName;
      _showItemPriceControler.text = menuItem.getPrice.toString();
      discountSlider = menuItem.getDiscount.toDouble();
      featuredSwitch = menuItem.getFeatured;
    }

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setStateInner) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  padding: const EdgeInsets.all(25),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _showItemFormKey,
                      child: Column(children: [
                        const Text(
                          "Create new item.",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            controller: _showItemNameControler,
                            textAlign: TextAlign.left,
                            decoration: const InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: 'Item name',
                            ),
                            autocorrect: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a name!';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,2}')),
                            ],
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            controller: _showItemPriceControler,
                            textAlign: TextAlign.left,
                            decoration: const InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: 'Price',
                            ),
                            autocorrect: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a price!';
                              }
                              return null;
                            },
                          ),
                        ),
                        Text(
                          "Discount: ${discountSlider.toInt()}%",
                          style: const TextStyle(fontSize: 15),
                        ),
                        Slider(
                          min: 0,
                          max: 100,
                          divisions: 100,
                          activeColor: primaryColor,
                          secondaryActiveColor: subColor2,
                          inactiveColor: subColor,
                          value: discountSlider,
                          onChanged: (value) {
                            setStateInner(() {
                              discountSlider = value;
                            });
                          },
                        ),
                        ListTile(
                          trailing: Switch(
                            value: featuredSwitch,
                            onChanged: (value) {
                              setStateInner(() {
                                featuredSwitch = value;
                              });
                            },
                            activeColor: primaryColor,
                            activeTrackColor: subColor2,
                          ),
                          title: const Text(
                            "Featured",
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        ConfirmButton(
                          onPress: () {
                            if (_showItemFormKey.currentState!.validate()) {
                              if (editMode) {
                                setState(() {
                                  MenuItem menuItem =
                                      Menu().getMenuItemAt(index);
                                  menuItem.setName =
                                      _showItemNameControler.text;
                                  menuItem.setPrice = double.parse(
                                      _showItemPriceControler.text);
                                  menuItem.setDiscount = discountSlider.toInt();
                                  menuItem.setFeatured = featuredSwitch;
                                });
                              } else {
                                setState(() {
                                  Menu().addMenuItem(MenuItem(
                                      _showItemNameControler.text,
                                      double.parse(
                                          _showItemPriceControler.text),
                                      discountSlider.toInt(),
                                      featuredSwitch));
                                });
                              }
                              Navigator.pop(context);
                            }
                          },
                        )
                      ]),
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
/*
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
    _editItemNameControler.text = "";
    _editItemPriceControler.text = "";

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
                    controller: _editItemNameControler,
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
                    controller: _editItemPriceControler,
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
                    controller: _editItemDiscountControler,
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
                      if (_editItemPriceControler.text != "") {
                        item.setPrice(
                            double.parse(_editItemPriceControler.text));
                      }
                      if (_editItemNameControler.text != "") {
                        item.setName(_editItemNameControler.text);
                      }
                      Navigator.of(context).pop();
                    });
                  })
                ]),
              ),
            ),
          );
        });
  }*/
}
