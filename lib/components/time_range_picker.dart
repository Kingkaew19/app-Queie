import 'package:flutter/material.dart';
import 'package:queueie/constants.dart';
import 'package:time_range_picker/time_range_picker.dart';

class RoundedTimeRange extends StatelessWidget {
  final VoidCallback? onPress;
  final String? text;
  const RoundedTimeRange({Key? key, this.onPress, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          : Text("เลือกเวลาเปิด-ปิด",
              style: const TextStyle(fontSize: 18, color: Colors.white)),
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
          primary: kPrimaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          textStyle: const TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
    );
  }
}
