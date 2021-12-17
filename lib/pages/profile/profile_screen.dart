import 'package:flutter/material.dart';
import 'package:queueie/constants.dart';
import 'package:queueie/pages/profile/components/body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Setting"),
        backgroundColor: kPrimaryColor,
      ),
      body: const ProfileBody(),
    );
  }
}
