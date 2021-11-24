import 'package:flutter/material.dart';
import 'package:queueie/constants.dart';
import 'package:queueie/pages/login/components/body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: kPrimaryColor,
      ),
      body: const Body(),
    );
  }
}
