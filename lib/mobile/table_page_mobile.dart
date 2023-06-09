import 'package:caffe_app/utility/app_localizations.dart';
import 'package:caffe_app/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:caffe_app/models/tables_model.dart';
import 'package:caffe_app/custom/confirm_delete_window.dart';
import 'package:caffe_app/custom/small_icon_button.dart';
import 'package:caffe_app/custom/confirm_button.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class TablePageMobile extends StatefulWidget {
  const TablePageMobile({super.key});

  @override
  State<TablePageMobile> createState() => _TablePageMobileState();
}

class _TablePageMobileState extends State<TablePageMobile> {
  final ScreenshotController screenshotController = ScreenshotController();
  final _tableIdController = TextEditingController();
  final _tableDescriptionController = TextEditingController();
  final _formKeyId = GlobalKey<FormState>();
  final _formKeyDescription = GlobalKey<FormState>();

  @override
  void dispose() {
    _tableIdController.dispose();
    _tableDescriptionController.dispose();
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
            decoration: BoxDecoration(
              color: subColor,
              borderRadius:
                  const BorderRadius.only(bottomLeft: Radius.circular(25.0), bottomRight: Radius.circular(25.0)),
              boxShadow: [
                BoxShadow(
                  color: subColor2.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(-5, 5),
                ),
              ],
            ),
            child: Text(
              AppLocalizations.of(context).translate("active_tables_text") + Tables().getTableCount().toString(),
              style: const TextStyle(color: subColor2, fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ),
          GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: Tables().getTableCount() + 1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                if (index == Tables().getTableCount()) {
                  return Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _createTableSheet(-1, false);
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: subColor,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: const FittedBox(
                            child: Icon(
                          Icons.add_rounded,
                          color: primaryColor,
                        )),
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: subColor,
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        boxShadow: [
                          BoxShadow(
                            color: subColor2.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(-5, 5),
                          ),
                        ],
                      ),
                      child: Row(children: [
                        InkWell(
                          onTap: () {
                            showTableSheet(Tables().getTable(index));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: const BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
                                    Tables().getTable(index).getId().toString(),
                                    style: const TextStyle(
                                        color: secondaryColor, fontWeight: FontWeight.w500, fontSize: 50),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SmallIconButton(
                                  iconData: Icons.edit_rounded,
                                  iconColor: subColor2,
                                  onTap: () {
                                    _createTableSheet(index, true);
                                  }),
                              SmallIconButton(
                                  iconData: Icons.delete_rounded,
                                  iconColor: dangerColor,
                                  onTap: () {
                                    confirmDeleteWindow(
                                        context, AppLocalizations.of(context).translate("table_delete_text"), () {
                                      setState(() {
                                        Tables().removeTable(index);
                                      });
                                      Tables().saveToDatabase();
                                    });
                                  }),
                            ],
                          ),
                        )
                      ]),
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }

  void showTableSheet(CaffeTable table) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: const EdgeInsets.all(25),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      leading: const FittedBox(
                        child: Icon(
                          Icons.table_restaurant_rounded,
                          color: subColor2,
                          size: 50,
                        ),
                      ),
                      title: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          table.getId().toString(),
                          style: const TextStyle(color: subColor2, fontWeight: FontWeight.w500, fontSize: 44),
                        ),
                      ),
                    ),
                    const Divider(
                      color: subColor2,
                      thickness: 3,
                    ),
                    SizedBox(
                        height: 150,
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        "${AppLocalizations.of(context).translate("description_text")}: ",
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            color: subColor2, fontWeight: FontWeight.w500, fontSize: 20),
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        table.getDescription(),
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(color: subColor2, fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                                fit: FlexFit.tight,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Screenshot(
                                      controller: screenshotController,
                                      child: QrImageView(
                                        data: table.generateQRCodeData(),
                                        version: QrVersions.auto,
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        )),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _createTableSheet(int index, bool editTable) {
    _tableDescriptionController.text = "";
    _tableIdController.text = "";

    if (editTable == true) {
      _tableIdController.text = Tables().getTable(index).getId().toString();
      _tableDescriptionController.text = Tables().getTable(index).getDescription();
    }

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: const EdgeInsets.all(25),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      (editTable)
                          ? AppLocalizations.of(context).translate("edit_table_text")
                          : AppLocalizations.of(context).translate("create_table_text"),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    Form(
                      key: _formKeyId,
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        controller: _tableIdController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: 'ID',
                        ),
                        autocorrect: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context).translate("warning_valid_id");
                          } else if (int.parse(value) < 1 || int.parse(value) > 999) {
                            return AppLocalizations.of(context).translate("warning_id_range");
                          } else if (Tables().idExists(int.parse(value))) {
                            if (editTable && int.parse(value) == Tables().getTable(index).getId()) {
                              return null;
                            } else {
                              return AppLocalizations.of(context).translate("warning_id_in_use");
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                    Form(
                      key: _formKeyDescription,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _tableDescriptionController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: AppLocalizations.of(context).translate("warning_description"),
                        ),
                        autocorrect: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context).translate("warning_id_in_use");
                          }
                          return null;
                        },
                      ),
                    ),
                    ConfirmButton(onPress: () {
                      if (_formKeyId.currentState!.validate() && _formKeyDescription.currentState!.validate()) {
                        if (editTable) {
                          setState(() {
                            Tables().getTable(index).setId(int.parse(_tableIdController.text));
                            Tables().getTable(index).setDescription(_tableDescriptionController.text);
                          });
                        } else {
                          setState(() {
                            Tables().addTable(
                                CaffeTable(int.parse(_tableIdController.text), _tableDescriptionController.text));
                          });
                        }
                        Tables().saveToDatabase();
                        Navigator.pop(context);
                      }
                    })
                  ],
                ),
              ),
            ),
          );
        });
  }
}
