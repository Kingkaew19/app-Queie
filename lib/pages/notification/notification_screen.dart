import 'package:flutter/material.dart';
import 'package:queueie/constants.dart';
import 'package:queueie/pages/notification/components/body.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
        backgroundColor: kPrimaryColor,
      ),
      body: BodyNotification(),
    );
  }
}
