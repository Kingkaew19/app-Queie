import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';



class Number extends StatefulWidget {
  const Number({Key? key}) : super(key: key);

  @override
  State<Number> createState() => _NumberState();

  //static child(String s) {}
}

class _NumberState extends State<Number> {
  //final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  //DatabaseReference ref = FirebaseDatabase.instance.ref();

  final firebaseAuth = FirebaseAuth.instance;
  final databaseRef = FirebaseDatabase.instance.ref().child("Momo"); // firebaseAuth.currentUser?.displayName

  @override
  Widget build(BuildContext context) {
    // return new Scaffold(
    //     body: SafeArea(
    //         child: new FirebaseAnimatedList(
    //             query: FirebaseDatabase.instance
    //                 .ref()
    //                 .child("Momo")
    //                 .orderByChild("user")
    //                 .startAt("Golfk")
    //                 .endAt("Golfk"),
    //             padding: new EdgeInsets.all(8.0),
    //             reverse: false,
    //             itemBuilder: (_, DataSnapshot snapshot,
    //                 Animation<double> animation, int x) {
    //               return new ListTile(
    //                 subtitle: new Text(snapshot.value.toString()), 
    //               );

                  // return StreamBuilder(
                  //     stream: fireStorea
                  //         .collection('users')
                  //         .doc(FirebaseAuth.instance.currentUser?.email)
                  //         .snapshots(),
                  //     builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  //       if (!snapshot.hasData) {
                  //         return const Background(
                  //           child: CircularProgressIndicator(),
                  //         );
                  //       }

                  return Scaffold(
                      body: SafeArea(
                          child: FirebaseAnimatedList(
                              query: databaseRef,
                              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                                  Animation<double> animation, int index) {
                                var _tmp = snapshot.value as Map;

                                return ListTile(
                                  title: Text(_tmp['queue']), // snapshot.value?['user']
                                  subtitle: Text(_tmp['user']), 
                                  trailing: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward),// snapshot.value?['name']
                                ));

                  // return Card(
                  //   child: Column(children: [
                  //     Row(
                  //       children:  [
                  //         Expanded(
                  //             flex: 3,
                  //             child: Text(
                  //               snapshot.data!['name'],
                  //               style: TextStyle(fontSize: 18),
                  //             )),
                  //         Expanded(
                  //             flex: 3,
                  //             child: Text(
                  //               snapshot.data!['email'],
                  //               style: TextStyle(fontSize: 18),
                  //             )),
                  //       ],
                  //     )
                  //   ]),
                  // );
                  // })),
                  // );

                  //   return StreamBuilder(
                  //       stream: fireStore
                  //           .collection('users')
                  //           .doc(FirebaseAuth.instance.currentUser?.email)
                  //           .snapshots(),
                  //       builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  //         if (!snapshot.hasData) {
                  //           return const Background(
                  //             child: CircularProgressIndicator(),
                  //           );
                  //         }

                  // return Background(
                  //     child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //       Column(
                  //         children: [
                  //           FirebaseAnimatedList(
                  //             query: databaseRef,
                  //             itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  //                 Animation<double> animation, int index) {
                  //               var x = snapshot.value['name'];
                  //               print(x);
                  //               return ListTile(
                  //                 subtitle: Text(snapshot.value['name']),
                  //                 title: Text(snapshot.value['user']),
                  //               );
                  //             },
                  //           ),
                  //         ],

                  //   children: [
                  //     Card(
                  //         color: Colors.purple[50],
                  //         child: Column(
                  //           children: [
                  //             ListTile(
                  //               leading: Image.asset(
                  //                 'assets/images/person.png',
                  //               ),
                  //               title: const Text('Golf'),
                  //               subtitle: const Text('002'),
                  //             ),
                  //           ],
                  //         )),
                  //     Card(
                  //         color: Colors.purple[50],
                  //         child: Column(
                  //           children: [
                  //             ListTile(
                  //               leading: Image.asset(
                  //                 'assets/images/person.png',
                  //               ),
                  //               title: const Text('Golf'),
                  //               subtitle: const Text('002'),
                  //             ),
                  //           ],
                  //         )),
                  //     Card(
                  //         color: Colors.purple[50],
                  //         child: Column(
                  //           children: [
                  //             ListTile(
                  //               leading: Image.asset(
                  //                 'assets/images/person.png',
                  //               ),
                  //               title: const Text('Golf'),
                  //               subtitle: const Text('002'),
                  //             ),
                  //           ],
                  //         )),
                  //   ],
                  // ),
                  // RoundedButton(text: "Next", press: () {}, isLoading: false),
//                 ),
//               ]));
//         });
//   }
// }
                  //})));
                })));
  }
}
