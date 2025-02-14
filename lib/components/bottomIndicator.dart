import 'package:flutter/material.dart';

class BottomIndicator extends StatelessWidget {
  const BottomIndicator({
    super.key,
    this.index = 0,
    this.width = 18,
    this.height = 18,

  });
  final int index;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          key: const ValueKey(0),
          duration: const Duration(milliseconds: 300),
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: index == 0 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.outline.withOpacity(.5),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        const SizedBox(width: 10),
        AnimatedContainer(
          key: const ValueKey(1),
          duration: const Duration(milliseconds: 300),
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: index == 1 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.outline.withOpacity(.5),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        const SizedBox(width: 10),
        AnimatedContainer(
          key: const ValueKey(2),
          duration: const Duration(milliseconds: 300),
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: index == 2 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.outline.withOpacity(.5),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ],
    );
  }
}