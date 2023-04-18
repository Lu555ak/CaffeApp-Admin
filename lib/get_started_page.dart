import 'package:flutter/material.dart';

import 'login_page.dart';
import 'utility/utility_functions.dart';
import 'utility/colors.dart';
import 'custom/background.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenSize(context).width,
      height: screenSize(context).height * 0.5,
      child: Padding(
        padding: EdgeInsets.only(
          left: screenSize(context).width * 0.1,
          top: screenSize(context).height * 0.2,
          right: screenSize(context).width * 0.1,
          bottom: screenSize(context).height * 0.2,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: COLOR_WHITE,
            shadowColor: COLOR_WHITE,
            foregroundColor: COLOR_BLACK,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                screenSize(context).width * 0.1,
              ),
              side: const BorderSide(color: COLOR_BLACK, width: 2.0),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
          child: const Text(
            'GET STARTED',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Background(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Flex(
              direction: Axis.vertical,
              children: const [
                FittedBox(
                  fit: BoxFit.contain,
                  //child: ,
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: GetStartedButton(),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
