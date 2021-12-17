import 'package:flutter/material.dart';
import 'package:queueie/constants.dart';
import 'package:queueie/pages/profileuser/componant/body.dart';

class ProfileuserScreen extends StatelessWidget {
  const ProfileuserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Setting"),
        backgroundColor: kPrimaryColor,
      ),
      body: const bodyProfileuser(),
    );
  }
}
