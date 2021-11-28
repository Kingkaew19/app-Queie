import 'package:flutter/material.dart';

class Users {
  String? email;
  String? password;
  String? name;
  String? description;
  String? userType; // user shop service
  String? phone;
  TimeOfDay? open;
  TimeOfDay? close;
  Users(
      {this.email,
      this.password,
      this.name,
      this.description,
      this.userType,
      this.phone,
      this.open,
      this.close});
}
