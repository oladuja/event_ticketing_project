import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  const FormTextField({
    super.key,
    required this.hintText, required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14),
        contentPadding: EdgeInsets.only(left: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
