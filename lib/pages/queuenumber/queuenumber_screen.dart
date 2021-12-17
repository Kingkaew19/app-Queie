import 'package:flutter/material.dart';
import 'package:queueie/constants.dart';
import 'package:queueie/pages/queuenumber/components/body.dart';

class Queuenumber extends StatefulWidget {
  const Queuenumber({Key? key}) : super(key: key);

  @override
  State<Queuenumber> createState() => _QueuenumberState();
}

class _QueuenumberState extends State<Queuenumber> {
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
