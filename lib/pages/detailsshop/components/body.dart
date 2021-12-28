import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:queueie/model/profile.dart';
import 'package:queueie/pages/detailsshop/components/background.dart';
import 'package:queueie/pages/queue/components/body.dart';
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

  

  @override
  Widget build(BuildContext context) {
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
                    backgroundImage: AssetImage('assets/images/person.png'),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.purple[100],
                    borderRadius: BorderRadius.circular(10)),
                height: 40,
                width: 280,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.doc['open'],
                      style: const TextStyle(fontSize: 20),
                    ),
                    const Text("-", style: TextStyle(fontSize: 20)),
                    Text(widget.doc['close'],
                        style: const TextStyle(fontSize: 20))
                  ],
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
                  height: 80,
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
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("ตำแหน่ง", style: TextStyle(fontSize: 20)),
                Card(
                  child: Image.asset(
                    'assets/images/person.png',
                    height: 260,
                    width: 350,
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
}
