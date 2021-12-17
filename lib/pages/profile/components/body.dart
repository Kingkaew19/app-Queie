import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:queueie/components/rounded_button.dart';
import 'package:queueie/components/text_field_container.dart';
import 'package:queueie/components/time_range_picker.dart';
import 'package:queueie/model/profile.dart';
import 'package:queueie/pages/home/home_screen.dart';
import 'package:queueie/pages/profile/components/background.dart';
import 'package:time_range_picker/time_range_picker.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  final updateProfile = GlobalKey<FormState>();
  Users users = Users();
  bool isLoading = false;
  //String chooseCategory = 'หมวดหมู่';
  // List<String> category = [
  //   'ร้านกาแฟ',
  //   'ห้องสมุด',
  //   'ศูนย์บริการ',
  //   'ร้านถ่ายเอกสาร'
  // ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.email)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Background(
              child: CircularProgressIndicator(),
            );
          }
          return Background(
              child: Form(
            key: updateProfile,
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/images/person.png'),
                        ),
                      ),
                    ),
                    RoundedInputField(
                      hintText: "ชื่อ",
                      val: snapshot.data!['name'],
                      icon: Icons.person,
                      validator: RequiredValidator(errorText: "กรุณาใส่ชื่อ"),
                      onSaved: (value) {
                        setState(() => users.name = value);
                      },
                    ),
                    RoundedInputField(
                      hintText: "เบอร์โทรศัพท์",
                      val: snapshot.data!['phone'],
                      icon: Icons.phone,
                      validator:
                          RequiredValidator(errorText: "กรุณาใส่เบอร์โทร"),
                      onSaved: (value) {
                        setState(() => users.phone = value);
                      },
                    ),
                    RoundedInputField(
                      hintText: "หมวดหมู่",
                      val: snapshot.data!['category'],
                      icon: Icons.category,
                      validator:
                          RequiredValidator(errorText: "กรุณาใส่หมวดหมู่"),
                      onSaved: (value) {
                        setState(() => users.category = value);
                      },
                    ),
                    snapshot.data?['open'] == ""
                        ? const Text("ยังไม่ได้เลือกเวลาเปิด-ปิด",
                            style: TextStyle(fontSize: 18))
                        : Text(
                            "เวลาเดิม ${snapshot.data?['open']} - ${snapshot.data?['close']}",
                            style: const TextStyle(fontSize: 18)),
                    RoundedTimeRange(
                      text: users.open == null && users.close == null
                          ? "แก้ไขเวลาใหม่"
                          : "เวลาใหม่ ${users.open!.format(context)} - ${users.close!.format(context)}",
                      onPress: () async {
                        TimeRange? result =
                            await showTimeRangePicker(context: context);
                        setState(() {
                          users.open = result!.startTime;
                          users.close = result.endTime;
                        });
                      },
                    ),
                    RoundedInputField(
                      hintText: "คำอธิบาย",
                      val: snapshot.data!['description'],
                      icon: Icons.description,
                      maxLines: 5,
                      validator:
                          RequiredValidator(errorText: "กรุณาใส่คำอธิบาย"),
                      onSaved: (value) {
                        setState(() => users.description = value);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ตำแหน่ง',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: Colors.grey[800])),
                          const SizedBox(
                            height: 5,
                          ),
                          Image.asset('assets/images/person.png'),
                        ],
                      ),
                    ),
                    RoundedButton(
                      text: 'บันทึก',
                      isLoading: isLoading,
                      sized: 0.47,
                      press: () {
                        if (updateProfile.currentState!.validate()) {
                          updateProfile.currentState!.save();
                          try {
                            setState(() {
                              isLoading = true;
                            });
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser?.email)
                                .update({
                              "name": users.name,
                              "phone": users.phone,
                              "description": users.description,
                              "open": users.open?.format(context),
                              "close": users.close?.format(context),
                              "category": users.category
                            }).then((value) => {
                                      Fluttertoast.showToast(
                                          msg: "แก้ไขสำเร็จ",
                                          gravity: ToastGravity.CENTER),
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeScreen()),
                                          (route) => false)
                                    });
                          } on FirebaseAuthException catch (err) {
                            Fluttertoast.showToast(msg: err.message!);
                          } finally {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      },
                    ),
                  ]),
            ),
          ));
        });
  }
}
