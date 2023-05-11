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
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      if (index == -1) {
                        return ListViewAddButton(
                          onTap: () {
                            setState(() {
                              _createQuiz();
                            });
                          },
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
                                  "Quiz",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                subtitle: Text("Topic",
                                    style: const TextStyle(
                                        color: secondaryColor,
                                        fontWeight: FontWeight.w200)),
                                children: [
                                  ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: 1,
                                    itemBuilder: (context, i) {
                                      if (2 == 1) {
                                        return Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: InkWell(
                                            onTap: () {
                                              _createQuiz();
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
                                        return ReorderableListView(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40),
                                          children: <Widget>[
                                            ListTile(
                                              key: Key('$index'),
                                              onTap: () {
                                                _viewQuestion();
                                              },
                                              selectedTileColor: secondaryColor,
                                              trailing: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SmallIconButton(
                                                      iconData:
                                                          Icons.edit_rounded,
                                                      iconColor: secondaryColor,
                                                      iconSize: 25,
                                                      onTap: () {}),
                                                  SmallIconButton(
                                                      iconData:
                                                          Icons.delete_rounded,
                                                      iconColor: dangerColor,
                                                      iconSize: 25,
                                                      onTap: () {
                                                        confirmDeleteWindow(
                                                            context,
                                                            "Are you sure you want to delete this item?",
                                                            () {
                                                          setState(() {});
                                                        });
                                                      })
                                                ],
                                              ),
                                              title: Text(
                                                "Question 1",
                                                style: const TextStyle(
                                                    color: secondaryColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                          onReorder:
                                              (int oldIndex, int newIndex) {},
                                        );
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }
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

  void _viewQuestion() {
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
                  "What are some practical tips for improving focus and concentration during work or study?",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
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
                      "Answer: ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Empty!",
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: primaryColor, fontSize: 12),
                  ),
                ),
              ]),
            ),
          );
        });
  }
}
