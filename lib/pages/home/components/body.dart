import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:queueie/model/profile.dart';
import 'package:queueie/pages/home/components/background.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  Users users = Users();
  @override
  Widget build(BuildContext context) {
    /* 
    fireStore
        .collection('users')
        .doc(fireAuth.currentUser?.email)
        .get()
        .then((value) => {
              setState(() {
                users.email = value.data()?["email"];
                users.name = value.data()?["name"];
                users.phone = value.data()?["phone"];
                users.userType = value.data()?["userType"];
              }),
            }); */
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Background(
            child: CircularProgressIndicator(),
          );
        }
        print(snapshot.data!.docs[0]['name']);
        //print(snapshot.data!.docs[1]['name']);
        return Background(child: Text("${snapshot.data!.docs[0]['name']}"));
      },
    );
  }
}
