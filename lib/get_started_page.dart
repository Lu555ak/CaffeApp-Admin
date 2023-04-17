import 'package:flutter/material.dart';

import 'login_page.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize() {
      return MediaQuery.of(context).size;
    }

    return SizedBox(
      width: screenSize().width * 0.5,
      height: screenSize().height * 0.5,
      child: const Icon(
        Icons.coffee,
        size: 100,
        color: Colors.brown,
      ),
    );
  }
}

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize() {
      return MediaQuery.of(context).size;
    }

    return SizedBox(
      width: screenSize().width,
      height: screenSize().height * 0.5,
      child: Padding(
        padding: EdgeInsets.only(
          left: screenSize().width * 0.1,
          top: screenSize().height * 0.2,
          right: screenSize().width * 0.1,
          bottom: screenSize().height * 0.2,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown[500],
            shadowColor: Colors.brown[800],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                screenSize().width * 0.1,
              ),
              side: const BorderSide(color: Colors.black87),
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

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/backgroundImage.jpg"),
              scale: 2.5,
              repeat: ImageRepeat.repeat),
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
      children: <Widget>[
        Background(),
        Scaffold(
          backgroundColor: Colors.transparent,
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
        )
      ],
    );
  }
}
