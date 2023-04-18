import 'package:caffe_app/custom/background.dart';
import 'package:caffe_app/utility/colors.dart';
import 'package:caffe_app/utility/utility_functions.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          Center(
            child: Column(
              children: [
                const Icon(Icons.lock, size: 100),
                const SizedBox(height: 200),
                Text(
                  'Welcome back!',
                  style: TextStyle(
                    color: COLOR_WHITE,
                    fontSize: ((screenSize(context).height *
                            screenSize(context).width) /
                        (screenSize(context).height * 10 +
                            screenSize(context).width * 10)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
