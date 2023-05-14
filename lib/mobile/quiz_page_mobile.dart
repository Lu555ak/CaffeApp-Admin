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
  final createQuizNameControler = TextEditingController();
  final createQuizTopicControler = TextEditingController();

  final createQuestionQuestionControler = TextEditingController();

  final _formKeyName = GlobalKey<FormState>();
  final _formKeyTopic = GlobalKey<FormState>();
  final _formKeyQuestion = GlobalKey<FormState>();

  @override
  void dispose() {
    createQuizNameControler.dispose();
    createQuizTopicControler.dispose();
    createQuestionQuestionControler.dispose();

    super.dispose();
  }

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
          child: Text(
            "QUIZES: ${Quizzes().getQuizCount()}",
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
                // Quiz list
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: Quizzes().getQuizCount(),
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
                              title: Text(
                                "Quiz: ${Quizzes().getQuizAt(index).getName()} ",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              subtitle: Text(
                                  Quizzes().getQuizAt(index).getTopic(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w200)),
                              children: [
                                // Question list
                                ReorderableListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    buildDefaultDragHandles: false,
                                    itemCount: Quizzes()
                                        .getQuizAt(index)
                                        .getQuestionCount(),
                                    onReorder: (oldIndex, newIndex) {
                                      setState(() {
                                        Quizzes()
                                            .getQuizAt(index)
                                            .swapQuestions(oldIndex, newIndex);
                                      });
                                    },
                                    itemBuilder: (context, i) {
                                      return ReorderableDragStartListener(
                                        index: i,
                                        key: Key('Question$i'),
                                        child: ListTile(
                                          onTap: () {
                                            _viewQuestion();
                                          },
                                          title: Text(
                                            "#${i + 1}: ${Quizzes().getQuizAt(index).getQuestionAt(i).getQuestion()}",
                                            style: const TextStyle(
                                                color: secondaryColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          selectedTileColor: secondaryColor,
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
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
                                                        Quizzes()
                                                            .getQuizAt(index)
                                                            .removeQuestionAt(
                                                                i);
                                                      });
                                                    });
                                                  })
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                ListViewAddButton(
                                  onTap: () {
                                    _createQuestion(index);
                                  },
                                )
                              ],
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
    createQuizNameControler.text = "";
    createQuizTopicControler.text = "";

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
                Form(
                  key: _formKeyName,
                  child: TextFormField(
                    controller: createQuizNameControler,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'Name',
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
                  key: _formKeyTopic,
                  child: TextFormField(
                    controller: createQuizTopicControler,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'Topic',
                    ),
                    autocorrect: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the topic of the quiz!';
                      }
                      return null;
                    },
                  ),
                ),
                ConfirmButton(onPress: () {
                  if (_formKeyName.currentState!.validate() &&
                      _formKeyTopic.currentState!.validate()) {
                    setState(() {
                      Quizzes().addQuiz(Quiz(createQuizNameControler.text,
                          createQuizTopicControler.text));
                      Navigator.of(context).pop();
                    });
                  }
                })
              ]),
            ),
          );
        });
  }

  void _createQuestion(int index) {
    createQuestionQuestionControler.text = "";

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
                Form(
                  key: _formKeyQuestion,
                  child: TextFormField(
                    controller: createQuestionQuestionControler,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'Question',
                    ),
                    autocorrect: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the name of the question!';
                      }
                      return null;
                    },
                  ),
                ),
                ConfirmButton(onPress: () {
                  if (_formKeyQuestion.currentState!.validate()) {
                    setState(() {
                      Quizzes().getQuizAt(index).addQuestion(
                          QuizQuestion(createQuestionQuestionControler.text));
                      Navigator.of(context).pop();
                    });
                  }
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
