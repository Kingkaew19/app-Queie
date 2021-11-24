import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:queueie/constants.dart';
import 'package:queueie/pages/home/components/body.dart';
import 'package:queueie/pages/profile/components/body.dart';
import 'package:queueie/pages/queue/components/body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final fireAuth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  int _currentIndex = 0;
  final tabs = [
    const HomeBody(),
    const QueueBody(),
    const ProfileBody(),
  ];
  @override
  Widget build(BuildContext context) {
    /* const userType = fireStore.collection('users').where('') */
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications, color: Colors.white))
          ],
        ),
        body: tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Queue'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ));
  }
}
