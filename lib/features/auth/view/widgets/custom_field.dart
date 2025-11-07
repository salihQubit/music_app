import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObSecure;
  const CustomField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObSecure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: hintText),
      controller: controller,
      obscureText: isObSecure,
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "$hintText cannot be empty";
        }
        return null;
      },
    );
  }
}
