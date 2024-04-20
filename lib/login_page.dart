import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageSate();
}

class _LoginPageSate extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(children: [
          Text('Hello World',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          ),
        ]),
        ),
      ),
    );
  }
}


