import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:queueie/constants.dart';
import 'package:queueie/pages/welcome/welcome_screen.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
          color: kPrimaryColor,
          child: ListView(
            children: [
              ProfileHeader(),
              const Divider(
                color: Colors.white,
              ),
              ListMenu(
                  text: "โปรไฟล์",
                  icon: Icons.person,
                  onTap: () => selectedItem(context, 0)),
              const SizedBox(height: 16),
              ListMenu(
                text: "คิวของฉัน",
                icon: Icons.people,
                onTap: () {},
              ),
              const SizedBox(height: 16),
              ListMenu(
                text: "ออกจากระบบ",
                icon: Icons.logout,
                onTap: () => selectedItem(context, 2),
              ),
            ],
          )),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final String? name;
  final String? email;
  const ProfileHeader({
    Key? key,
    this.name,
    this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Z2VudGxlbWFufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Natthapong Lakaew",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    )),
                SizedBox(
                  height: 4,
                ),
                Text("bank.tdev@gmail.com",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ListMenu extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const ListMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: TextStyle(color: color),
      ),
      onTap: onTap,
    );
  }
}

void selectedItem(BuildContext context, int index) {
  final auth = FirebaseAuth.instance;
  switch (index) {
    case 0:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const WelcomeScreen()));
      break;
    case 2:
      auth.signOut().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                (route) => false),
            Fluttertoast.showToast(
                msg: "Logout สำเร็จ", gravity: ToastGravity.TOP)
          });
  }
}
