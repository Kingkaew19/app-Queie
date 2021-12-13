import 'package:flutter/material.dart';
import 'package:queueie/pages/notification/components/background.dart';


class BodyNotification extends StatelessWidget {
  const BodyNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* https://api.flutter.dev/flutter/material/ListTile-class.html */
    Size size = MediaQuery.of(context).size;
    return Background(
        child: Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            children: [
              SizedBox(
                width: size.width * 0.95,
                height: size.height * 0.10,
                child: Card(
                  child: ListTile(
                    leading: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 44,
                        minHeight: 44,
                        maxWidth: 64,
                        maxHeight: 64,
                      ),
                      child: Image.asset('assets/images/person.png'),
                    ),
                    title: const Text('ศูนย์บริการนักศึกษา'),
                    subtitle: const Text(
                      'กำลังจะถึงคิวของคุณแล้ว',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        
       
      ],
    ));
  }
}
