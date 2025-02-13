
import 'package:flutter/material.dart';

class AccountTypeButton extends StatelessWidget {
  final String title;
  final bool isBack;
  const AccountTypeButton({
    super.key,
    required this.title,
    required this.isBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
        color: isBack ? Colors.black : Colors.white,
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: isBack ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
