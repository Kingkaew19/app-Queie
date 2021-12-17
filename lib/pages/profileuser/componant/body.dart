import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/person.png'),
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
                    press: () {
                      if (updateProfileuser.currentState!.validate()) {
                        updateProfileuser.currentState!.save();
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
}
