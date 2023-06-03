import 'package:caffe_app/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:caffe_app/models/quiz_model.dart';

import 'package:caffe_app/custom/listview_add_button.dart';

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
  late List<TextEditingController> multipleAnswerControllers;
  late List<TextEditingController> fillInAnswerControllers;

  final createQuestionQuestionControler = TextEditingController();

  final _formKeyName = GlobalKey<FormState>();
  final _formKeyTopic = GlobalKey<FormState>();
  final _formKeyQuestion = GlobalKey<FormState>();
  late List<GlobalKey<FormState>> multipleAnswerForm;
  late List<GlobalKey<FormState>> fillInAnswerForm;

  late QuizQuestionTrueFalse questionTrueFalse;
  late QuizQuestionMultiple questionMultiple;
  late QuizQuestionFillIn questionFillIn;

  late int currentQuestion;
  void defaultQuizQuestions() {
    questionTrueFalse = QuizQuestionTrueFalse("", true);
    questionMultiple = QuizQuestionMultiple("");
    questionFillIn = QuizQuestionFillIn("");
    createQuestionQuestionControler.text = "";

    multipleAnswerControllers = List.empty(growable: true);
    fillInAnswerControllers = List.empty(growable: true);
    multipleAnswerForm = List.empty(growable: true);
    fillInAnswerForm = List.empty(growable: true);
  }

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
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.0), bottomRight: Radius.circular(25.0))),
          child: Text(
            "QUIZES: ${Quizzes().getQuizCount()}",
            style: const TextStyle(color: secondaryColor, fontWeight: FontWeight.w600, fontSize: 15),
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
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: Quizzes().getQuizCount(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Theme(
                          data: ThemeData(colorScheme: ColorScheme.fromSwatch().copyWith(primary: secondaryColor)),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: ExpansionTile(
                              backgroundColor: primaryColor,
                              title: Text(
                                "Quiz: ${Quizzes().getQuizAt(index).getName()} ",
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              subtitle: Text(Quizzes().getQuizAt(index).getTopic(),
                                  style: const TextStyle(fontWeight: FontWeight.w400)),
                              children: [
                                // Question list
                                ReorderableListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    buildDefaultDragHandles: false,
                                    itemCount: Quizzes().getQuizAt(index).getQuestionCount(),
                                    onReorder: (oldIndex, newIndex) {
                                      setState(() {
                                        Quizzes().getQuizAt(index).swapQuestions(oldIndex, newIndex);
                                      });
                                    },
                                    itemBuilder: (context, i) {
                                      return ReorderableDragStartListener(
                                        index: i,
                                        key: Key('Question$i'),
                                        child: ListTile(
                                          onTap: () {
                                            currentQuestion = i;
                                            _showQuestion(index, true);
                                          },
                                          title: Text(
                                            "#${i + 1}: ${Quizzes().getQuizAt(index).getQuestionAt(i).getQuestion()}",
                                            style: const TextStyle(color: secondaryColor, fontWeight: FontWeight.w600),
                                          ),
                                          selectedTileColor: secondaryColor,
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SmallIconButton(
                                                  iconData: Icons.delete_rounded,
                                                  iconColor: dangerColor,
                                                  iconSize: 25,
                                                  onTap: () {
                                                    confirmDeleteWindow(
                                                        context, "Are you sure you want to delete this item?", () {
                                                      setState(() {
                                                        Quizzes().getQuizAt(index).removeQuestionAt(i);
                                                      });
                                                    });
                                                  })
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    children: [
                                      Flexible(
                                          flex: 4,
                                          child: ListViewAddButton(
                                            onTap: () {
                                              _showQuestion(index, false);
                                            },
                                          )),
                                      Flexible(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 8),
                                            child: SmallIconButton(
                                                iconData: Icons.edit_rounded,
                                                iconColor: secondaryColor,
                                                onTap: () {
                                                  _showQuiz(index, true);
                                                }),
                                          )),
                                      Flexible(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 8),
                                            child: SmallIconButton(
                                                iconData: Icons.delete_rounded,
                                                iconColor: dangerColor,
                                                onTap: () {
                                                  confirmDeleteWindow(
                                                      context, "Are you sure you want to delete this quiz?", () {
                                                    setState(() {
                                                      Quizzes().removeQuizAt(index);
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
                        ),
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListViewAddButton(onTap: () {
                    _showQuiz(-1, false);
                  }),
                )
              ],
            ))
      ]),
    );
  }

  void _showQuiz(int index, bool editQuiz) {
    createQuizNameControler.text = "";
    createQuizTopicControler.text = "";

    if (editQuiz == true) {
      createQuizNameControler.text = Quizzes().getQuizAt(index).getName();
      createQuizTopicControler.text = Quizzes().getQuizAt(index).getTopic();
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
                child: Column(children: [
                  Text(
                    (editQuiz) ? "Edit quiz." : "Create new quiz.",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
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
                          return 'Please enter quiz name!';
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
                    if (_formKeyName.currentState!.validate() && _formKeyTopic.currentState!.validate()) {
                      setState(() {
                        if (editQuiz) {
                          Quizzes().getQuizAt(index).setName(createQuizNameControler.text);
                          Quizzes().getQuizAt(index).setTopic(createQuizTopicControler.text);
                        } else {
                          Quizzes().addQuiz(Quiz(createQuizNameControler.text, createQuizTopicControler.text));
                        }
                        Navigator.of(context).pop();
                      });
                    }
                  })
                ]),
              ),
            ),
          );
        });
  }

  void _showQuestion(int index, bool editQuestion) {
    int currentTabIndex = 0;
    String warningText = "";

    defaultQuizQuestions();
    if (editQuestion) {
      String type = Quizzes().getQuizAt(index).getQuestionAt(currentQuestion).getType();
      QuizQuestion question = Quizzes().getQuizAt(index).getQuestionAt(currentQuestion);
      createQuestionQuestionControler.text = Quizzes().getQuizAt(index).getQuestionAt(currentQuestion).getQuestion();

      if (type == "QuizQuestionTrueFalse") {
        questionTrueFalse = question as QuizQuestionTrueFalse;
        currentTabIndex = 0;
      } else if (type == "QuizQuestionMultipleAnswer") {
        questionMultiple = question as QuizQuestionMultiple;
        currentTabIndex = 1;
        for (int i = 0; i < questionMultiple.answerCount(); i++) {
          multipleAnswerControllers.add(TextEditingController());
          multipleAnswerControllers[i].text = questionMultiple.getAnswerAt(i).statement;
          multipleAnswerForm.add(GlobalKey<FormState>());
        }
      } else if (type == "QuizQuestionFillIn") {
        questionFillIn = question as QuizQuestionFillIn;
        currentTabIndex = 2;
        for (int i = 0; i < questionFillIn.answerCount(); i++) {
          fillInAnswerControllers.add(TextEditingController());
          fillInAnswerControllers[i].text = questionFillIn.getAnswerAt(i);
          fillInAnswerForm.add(GlobalKey<FormState>());
        }
      }
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
                    child: Column(children: [
                      const Text(
                        "Create new question.",
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Text(
                            textAlign: TextAlign.left,
                            warningText,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.red),
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        height: 400,
                        child: DefaultTabController(
                          length: 3,
                          initialIndex: currentTabIndex,
                          child: Column(mainAxisSize: MainAxisSize.min, children: [
                            TabBar(
                              labelColor: secondaryColor,
                              dividerColor: secondaryColor,
                              indicatorColor: secondaryColor,
                              onTap: (value) {
                                setStateInner(() {
                                  warningText = "";
                                });
                                currentTabIndex = value;
                              },
                              tabs: const <Widget>[
                                Tab(
                                  icon: Icon(Icons.question_answer_rounded),
                                ),
                                Tab(
                                  icon: Icon(Icons.list_rounded),
                                ),
                                Tab(
                                  icon: Icon(Icons.text_fields_rounded),
                                )
                              ],
                            ),
                            Expanded(
                              child: TabBarView(children: [
                                _showTrueFalseQuestion(),
                                _showMultipleChoiceQuestion(),
                                _showFillInQuestion()
                              ]),
                            ),
                          ]),
                        ),
                      ),
                      ConfirmButton(onPress: () {
                        if (_formKeyQuestion.currentState!.validate()) {
                          if (currentTabIndex == 0) {
                            questionTrueFalse.setQuestion(createQuestionQuestionControler.text);
                            setStateInner(() {
                              warningText = "";
                            });
                            setState(() {
                              if (editQuestion) {
                                Quizzes().getQuizAt(index).setQuestionAt(currentQuestion, questionTrueFalse);
                              } else {
                                Quizzes().getQuizAt(index).addQuestion(questionTrueFalse);
                              }
                            });
                            Navigator.of(context).pop();
                          }
                          if (currentTabIndex == 1) {
                            bool flagItemsFilled = true;
                            bool flagOneTrue = false;
                            for (var validator in multipleAnswerForm) {
                              if (!validator.currentState!.validate()) {
                                flagItemsFilled = false;
                              }
                            }
                            for (var question in questionMultiple.getAnswers()) {
                              if (question.isCorrect == true) {
                                flagOneTrue = true;
                              }
                            }
                            if (questionMultiple.answerCount() <= 1) {
                              setStateInner(() {
                                warningText = "Please add at least 2 answers.";
                              });
                            } else if (flagOneTrue == false) {
                              setStateInner(() {
                                warningText = "Please mark at least 1 answer as correct.";
                              });
                            } else if (flagItemsFilled == true &&
                                flagOneTrue == true &&
                                questionMultiple.answerCount() > 1) {
                              questionMultiple.setQuestion(createQuestionQuestionControler.text);
                              setStateInner(() {
                                warningText = "";
                              });
                              setState(() {
                                if (editQuestion) {
                                  Quizzes().getQuizAt(index).setQuestionAt(currentQuestion, questionMultiple);
                                } else {
                                  Quizzes().getQuizAt(index).addQuestion(questionMultiple);
                                }
                              });
                              Navigator.of(context).pop();
                            }
                          }

                          if (currentTabIndex == 2) {
                            bool flagItemsFilled = true;
                            for (var validator in fillInAnswerForm) {
                              if (!validator.currentState!.validate()) {
                                flagItemsFilled = false;
                              }
                            }
                            if (questionFillIn.answerCount() < 1) {
                              setStateInner(() {
                                warningText = "Please add at least 1 answer.";
                              });
                            } else if (flagItemsFilled == true && questionFillIn.answerCount() > 0) {
                              questionFillIn.setQuestion(createQuestionQuestionControler.text);
                              setStateInner(() {
                                warningText = "";
                              });
                              setState(() {
                                if (editQuestion) {
                                  Quizzes().getQuizAt(index).setQuestionAt(currentQuestion, questionFillIn);
                                } else {
                                  Quizzes().getQuizAt(index).addQuestion(questionFillIn);
                                }
                              });
                              Navigator.of(context).pop();
                            }
                          }
                        }
                      })
                    ]),
                  ),
                ),
              );
            },
          );
        });
  }

  Widget _showTrueFalseQuestion() {
    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                "TRUE / FALSE",
                style: TextStyle(color: secondaryColor, fontSize: 18, fontWeight: FontWeight.w700),
              ),
              Center(
                child: Column(
                  children: [
                    ListTile(
                      title: const Text(
                        "True",
                        style: TextStyle(color: secondaryColor, fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      leading: Radio(
                        activeColor: secondaryColor,
                        groupValue: questionTrueFalse.getAnswer(),
                        value: true,
                        onChanged: (value) => {
                          setState(() {
                            questionTrueFalse.setAnswer(value!);
                          })
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        "False",
                        style: TextStyle(color: secondaryColor, fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      leading: Radio(
                        activeColor: secondaryColor,
                        groupValue: questionTrueFalse.getAnswer(),
                        value: false,
                        onChanged: (value) => {
                          setState(() {
                            questionTrueFalse.setAnswer(value!);
                          })
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _showMultipleChoiceQuestion() {
    return StatefulBuilder(builder: (context, setState) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "MULTIPLE CHOICE",
                style: TextStyle(color: secondaryColor, fontSize: 18, fontWeight: FontWeight.w700),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: questionMultiple.answerCount(),
                itemBuilder: (context, index) {
                  return ListTile(
                      leading: Checkbox(
                        value: questionMultiple.getAnswerAt(index).isCorrect,
                        onChanged: (newValue) {
                          setState(() {
                            questionMultiple.getAnswerAt(index).isCorrect = newValue!;
                          });
                        },
                        activeColor: secondaryColor,
                        checkColor: primaryColor,
                      ),
                      title: Form(
                        key: multipleAnswerForm[index],
                        autovalidateMode: AutovalidateMode.always,
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: 'Answer',
                            hintStyle: TextStyle(color: subColor2, fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          controller: multipleAnswerControllers[index],
                          autocorrect: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the answer!';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            questionMultiple.getAnswerAt(index).statement = multipleAnswerControllers[index].text;
                          },
                          style: const TextStyle(color: secondaryColor, fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      trailing: SmallIconButton(
                          iconData: Icons.delete_rounded,
                          iconColor: dangerColor,
                          iconSize: 25,
                          onTap: () {
                            confirmDeleteWindow(context, "Are you sure you want to delete this answer?", () {
                              setState(() {
                                multipleAnswerForm.removeAt(index);
                                multipleAnswerControllers.removeAt(index);
                                questionMultiple.removeAnswerAt(index);
                              });
                            });
                          }));
                },
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListViewAddButton(
                  onTap: () {
                    setState(() {
                      multipleAnswerForm.add(GlobalKey<FormState>());
                      multipleAnswerControllers.add(TextEditingController());
                      questionMultiple.addAnswer("", false);
                    });
                  },
                  iconSize: 20,
                  boxColor: secondaryColor,
                  iconColor: primaryColor,
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget _showFillInQuestion() {
    return StatefulBuilder(builder: (context, setState) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "FILL IN",
                style: TextStyle(color: secondaryColor, fontSize: 18, fontWeight: FontWeight.w700),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: questionFillIn.answerCount(),
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Form(
                        key: fillInAnswerForm[index],
                        autovalidateMode: AutovalidateMode.always,
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: 'Answer',
                            hintStyle: TextStyle(color: subColor2, fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          controller: fillInAnswerControllers[index],
                          autocorrect: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the answer!';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            questionFillIn.setAnswerAt(index, fillInAnswerControllers[index].text);
                          },
                          style: const TextStyle(color: secondaryColor, fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      trailing: SmallIconButton(
                          iconData: Icons.delete_rounded,
                          iconColor: dangerColor,
                          iconSize: 25,
                          onTap: () {
                            confirmDeleteWindow(context, "Are you sure you want to delete this answer?", () {
                              setState(() {
                                fillInAnswerForm.removeAt(index);
                                fillInAnswerControllers.removeAt(index);
                                questionFillIn.removeAnswerAt(index);
                              });
                            });
                          }));
                },
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListViewAddButton(
                  onTap: () {
                    setState(() {
                      fillInAnswerForm.add(GlobalKey<FormState>());
                      fillInAnswerControllers.add(TextEditingController());
                      questionFillIn.addAnswer("");
                    });
                  },
                  iconSize: 20,
                  boxColor: secondaryColor,
                  iconColor: primaryColor,
                ),
              ),
              ListTile(
                trailing: Switch(
                  value: questionFillIn.getCaseSensitive(),
                  onChanged: (value) {
                    setState(() {
                      questionFillIn.setCaseSensitive(value);
                    });
                  },
                  activeColor: secondaryColor,
                  activeTrackColor: subColor,
                ),
                title: const Text(
                  "Case sensitive",
                  style: TextStyle(color: secondaryColor, fontSize: 16, fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
