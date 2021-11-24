import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:queueie/constants.dart';
import 'package:queueie/model/profile.dart';
import 'package:queueie/pages/profile/components/background.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  Users users = Users();
  String lorem =
      'สะบึม โปรดิวเซอร์โปรโมเตอร์เดชานุภาพไฮไลต์ เอาท์ โพลล์กิมจิเซอร์ไพรส์บ๊วยอัลบัม รีวิว วินไลท์ แกงค์เมจิคโกะ ใช้งานดยุคเวสต์ แทคติคเมี่ยงคำ ถูกต้องเปราะบางโง่เขลาเนอะเปียโน ไตรมาสเซาท์ ฮาร์ดเครป แคนูละตินพรีเมียร์ อินเตอร์ คาปูชิโนป๊อปดาวน์ฟรุตคีตปฏิภาณ ไอซ์';
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('shops') // collection
        .doc(auth?.email) // document
        .get()
        .then((value) => {
              setState(() {
                users.name = value.data()?["name"];
                users.email = value.data()?["email"];
                users.phone = value.data()?["phone"];
              })
            });
    return Background(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
        decoration: BoxDecoration(
          color: kPrimaryLightColor,
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(34)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 28, top: 10),
              child: CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage('assets/images/person.png'),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 30, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${users.name}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('${users.email}', style: const TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ],
        ),
      ),
      Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.green[100],
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          margin: EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('วันและเวลาทำการ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(
                height: 10,
              ),
              Text(' 9:00am - 4:00pm', style: TextStyle(fontSize: 16)),
            ],
          )),
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: kPrimaryLightColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('คำอธิบาย',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            Text(lorem, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    ]));
  }
}
