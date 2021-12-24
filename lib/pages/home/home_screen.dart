import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:queueie/constants.dart';
import 'package:queueie/model/profile.dart';
import 'package:queueie/pages/home/components/body.dart';
import 'package:queueie/pages/notification/notification_screen.dart';
import 'package:queueie/pages/profileuser/profileuser_screen.dart';
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
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
              },
              icon: const Icon(Icons.search, color: Colors.white),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationScreen()));
                },
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileuserScreen()));
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

class CustomSearchDelegate extends SearchDelegate {
  // List<String> searchTerms = [
  //   'Momo',
  //   'ถ่ายเอกสาร',
  //   'ห้องสมุด',
  // ];

  List<String> searchTerms = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
            title: Text(result),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileuserScreen()));
            });
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
            title: Text(result),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileuserScreen()));
            });
      },
    );
  }
}
