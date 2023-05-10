import 'package:caffe_app/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:caffe_app/models/quiz_model.dart';

import 'package:caffe_app/custom/listview_add_button.dart';
import 'package:flutter/services.dart';

import '../custom/confirm_button.dart';
import '../custom/confirm_delete_window.dart';
import '../custom/small_icon_button.dart';

class QuizPageMobile extends StatefulWidget {
  const QuizPageMobile({super.key});

  @override
  State<QuizPageMobile> createState() => _QuizPageMobileState();
}

class _QuizPageMobileState extends State<QuizPageMobile> {
  final createCategoryNameController = TextEditingController();

  final createItemNameControler = TextEditingController();
  final createItemTopicControler = TextEditingController();

  final editItemNameControler = TextEditingController();
  final editItemPriceControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
              color: subColor2,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0))),
          child: const Text(
            "QUIZES: 0",
            style: TextStyle(
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
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 3,
                    itemBuilder: (context, index) {
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
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SmallIconButton(
                                      iconData: Icons.delete_rounded,
                                      iconColor: dangerColor,
                                      iconSize: 25,
                                      onTap: () {
                                        confirmDeleteWindow(context,
                                            "Are you sure you want to delete this item?",
                                            () {
                                          setState(() {
                                            //Menu().getCategory(index).removeItem(i);
                                          });
                                        });
                                      })
                                ],
                              ),
                              title: Text(
                                "a",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                ListViewAddButton(onTap: () {
                  _createQuiz();
                })
              ],
            ))
      ]),
    );
  }

  void _createQuiz() {
    createItemNameControler.text = "";
    createItemTopicControler.text = "";

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
                  "Create new quiz.",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                TextFormField(
                  controller: createItemNameControler,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Quiz name',
                  ),
                  autocorrect: false,
                ),
                ConfirmButton(onPress: () {
                  /*setState(() {
                    Menu().getCategory(index).addItem(MenuItem(
                        createItemNameControler.text,
                        double.parse(createItemTopicControler.text)));
                  });*/
                })
              ]),
            ),
          );
        });
  }
}
