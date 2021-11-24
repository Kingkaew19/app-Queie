import 'package:flutter/material.dart';
import 'package:queueie/constants.dart';
import 'package:queueie/pages/register/components/body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        backgroundColor: kPrimaryColor,
      ),
      body: const Body(),
    );
  }
}
