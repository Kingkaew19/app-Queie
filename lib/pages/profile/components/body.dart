import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:queueie/components/rounded_button.dart';
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
    //final auth = FirebaseAuth.instance; //.currentUser;
    //final Future<FirebaseApp> firebase = Firebase.initializeApp();
    // FirebaseFirestore.instance
    //     .collection('shops') // collection
    //     .doc(auth?.currentUser!.email) // document
    //     .get()
    //     .then((value) => {
    //           setState(() {
    //             users.name = value.data()?["name"];
    //             users.email = value.data()?["email"];
    //             users.phone = value.data()?["phone"];
    //           })
    //         });
    return Background(
        child: SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: const Padding(
            padding: EdgeInsets.only(left: 28, top: 5),
            child: CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage('assets/images/person.png'),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 100,
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'ชือ', fillColor: Colors.purple),
                ),
              ),
              SizedBox(
                width: 59,
              ),
              Container(
                width: 100,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'เบอร์โทร',
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 40, right: 40),
          margin: EdgeInsets.only(top: 10),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'วันเวลาทำการ',
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 40, right: 40),
          margin: EdgeInsets.only(top: 10),
          child: TextField(
            decoration:
                InputDecoration(labelText: 'คำอธิบาย', hintText: 'คำอธิบาย'),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ตำแหน่ง',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: Colors.grey[800])),
                SizedBox(
                  height: 5,
                ),
                Image.asset('assets/images/person.png'),
              ],
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundedButton(
                  text: 'แก้ไข',
                  press: () {},
                  isLoading: false,
                  sized: 0.4,
                ),
              ],
            ),
          ),
        ),
      ]),
    ));
  }
}
