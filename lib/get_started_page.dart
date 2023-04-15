import 'package:caffe_app/main.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[300],
      body: Center(
        child: Column(
          children: [
            //SizedBox
            const SizedBox(height: 100),
            //Logo
            const Icon(Icons.coffee, size: 100),
            //SizedBox
            const SizedBox(height: 350),
            //Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.brown[500],
                shadowColor: Colors.brown[800],
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text('GET STARTED'),
            ),
          ],
        ),
      ),
    );
  }
}
