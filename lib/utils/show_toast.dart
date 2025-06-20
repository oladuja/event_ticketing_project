import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showToast(String message, ToastificationType type, BuildContext context) {
  toastification.show(
    context: context,
    type: type,
    style: ToastificationStyle.fillColored,
    title: Text(message),
    autoCloseDuration: const Duration(seconds: 4),
  );
}
