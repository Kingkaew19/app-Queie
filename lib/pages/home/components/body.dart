import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:queueie/pages/detailsshop/components/body.dart';
import 'package:queueie/pages/detailsshop/detailsshop_screen.dart';
import 'package:queueie/pages/home/components/background.dart';
import 'package:queueie/pages/queuenumber/components/body.dart';
//import 'package:queueie/pages/queuenumber/queuenumber_screen.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  // final Query fireStore =
  //     FirebaseFirestore.instance.collection("users").orderBy('userType');

  //Users users = Users();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .orderBy('userType')
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
                leading: Image.asset(
                  'assets/images/person.png',
                ),
                title: Text(doc['name']),
                onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const Detailsshop()));},

                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => Detailsshop));
                // },
                subtitle: Text(doc['category']),
              ));
        }).toList()));
      },
    );
  }
}
