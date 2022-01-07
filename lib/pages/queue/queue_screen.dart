import 'package:flutter/material.dart';
import 'package:queueie/constants.dart';
import 'package:queueie/pages/queue/components/body.dart';

class QueueScreen extends StatefulWidget {
  QueueScreen({Key? key, required this.queue}) : super(key: key);
  final queue;

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
      body: QueueBody(
        queue: widget.queue,
      ),
    );
  }
}
