import 'package:flutter/material.dart';
import 'package:queueie/constants.dart';

class RoundedTimeRange extends StatelessWidget {
  final VoidCallback? onPress;
  final String? text;
  const RoundedTimeRange({Key? key, this.onPress, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: onTimePicker(
          text: text,
          onPress: onPress,
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class onTimePicker extends StatelessWidget {
  final VoidCallback? onPress;
  final String? text;
  const onTimePicker({Key? key, required this.onPress, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: text != null
          ? Text(text!,
              style: const TextStyle(fontSize: 18, color: Colors.white))
          : const Text("เลือกเวลาเปิด-ปิด",
              style: TextStyle(fontSize: 18, color: Colors.white)),
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
          primary: kPrimaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          textStyle: const TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
    );
  }
}
