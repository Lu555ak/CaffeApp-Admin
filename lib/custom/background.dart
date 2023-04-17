import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/backgroundImage.jpg"),
            scale: 1.5,
            repeat: ImageRepeat.repeat,
          ),
        ),
      ),
    );
  }
}
