import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:queueie/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final String? val;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final TextInputType? inputType;
  final FieldValidator validator;
  final List<TextInputFormatter>? format;
  final int? maxLines;
  const RoundedInputField(
      {Key? key,
      required this.hintText,
      required this.icon,
      this.onChanged,
      this.inputType,
      this.onSaved,
      required this.validator,
      this.format,
      this.val,
      this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        keyboardType: inputType,
        inputFormatters: format,
        onChanged: onChanged,
        initialValue: val,
        onSaved: onSaved,
        validator: validator,
        maxLines: maxLines != null ? 1 * maxLines! : 1,
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: kPrimaryColor,
            ),
            border: InputBorder.none,
            hintText: hintText),
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget? child;
  const TextFieldContainer({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
          color: kPrimaryLightColor,
          borderRadius: BorderRadius.circular(29),
          border: Border.all()),
      child: child,
    );
  }
}
