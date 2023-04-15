import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: const [
            SizedBox(height: 225),
            Text('Username:'),
            SizedBox(height: 100),
            Text('Password:'),
          ],
        ),
      ),
    );
  }
}