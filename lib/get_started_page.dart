import 'package:flutter/material.dart';

import 'login_page.dart';
import 'utility/utility_functions.dart';
import 'utility/colors.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenSize(context).width * 0.5,
      height: screenSize(context).height * 0.5,
      child: const Icon(
        Icons.coffee,
        size: 100,
      ),
    );
  }
}

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
            primary: COLOR_BROWN,
            shadowColor: COLOR_BROWN,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenSize(context).width * 0.1,),
                side: const BorderSide(color: COLOR_BLACK),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
          child: const Text('GET STARTED'),
        ),
      ),
    );
  }
}

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: COLOR_BROWN,
      body: Center(
        child: Flex(
          direction: Axis.vertical,
           children: const [
            FittedBox(
              fit: BoxFit.contain,
              child: AppIcon(),
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: GetStartedButton(),
            ),
          ],
        ),
      ),
    );
  }
}
