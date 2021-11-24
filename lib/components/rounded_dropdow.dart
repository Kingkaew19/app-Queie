import 'package:flutter/material.dart';

class RoundedDropdow extends StatelessWidget {
  final String text;
  final String value;
  final List<DropdownMenuItem> list;
  final ValueChanged? onChanged;
  const RoundedDropdow(
      {Key? key,
      required this.value,
      required this.list,
      this.onChanged,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            value: value,
            items: list,
            onChanged: onChanged,
            hint: Text(text, style: const TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }
}
