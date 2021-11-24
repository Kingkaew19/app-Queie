import 'package:flutter/material.dart';
import 'package:queueie/pages/queue/components/background.dart';

class QueueBody extends StatelessWidget {
  const QueueBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Background(child: Text("Queue page"));
  }
}
