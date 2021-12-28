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
import 'package:queueie/components/text_field_container.dart';
import 'package:queueie/model/profile.dart';
import 'package:queueie/pages/detailsshop/components/background.dart';
import 'package:queueie/pages/home/home_screen.dart';

class bodyProfileuser extends StatefulWidget {
  const bodyProfileuser({Key? key}) : super(key: key);

  @override
  _bodyProfileuserState createState() => _bodyProfileuserState();
}

class _bodyProfileuserState extends State<bodyProfileuser> {
  final updateProfileuser = GlobalKey<FormState>();
  Users users = Users();
  bool isLoading = false;
  File? image;
  String? urlImage;

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
            key: updateProfileuser,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      child: image == null
                          ? CircleAvatar(
                              radius: 45,
                              backgroundImage:
                                  NetworkImage(snapshot.data!['urlImage']),
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
                    hintText: "เบอร์โทร",
                    val: snapshot.data!['phone'],
                    icon: Icons.phone,
                    validator: RequiredValidator(errorText: "กรุณาใส่เบอร์โทร"),
                    onSaved: (value) {
                      setState(() => users.phone = value);
                    },
                  ),
                  RoundedButton(
                    text: 'บันทึก',
                    isLoading: isLoading,
                    sized: 0.47,
                    press: isLoading
                        ? null
                        : () async {
                            if (updateProfileuser.currentState!.validate()) {
                              updateProfileuser.currentState!.save();
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
                                  "urlImage": urlImage
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
                ],
              ),
            ),
          ));
        });
  }

  Future<void> upLoadImageToStorage() async {
    String time = DateTime.now()
        .toString()
        .replaceAll("-", "_")
        .replaceAll(":", "_")
        .replaceAll(" ", "_");
    print('time : $time');

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    Reference reference = firebaseStorage.ref().child('users/user$time.jpg');

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
}
