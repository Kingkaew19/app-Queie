import 'package:flutter/material.dart';
import 'package:queueie/pages/home/components/background.dart';
import 'package:queueie/pages/profile/profile_screen.dart';

class Number extends StatefulWidget {
  const Number({Key? key}) : super(key: key);

  @override
  State<Number> createState() => _NumberState();
}

class _NumberState extends State<Number> {
  @override
  Widget build(BuildContext context) {
    return Background(
        child: Column(
      children: [
        Column(
          children: [
            Card(
                color: Colors.purple[50],
                child: Column(
                  children: [
                    ListTile(
                        leading: Image.asset(
                          'assets/images/person.png',
                        ),
                        title: const Text('Golf'),
                        subtitle: const Text('002'),
                        trailing: TextButton(
                            child: const Text('ถัดไป'),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfileScreen()));
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.purple[100],
                              primary: Colors.black,
                            ))),
                  ],
                )),
            Card(
                color: Colors.purple[50],
                child: Column(
                  children: [
                    ListTile(
                        leading: Image.asset(
                          'assets/images/person.png',
                        ),
                        title: const Text('Golf'),
                        subtitle: const Text('002'),
                        trailing: TextButton(
                            child: const Text('ถัดไป'),
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.purple[100],
                              primary: Colors.black,
                            ))),
                  ],
                )),
            Card(
                color: Colors.purple[50],
                child: Column(
                  children: [
                    ListTile(
                        leading: Image.asset(
                          'assets/images/person.png',
                        ),
                        title: const Text('Golf'),
                        subtitle: const Text('002'),
                        trailing: TextButton(
                            child: const Text('ถัดไป'),
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.purple[100],
                              primary: Colors.black,
                            ))),
                  ],
                )),
          ],
        )
      ],
    ));
  }
}
