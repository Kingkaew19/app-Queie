import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:queueie/components/text_field_container.dart';
import 'package:queueie/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final String? hintText;
  final IconData? suffixIcon;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final FieldValidator validator;
  const RoundedPasswordField({
    Key? key,
    this.onChanged,
    this.hintText,
    this.suffixIcon,
    this.onSaved,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextFormField(
            onChanged: onChanged,
            onSaved: onSaved,
            validator: validator,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              hintText: hintText,
              icon: const Icon(
                Icons.lock,
                color: kPrimaryColor,
              ),
              suffixIcon: Icon(
                suffixIcon,
                color: kPrimaryColor,
              ),
              border: InputBorder.none,
            )));
  }
}
