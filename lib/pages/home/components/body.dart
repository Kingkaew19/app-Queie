import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:queueie/pages/detailsshop/detailsshop_screen.dart';
import 'package:queueie/pages/home/components/background.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final fireAuth = FirebaseAuth.instance;
  //final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('userType', isEqualTo: 'shop')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Background(
            child: CircularProgressIndicator(),
          );
        }

        return Background(
            child: ListView(
                children: snapshot.data!.docs.map((doc) {
          return Card(
              color: Colors.purple[50],
              child: ListTile(
                leading: Image.network(doc['urlImage']),
                title: Text(doc['name']),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Detailsshop(doc: doc)));
                },
                subtitle: Text(doc['category']),
              ));
        }).toList()));
      },
    );
  }
}
