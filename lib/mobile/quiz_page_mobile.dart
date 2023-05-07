import 'package:caffe_app/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:caffe_app/models/quiz_model.dart';

import 'package:caffe_app/custom/listview_add_button.dart';

class QuizPageMobile extends StatefulWidget {
  const QuizPageMobile({super.key});

  @override
  State<QuizPageMobile> createState() => _QuizPageMobileState();
}

class _QuizPageMobileState extends State<QuizPageMobile> {
  final data = [1, 2, 3, 4, 5, 6, 7, 8];

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
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: Quizzes().getQuizCount() + 1,
              itemBuilder: ((context, index) {
                if (index == Quizzes().getQuizCount()) {
                  return ListViewAddButton(
                    onTap: () {
                      setState(() {
                        Quizzes().addQuiz(Quiz("Quiz 3"));
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
                                Quizzes().getQuizAt(index).getIdentifier(),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              children: [
                                ReorderableListView.builder(
                                  shrinkWrap: true,
                                  itemCount: Quizzes()
                                          .getQuizAt(index)
                                          .getQuizCount() +
                                      1,
                                  onReorder: (oldIndex, newIndex) {
                                    setState(() {
                                      Quizzes()
                                          .getQuizAt(index)
                                          .swapQuestions(oldIndex, newIndex);
                                    });
                                  },
                                  itemBuilder: (context, i) {
                                    if (Quizzes()
                                            .getQuizAt(index)
                                            .getQuizCount() ==
                                        i) {
                                      return Padding(
                                        key: const ValueKey("AddNewQuestion"),
                                        padding: const EdgeInsets.all(10),
                                        child: InkWell(
                                          onTap: () {
                                            Quizzes()
                                                .getQuizAt(index)
                                                .addQuestion(QuizQuestion(
                                                    "What is your name?"));
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
                                      return Container(key: ValueKey(i));
                                    }
                                  },
                                )
                              ],
                            )),
                      ));
                }
              })),
        )
      ]),
    );
  }
}
