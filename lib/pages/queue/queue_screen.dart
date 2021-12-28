import 'package:flutter/material.dart';
import 'package:queueie/constants.dart';
import 'package:queueie/pages/queue/components/body.dart';

class QueueScreen extends StatefulWidget {
  const QueueScreen({Key? key, required this.dataQueue}) : super(key: key);
  final Map<String, dynamic> dataQueue;

  @override
  State<QueueScreen> createState() => _QueueScreenState();
}

class _QueueScreenState extends State<QueueScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Queue page"),
        backgroundColor: kPrimaryColor,
      ),
      body:  QueueBody(dataQueue: widget.dataQueue),
    );
  }
}
