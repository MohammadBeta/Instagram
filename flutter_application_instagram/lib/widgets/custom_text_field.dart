import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController editingController;
  final String hintText;
  final bool isPassword;
  final TextInputType textInputType;

  const CustomTextField(
      {super.key,
      required this.editingController,
      required this.hintText,
      this.isPassword = false, required this.textInputType});

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      controller: editingController,
      decoration: InputDecoration(
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          filled: true,
          hintText: hintText,
          contentPadding: const EdgeInsets.all(6)),
      obscureText: isPassword,
      keyboardType: textInputType,
    );
  }
}
