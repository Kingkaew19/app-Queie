import 'package:flutter/material.dart';
import 'package:queueie/pages/home/components/background.dart';

class Number extends StatelessWidget {
  const Number({Key? key}) : super(key: key);

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
