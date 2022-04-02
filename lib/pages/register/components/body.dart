import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:queueie/components/rounded_button.dart';
import 'package:queueie/components/rounded_dropdow.dart';
import 'package:queueie/components/rounded_password_field.dart';
import 'package:queueie/components/text_field_container.dart';
import 'package:queueie/constants.dart';
import 'package:queueie/model/profile.dart';
import 'package:queueie/pages/queuenumber/components/body.dart';
import 'package:queueie/pages/queuenumber/queuenumber_screen.dart';
import 'package:queueie/pages/register/components/background.dart';
import 'package:queueie/pages/home/home_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final formRegister = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  Users users = Users();

  bool isLoading = false;
  String chooseType = 'Choose Type';
  List<String> type = ['Choose Type', 'shop', 'user'];

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
            body: Center(child: Text("${snapshot.error}")),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Background(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Register",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Form(
                    key: formRegister,
                    child: Column(
                      children: [
                        RoundedInputField(
                          hintText: "Email",
                          icon: Icons.email,
                          inputType: TextInputType.emailAddress,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "กรุณาใส่ Email!"),
                            EmailValidator(
                                errorText: "รูปแบบ Email ไม่ถูกต้อง"),
                          ]),
                          onSaved: (value) {
                            users.email = value;
                          },
                        ),
                        RoundedInputField(
                          hintText: "Phone",
                          icon: Icons.phone,
                          inputType: TextInputType.number,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "กรุณาใส่ phone!"),
                          ]),
                          onSaved: (value) {
                            users.phone = value;
                          },
                        ),
                        RoundedInputField(
                          hintText: "Name",
                          icon: Icons.person,
                          inputType: TextInputType.name,
                          validator:
                              RequiredValidator(errorText: "Name is required!"),
                          onSaved: (value) {
                            users.name = value;
                          },
                        ),
                        RoundedPasswordField(
                          hintText: "Password",
                          validator: RequiredValidator(
                              errorText: "กรุณากรอก password!"),
                          onSaved: (value) {
                            users.password = value;
                          },
                        ),
                        RoundedDropdow(
                          value: chooseType,
                          list: type
                              .map((item) => DropdownMenuItem(
                                  child: Text(item), value: item))
                              .toList(),
                          hint: "ประเภท",
                          onChanged: (value) {
                            print(chooseType);
                            setState(() => chooseType = value);
                            print(chooseType);
                          },
                        ),
                        RoundedButton(
                            text: "Register",
                            isLoading: isLoading,
                            press: () async {
                              if (formRegister.currentState!.validate()) {
                                formRegister.currentState!.save();

                                if (chooseType == 'user') {
                                  try {
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: users.email!,
                                            password: users.password!)
                                        .then((value) => FirebaseFirestore
                                            .instance
                                            .collection('users')
                                            .doc(users.email)
                                            .set({
                                              "name": users.name,
                                              "email": users.email,
                                              "phone": users.phone,
                                              "userType": chooseType
                                            })
                                            .then(
                                              (value) =>
                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const HomeScreen()),
                                                      (route) => false),
                                            )
                                            .catchError((error) =>
                                                Fluttertoast.showToast(
                                                    msg: error,
                                                    gravity:
                                                        ToastGravity.CENTER)));
                                  } on FirebaseAuthException catch (err) {
                                    Fluttertoast.showToast(
                                        msg: err.message!,
                                        gravity: ToastGravity.TOP);
                                  } finally {
                                    setState(() => isLoading = false);
                                  }
                                } else if (chooseType == 'shop') {
                                  try {
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: users.email!,
                                            password: users.password!)
                                        .then((value) => FirebaseFirestore
                                            .instance
                                            .collection('users')
                                            .doc(users.email)
                                            .set({
                                              "name": users.name,
                                              "email": users.email,
                                              "phone": users.phone,
                                              "userType": chooseType
                                            })
                                            .then(
                                              (value) =>
                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const Queuenumber()),
                                                      (route) => false),
                                            )
                                            .catchError((error) =>
                                                Fluttertoast.showToast(
                                                    msg: error,
                                                    gravity:
                                                        ToastGravity.CENTER)));
                                  } on FirebaseAuthException catch (err) {
                                    Fluttertoast.showToast(
                                        msg: err.message!,
                                        gravity: ToastGravity.TOP);
                                  } finally {
                                    setState(() => isLoading = false);
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Please choose type",
                                      gravity: ToastGravity.CENTER);
                                }
                              }
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
