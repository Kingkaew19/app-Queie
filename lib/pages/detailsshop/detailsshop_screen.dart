import 'package:flutter/material.dart';
import 'package:queueie/constants.dart';
import 'package:queueie/pages/detailsshop/components/body.dart';

class  Detailsshop extends StatelessWidget {
  const Detailsshop({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detailsshop"),
        backgroundColor: kPrimaryColor,
      ),
      body: const Details(),
    );
  }
}
