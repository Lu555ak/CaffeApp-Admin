import 'package:caffe_app/utility/app_localizations.dart';
import 'package:caffe_app/utility/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:caffe_app/models/menu_model.dart';
import 'package:caffe_app/custom/confirm_button.dart';

import 'package:caffe_app/custom/confirm_delete_window.dart';
import 'package:caffe_app/custom/circle_icon_button.dart';
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
  final _showItemCreditPriceControler = TextEditingController();

  final _searchBarController = TextEditingController();

  final _showItemFormKey = GlobalKey<FormState>();

  bool searchBarFilter(String input) {
    String searchBarText = _searchBarController.text.replaceAll(RegExp(r"\s+"), "").toLowerCase();
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
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).translate("search_text"),
                hintText: AppLocalizations.of(context).translate("search_text"),
                prefixIcon: const Icon(Icons.search),
                prefixIconColor: subColor2,
                labelStyle: const TextStyle(color: subColor2),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: subColor2),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                focusedBorder: const OutlineInputBorder(
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
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
            child: Column(
              children: [
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: Menu().getMenuLength,
                    itemBuilder: ((context, index) {
                      if (searchBarFilter(Menu().getMenuItemAt(index).getName)) {
                        return ListTile(
                            title: Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: Text(
                                    Menu().getMenuItemAt(index).getName.toUpperCase(),
                                    style: const TextStyle(color: subColor2, fontSize: 18, fontWeight: FontWeight.w900),
                                  ),
                                ),
                                DiscountComponent(discount: Menu().getMenuItemAt(index).getDiscount)
                              ],
                            ),
                            subtitle: (Menu().getMenuItemAt(index).getDiscount == 0)
                                ? Text(
                                    "${Menu().getMenuItemAt(index).getPrice}€",
                                    style: const TextStyle(color: subColor2, fontSize: 15, fontWeight: FontWeight.w400),
                                  )
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("${Menu().getMenuItemAt(index).getPrice}€",
                                          style: const TextStyle(
                                              color: subColor2,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              decoration: TextDecoration.lineThrough,
                                              decorationThickness: 3)),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                            "${Menu().getMenuItemAt(index).getPriceDiscount.toStringAsFixed(2)}€",
                                            style: const TextStyle(
                                                color: dangerColor, fontSize: 15, fontWeight: FontWeight.w500)),
                                      )
                                    ],
                                  ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                (Menu().getMenuItemAt(index).getFeatured) ? const Icon(Icons.star) : Container(),
                                CircleIconButton(
                                  onPress: () {
                                    _showItem(index, true);
                                  },
                                )
                              ],
                            ));
                      } else {
                        return Container();
                      }
                    })),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListViewAddButton(
                    boxColor: primaryColor,
                    onTap: () {
                      _showItem(-1, false);
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showItem(int index, bool editMode) {
    _showItemNameControler.text = "";
    _showItemPriceControler.text = "";
    _showItemCreditPriceControler.text = "";
    double discountSlider = 0;
    bool featuredSwitch = false;

    if (editMode) {
      MenuItem menuItem = Menu().getMenuItemAt(index);
      _showItemNameControler.text = menuItem.getName;
      _showItemPriceControler.text = menuItem.getPrice.toString();
      _showItemCreditPriceControler.text = menuItem.getCreditPrice.toString();
      discountSlider = menuItem.getDiscount.toDouble();
      featuredSwitch = menuItem.getFeatured;
    }

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setStateInner) {
              return Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  padding: const EdgeInsets.all(25),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _showItemFormKey,
                      child: Column(children: [
                        Text(
                          (!editMode)
                              ? AppLocalizations.of(context).translate("create_new_item_text")
                              : AppLocalizations.of(context).translate("edit_item_text"),
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            controller: _showItemNameControler,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: AppLocalizations.of(context).translate("name_text"),
                            ),
                            autocorrect: false,
                            validator: (value) {
                              if (Menu().nameExists(value ?? "") && editMode == false) {
                                return AppLocalizations.of(context).translate("warning_name_in");
                              }
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context).translate("warning_enter_name");
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                            ],
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            controller: _showItemPriceControler,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: AppLocalizations.of(context).translate("price_text"),
                            ),
                            autocorrect: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context).translate("warning_enter_price");
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                            ],
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            controller: _showItemCreditPriceControler,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: AppLocalizations.of(context).translate("credit_price_text"),
                            ),
                            autocorrect: false,
                          ),
                        ),
                        Text(
                          "${AppLocalizations.of(context).translate("discount_text")}${discountSlider.toInt()}%",
                          style: const TextStyle(fontSize: 15),
                        ),
                        Slider(
                          min: 0,
                          max: 100,
                          divisions: 100,
                          activeColor: primaryColor,
                          secondaryActiveColor: subColor2,
                          inactiveColor: subColor2,
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
                          title: Text(
                            AppLocalizations.of(context).translate("featured_text"),
                            style: const TextStyle(color: subColor2, fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                flex: 5,
                                child: ConfirmButton(
                                  alignCenter: false,
                                  onPress: () {
                                    if (_showItemFormKey.currentState!.validate()) {
                                      if (editMode) {
                                        setState(() {
                                          MenuItem menuItem = Menu().getMenuItemAt(index);
                                          menuItem.setName = _showItemNameControler.text;
                                          menuItem.setPrice = double.parse(_showItemPriceControler.text);
                                          menuItem.setDiscount = discountSlider.toInt();
                                          menuItem.setFeatured = featuredSwitch;
                                          menuItem.setCreditPrice = int.parse(_showItemCreditPriceControler.text);
                                        });
                                      } else {
                                        setState(() {
                                          Menu().addMenuItem(MenuItem(
                                              _showItemNameControler.text,
                                              double.parse(_showItemPriceControler.text),
                                              discountSlider.toInt(),
                                              featuredSwitch,
                                              int.parse(_showItemCreditPriceControler.text)));
                                        });
                                      }
                                      Menu().saveToDatabase();
                                      Navigator.pop(context);
                                    }
                                  },
                                ),
                              ),
                              Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: (editMode)
                                      ? CircleIconButton(
                                          buttonColor: dangerColor,
                                          iconData: Icons.delete_rounded,
                                          onPress: () {
                                            confirmDeleteWindow(
                                                context, AppLocalizations.of(context).translate("item_delete_text"),
                                                () {
                                              setState(() {
                                                Menu().removeMenuItemAt(index);
                                                Menu().saveToDatabase();
                                                Navigator.pop(context);
                                              });
                                            });
                                          },
                                        )
                                      : Container())
                            ],
                          ),
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
}
