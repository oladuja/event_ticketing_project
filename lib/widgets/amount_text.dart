import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AmountText extends StatelessWidget {
  final String title;
  final String value;
  final TextStyle? titleTextStyle;
  final TextStyle? valueTextStyle;
  final double gap;

  const AmountText({
    super.key,
    required this.title,
    required this.value,
    this.titleTextStyle,
    this.valueTextStyle,
    this.gap = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleTextStyle ??
              TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
        ),
        Gap(gap.h),
        Text(
          value,
          style: valueTextStyle ??
              TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 26.sp,
              ),
        ),
      ],
    );
  }
}