import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:queueie/constants.dart';

import 'components/body.dart';

class Detailsshop extends StatefulWidget {
  const Detailsshop({Key? key, required this.doc}) : super(key: key);
  // final String name;
  final QueryDocumentSnapshot<Object?> doc;
  @override
  State<Detailsshop> createState() => _DetailsshopState();
}

class _DetailsshopState extends State<Detailsshop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detailsshop"),
        backgroundColor: kPrimaryColor,
      ),
      body: Details(
        doc: widget.doc,
      ),
    );
  }
}
