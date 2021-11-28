import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:queueie/components/rounded_button.dart';
import 'package:queueie/components/rounded_dropdow.dart';
import 'package:queueie/components/rounded_password_field.dart';
import 'package:queueie/components/text_field_container.dart';
import 'package:queueie/constants.dart';
import 'package:queueie/model/profile.dart';
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
  String chooseType = 'ผู้ใช้งานทั่วไป';
  List<String> type = ['ผู้ใช้งานทั่วไป', 'ร้านค้าและบริการ'];

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
                          text: "ประเภท",
                          onChanged: (value) {
                            setState(() => chooseType = value);
                          },
                        ),
                        RoundedButton(
                            text: "Register",
                            isLoading: isLoading,
                            press: () async {
                              if (formRegister.currentState!.validate()) {
                                formRegister.currentState!.save();
                                try {
                                  setState(() => isLoading = true);
                                  await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: users.email!,
                                          password: users.password!)
                                      .then((value) => {
                                            if (chooseType == 'ผู้ใช้งานทั่วไป')
                                              {
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(users.email)
                                                    .set({
                                                  "name": users.name,
                                                  "email": users.email,
                                                  "phone": users.phone,
                                                }).catchError((error) =>
                                                        Fluttertoast.showToast(
                                                            msg: error,
                                                            gravity:
                                                                ToastGravity
                                                                    .CENTER))
                                              }
                                            else if (chooseType ==
                                                "ร้านค้าและบริการ")
                                              {
                                                FirebaseFirestore.instance
                                                    .collection('shops')
                                                    .doc(users.email)
                                                    .set({
                                                  "name": users.name,
                                                  "email": users.email,
                                                  "phone": users.phone,
                                                }).catchError((error) =>
                                                        Fluttertoast.showToast(
                                                            msg: error,
                                                            gravity:
                                                                ToastGravity
                                                                    .CENTER))
                                              },
                                            Fluttertoast.showToast(
                                                msg: "สร้างบัญชีสำเร็จ",
                                                gravity: ToastGravity.TOP),
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const HomeScreen()),
                                                (route) => false),
                                            formRegister.currentState!.reset()
                                          });
                                } on FirebaseAuthException catch (err) {
                                  Fluttertoast.showToast(
                                      msg: err.message!,
                                      gravity: ToastGravity.TOP);
                                } finally {
                                  setState(() => isLoading = false);
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
