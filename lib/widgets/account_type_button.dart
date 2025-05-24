import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountTypeButton extends StatelessWidget {
  final String title;
  final bool isBack;
  final void Function()? onTap;
  final double width;
  final double height;
  final double borderRadius;
  final double fontSize;
  final Color? borderColor;
  final double borderWidth;
  final Color? backgroundColor;
  final Color? textColor;

  const AccountTypeButton({
    super.key,
    required this.title,
    required this.isBack,
    required this.onTap,
    this.width = 150,
    this.height = 50,
    this.borderRadius = 15,
    this.fontSize = 16,
    this.borderColor,
    this.borderWidth = 2,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius.r),
          border: Border.all(
            color: borderColor ?? Colors.black,
            width: borderWidth.w,
          ),
          color: backgroundColor ?? (isBack ? Colors.black : Colors.white),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: textColor ?? (isBack ? Colors.white : Colors.black),
              fontWeight: FontWeight.bold,
              fontSize: fontSize.sp,
            ),
          ),
        ),
      ),
    );
  }
}
