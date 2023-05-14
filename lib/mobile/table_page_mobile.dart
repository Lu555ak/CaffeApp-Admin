import 'package:caffe_app/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:caffe_app/models/tables_model.dart';
import 'package:caffe_app/custom/confirm_delete_window.dart';
import 'package:caffe_app/custom/small_icon_button.dart';
import 'package:caffe_app/custom/confirm_button.dart';

class TablePageMobile extends StatefulWidget {
  const TablePageMobile({super.key});

  @override
  State<TablePageMobile> createState() => _TablePageMobileState();
}

class _TablePageMobileState extends State<TablePageMobile> {
  final editTableIdController = TextEditingController();
  final editTableDescriptionController = TextEditingController();

  final createTableIdController = TextEditingController();
  final createTableDescriptionController = TextEditingController();

  final _formKeyId = GlobalKey<FormState>();

  @override
  void dispose() {
    editTableIdController.dispose();
    editTableDescriptionController.dispose();
    createTableIdController.dispose();
    createTableDescriptionController.dispose();
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
              "ACTIVE TABLES: ${Tables().getTableCount()}",
              style: const TextStyle(
                  color: secondaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
          ),
          GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: Tables().getTableCount() + 1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                if (index == Tables().getTableCount()) {
                  return Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          createTableSheet();
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
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
                      ),
                      child: Row(children: [
                        InkWell(
                          onTap: () {
                            showTableSheet(Tables().getTable(index));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: const BoxDecoration(
                              color: subColor2,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                        Tables()
                                            .getTable(index)
                                            .getId()
                                            .toString(),
                                        style: const TextStyle(
                                            color: secondaryColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 50),
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
                                  iconColor: primaryColor,
                                  onTap: () {
                                    editTableSheet(Tables().getTable(index));
                                  }),
                              SmallIconButton(
                                  iconData: Icons.delete_rounded,
                                  iconColor: dangerColor,
                                  onTap: () {
                                    confirmDeleteWindow(context,
                                        "Are you sure you want to delete this table?",
                                        () {
                                      setState(() {
                                        Tables().removeTable(index);
                                      });
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
                        table.getId().toString(),
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
                        "Description: ",
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
                      table.getDescription(),
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

  void editTableSheet(CaffeTable table) {
    editTableDescriptionController.text = "";
    editTableIdController.text = "";

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
                    "Edit table.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: editTableIdController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'ID',
                    ),
                    autocorrect: false,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: editTableDescriptionController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'Description',
                    ),
                    autocorrect: false,
                  ),
                  ConfirmButton(onPress: () {
                    setState(() {
                      if (editTableIdController.text != "") {
                        table.setId(int.parse(editTableIdController.text));
                      }
                      if (editTableDescriptionController.text != "") {
                        table.setDescription(
                            editTableDescriptionController.text);
                      }
                      Navigator.of(context).pop();
                    });
                  })
                ],
              ),
            ),
          );
        });
  }

  void createTableSheet() {
    createTableDescriptionController.text = "";
    createTableIdController.text = "";

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
                    "Create table.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Form(
                    key: _formKeyId,
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      controller: createTableIdController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'ID',
                      ),
                      autocorrect: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some ID!';
                        }
                        return null;
                      },
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: createTableDescriptionController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'Description',
                    ),
                    autocorrect: false,
                  ),
                  ConfirmButton(onPress: () {
                    setState(() {
                      if (createTableIdController.text != "" &&
                          createTableDescriptionController.text != "") {
                        Tables().addTable(CaffeTable(
                            int.parse(createTableIdController.text),
                            createTableDescriptionController.text));
                      } else if (createTableIdController.text == "" &&
                          createTableDescriptionController.text != "") {
                        Tables().addTable(CaffeTable(Tables().generateFreeId(),
                            createTableDescriptionController.text));
                      } else if (createTableIdController.text != "" &&
                          createTableDescriptionController.text == "") {
                        Tables().addTable(CaffeTable(
                            int.parse(createTableIdController.text), "Empty"));
                      } else {
                        Tables().addTable(
                            CaffeTable(Tables().generateFreeId(), "Empty"));
                      }
                      Navigator.of(context).pop();
                    });
                  })
                ],
              ),
            ),
          );
        });
  }
}
