import 'package:flutter/material.dart';
import 'package:queueie/pages/notification/components/background.dart';

class BodyNotification extends StatelessWidget {
  const BodyNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* https://api.flutter.dev/flutter/material/ListTile-class.html */
    return Background(child: Text("Notification page"));
  }
}
