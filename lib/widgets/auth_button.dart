import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final double? width;
  final double? height;
  final double? borderRadius;
  final TextStyle? textStyle;
  final Color? foregroundColor;
  final Color? backgroundColor;

  const AuthButton({
    super.key,
    required this.text,
    this.onPressed,
    this.width,
    this.height,
    this.borderRadius,
    this.textStyle,
    this.foregroundColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: (width ?? MediaQuery.of(context).size.width / 2).w,
      width: double.infinity,
      height: (height ?? 45).h,
      child: FilledButton(
        style: ButtonStyle(
          foregroundColor:
              WidgetStateProperty.all(foregroundColor ?? Colors.white),
          backgroundColor:
              WidgetStateProperty.all(backgroundColor ?? Colors.black),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular((borderRadius ?? 15).r),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
