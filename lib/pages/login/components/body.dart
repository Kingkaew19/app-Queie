import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:queueie/components/rounded_button.dart';
import 'package:queueie/components/rounded_password_field.dart';
import 'package:queueie/components/text_field_container.dart';
import 'package:queueie/constants.dart';
import 'package:queueie/model/profile.dart';
import 'package:queueie/pages/home/home_screen.dart';
import 'package:queueie/pages/login/components/background.dart';
import 'package:queueie/pages/queuenumber/queuenumber_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final formLogin = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  Users users = Users();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Error"),
                backgroundColor: kPrimaryColor,
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Background(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Login", style: TextStyle(fontSize: 18)),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Form(
                  key: formLogin,
                  child: Column(
                    children: [
                      RoundedInputField(
                        hintText: "Your Email",
                        icon: Icons.email,
                        inputType: TextInputType.emailAddress,
                        validator:
                            RequiredValidator(errorText: "กรุณาใส่ Email"),
                        onSaved: (value) {
                          users.email = value;
                        },
                      ),
                      RoundedPasswordField(
                        hintText: "Your password",
                        validator:
                            RequiredValidator(errorText: "กรุณาใส่ Password"),
                        onSaved: (value) {
                          users.password = value;
                        },
                      ),
                      RoundedButton(
                          isLoading: isLoading,
                          text: "Login",
                          press: () async {
                            if (formLogin.currentState!.validate()) {
                              formLogin.currentState!.save();
                              try {
                                setState(() {
                                  isLoading = true;
                                });
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: users.email!,
                                        password: users.password!)
                                    .then((value) => {
                                          Fluttertoast.showToast(
                                              msg: "Login สำเร็จ",
                                              gravity: ToastGravity.CENTER),
                                          formLogin.currentState!.reset(),
                                          //print(users.userType),
                                          // if (users.userType == "user")
                                          //   {
                                          //     Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //             builder: (context) =>
                                          //                 const HomeScreen())),
                                          //   }
                                          // else
                                          //   {
                                          //     Navigator.pushAndRemoveUntil(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //             builder: (context) =>
                                          //                 const Number()),
                                          //         (route) => false),
                                          //   }

                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(FirebaseAuth
                                                  .instance.currentUser?.email)
                                              .get()
                                              .then((value) => {
                                                    setState(() {
                                                      users.email = value
                                                          .data()?["email"];
                                                      users.name =
                                                          value.data()?["name"];
                                                      users.phone = value
                                                          .data()?["phone"];
                                                      users.userType = value
                                                          .data()?["userType"];
                                                    }),
                                                    if (users.userType ==
                                                        "user")
                                                      {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const HomeScreen())),
                                                      }
                                                    else if (users.userType ==
                                                        "shop")
                                                      {
                                                        Navigator.pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const Queuenumber()),
                                                            (route) => false),
                                                      }
                                                  })
                                        });
                              } on FirebaseAuthException catch (err) {
                                if (err.code == "user-not-found") {
                                  Fluttertoast.showToast(
                                      msg:
                                          "ไม่มีผู้ใช้นี้ในระบบ/รหัสผ่านไม่ถูกต้อง",
                                      gravity: ToastGravity.TOP);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: err.message!,
                                      gravity: ToastGravity.TOP);
                                }
                              } finally {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          })
                    ],
                  ),
                )
              ],
            ));
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
