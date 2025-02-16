import 'package:flutter/material.dart';
import 'package:project/helpers/extensions.dart';



class StartAndEndLabel extends StatelessWidget {
  const StartAndEndLabel({
    super.key,
    this.startLabel,
    this.endLabel,
    this.startLabelStyle,
    this.endLabelStyle,
  });
  final String? startLabel;
  final String? endLabel;
  final TextStyle? startLabelStyle;
  final TextStyle? endLabelStyle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: 0.allPadding.add((context.width * 0.05).horizontalPadding),
      dense: true,
      visualDensity: VisualDensity.compact,
      title: Text(
        startLabel ?? '',
        style: startLabelStyle ?? TextStyle(
          fontSize: 14.responsiveText,
          fontWeight: FontWeight.w400,
          color: context.colorScheme.onSurface.withOpacity(.5),
        ),
      ),
      trailing: Text(
        endLabel ?? '',
        style: endLabelStyle ?? TextStyle(
          fontSize: 14.responsiveText,
          fontWeight: FontWeight.w600,
          color: context.colorScheme.onSurface,
        ),
      ),
    );
  }
}

class SwitchWithLabel extends StatelessWidget {
  const SwitchWithLabel({
    super.key,
    this.active = false,
    this.label,
    this.onChanged,
  });
  final bool active;
  final String? label;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Switch(
          value: active,
          inactiveThumbColor: context.colorScheme.surface,
          inactiveTrackColor: context.colorScheme.outlineVariant,
          trackOutlineWidth: WidgetStateProperty.all(0),
          trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
          onChanged: onChanged,
        ),
        const SizedBox(width: 5),
        Text(
          label ?? '',
          style: TextStyle(
            fontSize: 14.responsiveText,
            fontWeight: FontWeight.w700,
            color: context.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}