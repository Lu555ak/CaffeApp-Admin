import 'package:caffe_app/utility/constants.dart';
import 'package:flutter/material.dart';

class QuizPageMobile extends StatefulWidget {
  const QuizPageMobile({super.key});

  @override
  State<QuizPageMobile> createState() => _QuizPageMobileState();
}

class _QuizPageMobileState extends State<QuizPageMobile> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      "QUIZ PAGE",
      style: TextStyle(
          color: secondaryColor, fontSize: 30, backgroundColor: subColor),
    ));
  }
}
