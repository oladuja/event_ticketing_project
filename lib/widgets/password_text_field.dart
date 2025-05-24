import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;

  const PasswordTextField({
    super.key,
    required this.hintText,
    this.controller,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () => setState(() {
            obscureText = !obscureText;
          }),
          icon: Icon(!obscureText ? Icons.visibility_off : Icons.visibility),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(fontSize: 14.sp),
        contentPadding: EdgeInsets.only(left: 15.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),
    );
  }
}
