import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
//import 'package:queue/queue.dart';
import 'package:queueie/model/profile.dart';
import 'package:queueie/pages/detailsshop/components/background.dart';
import 'package:queueie/pages/queue/queue_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatefulWidget {
  const Details({Key? key, required this.doc}) : super(key: key);
  //final String name;
  final QueryDocumentSnapshot<Object?> doc;
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final fireAuth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  Users users = Users();


  int number = 0;
  var numberSelect;

// void test() {
//   DatabaseReference ref = FirebaseDatabase.instance.ref().child(widget.doc['name']);
//   ref.once().then((D))
// }

  @override
  Widget build(BuildContext context) {
    FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    Stream<DatabaseEvent> stream = ref.onValue;
    stream.listen((event) async {
      final data = event.snapshot.value;
      print(data);
    });

    return StreamBuilder(
        stream: fireStore
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.email)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Background(
              child: CircularProgressIndicator(),
            );
          }

          queue() {
            DatabaseReference ref = FirebaseDatabase.instance.ref();

            ref
                .child('${widget.doc['name']}/')
                .once()
                .then((DatabaseEvent event) {
              var data = event.snapshot.value;
              var queue = getLength(data).toString();

              print('queue------------------------------ $queue');
              final dataQueue = <String, dynamic>{
                snapshot.data!['email'].toString().replaceAll('.', '*'): {
                  "queue": queue,
                  "name": widget.doc['name'],
                  "email": snapshot.data!['email'],
                  "user": snapshot.data!['name'],
                  "time": DateTime.now().toString()
                }
              };
              ref
                  .child(widget.doc['name'])
                  .update(dataQueue)
                  .then((value) => {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return QueueScreen(
                            queue: queue,
                          );
                        }))
                      })
                  .catchError((error) => {print(error)});
            });
          }

          return Background(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: CircleAvatar(
                          radius: 45,
                          backgroundImage:
                              AssetImage('assets/images/person.png'),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Text(
                            widget.doc['name'],
                            style: const TextStyle(fontSize: 25),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.purple[50],
                                borderRadius: BorderRadius.circular(10)),
                            height: 40,
                            width: 210,
                            child: Center(
                              child: Text(widget.doc['phone'],
                                  style: TextStyle(fontSize: 20)),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],

                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Text(
                      widget.doc['name'],
                      style: const TextStyle(fontSize: 25),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.purple[50],
                          borderRadius: BorderRadius.circular(10)),
                      height: 40,
                      width: 210,
                      child: Center(
                        child: Text(widget.doc['phone'],
                            style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ],
                ),

                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("รายละเอียด", style: TextStyle(fontSize: 20)),
                      Card(
                          child: Container(
                        decoration: BoxDecoration(
                            color: Colors.purple[50],
                            borderRadius: BorderRadius.circular(5)),
                        height: 90,
                        width: 350,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            widget.doc['description'],
                            style: const TextStyle(fontSize: 19),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 80, right: 80),
            child: Row(
              children: [
                SizedBox(
                  width: 90,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text("โทร",
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                      onPressed: () async {
                        const Url = 'tel:+ 089 415 0834';
                        if (await canLaunch(Url)) {
                          await launch(Url);
                        } else {
                          throw 'Could not launch $Url';
                        }
                      }),
                ),
                const SizedBox(
                  width: 50,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 80, right: 80),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 90,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.purple[100],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Text("โทร",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            onPressed: () async {
                              final Url = 'tel:+ ${widget.doc['phone']}';
                              if (await canLaunch(Url)) {
                                await launch(Url);
                              } else {
                                throw 'Could not launch $Url';
                              }
                            }),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      SizedBox(
                        width: 90,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.purple[100],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Text("จองคิว",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            onPressed: () {
                              queue();
                              final dataQueue = <String, dynamic>{
                                snapshot.data!['email']
                                    .toString()
                                    .replaceAll('.', '*'): {
                                  "name": widget.doc['name'],
                                  "email": snapshot.data!['email'],
                                  "user": snapshot.data!['name'],
                                  "time": DateTime.now().toString()
                                }
                              };
                              ref
                                  .child(widget.doc['name'])
                                  .update(dataQueue)
                                  .catchError((error) => {print(error)});
                            }),
                      ),
                      child: const Text("จองคิว",
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const QueueBody(dataQueue: {},);
                        }));
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  getLength(var data) {
    return data?.length;
  }
} //End of Class

