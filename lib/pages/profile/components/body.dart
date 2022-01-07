import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:queueie/components/rounded_button.dart';
import 'package:queueie/components/rounded_dropdow.dart';
import 'package:queueie/components/text_field_container.dart';
import 'package:queueie/components/time_range_picker.dart';
import 'package:queueie/model/profile.dart';
import 'package:queueie/pages/profile/components/background.dart';
import 'package:queueie/pages/queuenumber/queuenumber_screen.dart';
import 'package:time_range_picker/time_range_picker.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  final updateProfile = GlobalKey<FormState>();
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  Users users = Users();
  bool isLoading = false;

  File? image;
  String? urlImage;

  String select = "กรุณาเลือกตำแหน่งที่ตั้ง";
  List<Map> location = [
    {
      'id': 0,
      'urlImage': 'assets/images/mapDPU.jpg',
      'name': 'กรุณาเลือกตำแหน่งที่ตั้ง'
    },
    {'id': 1, 'urlImage': 'assets/images/ตึก2.png', 'name': 'ตึก2'},
    {'id': 2, 'urlImage': 'assets/images/ตึก3.png', 'name': 'ตึก3'},
    {'id': 3, 'urlImage': 'assets/images/ตึก4.png', 'name': 'ตึก4'},
    {'id': 4, 'urlImage': 'assets/images/ตึก6ล่าง.png', 'name': 'ตึก6ล่าง'},
    {
      'id': 5,
      'urlImage': 'assets/images/ตึก6ห้องสมุด.png',
      'name': 'ตึก6ห้องสมุด'
    },
    {'id': 6, 'urlImage': 'assets/images/ตึก7.png', 'name': 'ตึก7'},
    {'id': 7, 'urlImage': 'assets/images/ตึก8.png', 'name': 'ตึก8'},
    {'id': 8, 'urlImage': 'assets/images/ตึก9.png', 'name': 'ตึก9'},
    {'id': 9, 'urlImage': 'assets/images/ตึก10.png', 'name': 'ตึก10'},
    {'id': 10, 'urlImage': 'assets/images/ตึก12.png', 'name': 'ตึก12'},
    {
      'id': 11,
      'urlImage': 'assets/images/ศูนย์บริการนศ.png',
      'name': 'ตึก6ห้องสมุด'
    },
  ];

  Future<void> pickImage(ImageSource imageSource) async {
    try {
      final Image = await ImagePicker().pickImage(source: imageSource);
      if (Image == null) return;

      final imageTemporary = File(Image.path);
      setState(() {
        image = imageTemporary;
        print("image : $image");
        isLoading = true;
      });

      upLoadImageToStorage();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> upLoadImageToStorage() async {
    String time = DateTime.now()
        .toString()
        .replaceAll("-", "_")
        .replaceAll(":", "_")
        .replaceAll(" ", "_");
    print('time : $time');

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    Reference reference = firebaseStorage.ref().child('shops/shop$time.jpg');

    UploadTask uploadTask = reference.putFile(image!);
    await uploadTask.then((TaskSnapshot taskSnapshot) async => {
          await taskSnapshot.ref.getDownloadURL().then((dynamic url) => {
                print("url : $url"),
                urlImage = url.toString(),
                setState(() {
                  isLoading = false;
                })
              })
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: fireStore
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
                        child: image == null
                            ? snapshot.data!['urlImage'] == null
                                ? const CircleAvatar(
                                    radius: 45,
                                    backgroundImage: NetworkImage(
                                        'https://firebasestorage.googleapis.com/v0/b/queueie.appspot.com/o/users%2Fperson.png?alt=media&token=184d240d-884a-4693-9c6a-01d8974f1ab2'),
                                  )
                                : CircleAvatar(
                                    radius: 45,
                                    backgroundImage: NetworkImage(
                                        snapshot.data!['urlImage']),
                                  )
                            : CircleAvatar(
                                radius: 45,
                                backgroundImage: FileImage(image!),
                              )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.deepPurple[400]),
                            onPressed: () => pickImage(ImageSource.camera),
                            icon: const Icon(Icons.camera_alt),
                            label: const Text("Pick Camera")),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.deepPurple[400]),
                            onPressed: () => pickImage(ImageSource.gallery),
                            icon: const Icon(Icons.photo),
                            label: const Text("Pick Gallery")),
                      ],
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
                    // RoundedDropdow(
                    //   value: select,
                    //   list: location
                    //       .map((item) => DropdownMenuItem(
                    //             value: item['id'],
                    //             child: Row(
                    //               children: [
                    //                 Image.asset(
                    //                   item['urlImage'],
                    //                   width: 25,
                    //                 ),
                    //                 Text(item['name'])
                    //               ],
                    //             ),
                    //           ))
                    //       .toList(),
                    //   hint: "กรุณาเลือกตำแหน่งที่ตั้ง",
                    //   onChanged: (value) {
                    //     setState(() {
                    //       print(select);
                    //       select = value;
                    //       print(select);
                    //     });
                    //   },
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 30),
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
                          //Image.file(select['urlImage']),
                        ],
                      ),
                    ),
                    RoundedButton(
                      text: 'บันทึก',
                      isLoading: isLoading,
                      sized: 0.47,
                      press: isLoading
                          ? null
                          : () {
                              if (updateProfile.currentState!.validate()) {
                                updateProfile.currentState!.save();
                                try {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(FirebaseAuth
                                          .instance.currentUser?.email)
                                      .update({
                                    "name": users.name,
                                    "phone": users.phone,
                                    "description": users.description,
                                    "open": users.open?.format(context),
                                    "close": users.close?.format(context),
                                    "category": users.category,

                                    "urlImage": urlImage,
                                    //"locationImage": select
                                  }).then((value) => {
                                            Fluttertoast.showToast(
                                                msg: "แก้ไขสำเร็จ",
                                                gravity: ToastGravity.CENTER),
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Queuenumber()),
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
