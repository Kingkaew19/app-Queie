import 'package:flutter/material.dart';
import 'package:queueie/constants.dart';
import 'package:queueie/pages/queuenumber/components/body.dart';

class Queuenumber extends StatelessWidget {
  const Queuenumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Queue Number"),
        backgroundColor: kPrimaryColor,
      ),
      body: const Number(),
    );
  }
}
