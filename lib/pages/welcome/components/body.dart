import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:queueie/constants.dart';
import 'package:queueie/components/rounded_button.dart';
import 'package:queueie/pages/welcome/components/background.dart';
import 'package:queueie/pages/login/login_screen.dart';
import 'package:queueie/pages/register/register_screen.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: size.height * 0.45,
            ),
            Text("Welcome to Queueie", style: TextStyle(fontSize: 18)),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
                text: "Login",
                isLoading: false,
                press: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }),
            RoundedButton(
              text: "Register",
              isLoading: false,
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
