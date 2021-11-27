import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:queueie/constants.dart';
import 'package:queueie/model/profile.dart';
import 'package:queueie/pages/home/components/body.dart';
import 'package:queueie/pages/profile/profile_screen.dart';
import 'package:queueie/pages/queue/components/body.dart';
import 'package:queueie/pages/welcome/welcome_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final fireAuth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  int _currentIndex = 0;
  Users users = Users();

  @override
  Widget build(BuildContext context) {
    /* const userType = fireStore.collection('users').where('') */
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
            });
    final tabs = [
      const HomeBody(),
      const QueueBody(),
    ];
    String title = 'Home';
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: kPrimaryColor,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications, color: Colors.white))
          ],
        ),
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/person.png",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                accountName: Text(
                  '${users.name}',
                  style: const TextStyle(fontSize: 22),
                ),
                accountEmail: Text('${users.email}',
                    style: const TextStyle(fontSize: 18))),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text("Account setting"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                fireAuth.signOut().then((value) => {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WelcomeScreen()),
                          (route) => false),
                      Fluttertoast.showToast(
                          msg: "Logout สำเร็จ", gravity: ToastGravity.CENTER)
                    });
              },
            ),
          ],
        )),
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
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              if (index == 1) {
                title = 'Home';
                print('change');
              } else {
                title = 'Queue';
                print('change');
              }
            });
          },
        ));
  }
}
