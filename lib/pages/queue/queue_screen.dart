import 'package:flutter/material.dart';
import 'package:queueie/pages/queue/components/body.dart';

class QueueScreen extends StatelessWidget {
  const QueueScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Queue page"),
      ),
      body: const QueueBody(),
    );
  }
}
