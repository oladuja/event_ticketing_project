import 'package:flutter/material.dart';

import '../helpers/app_icons.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    this.icon,
    this.assetIcon,
    this.width,
    this.height,
    this.assetIconWidth,
    this.assetIconHeight,
    this.iconSize,
    this.radius,
    this.borderWidth,
    this.margin,
    this.iconColor,
    this.backgroundColor,
    this.borderColor,
    this.onPressed,
  });
  final IconData? icon;
  final String? assetIcon;
  final double? width;
  final double? height;
  final double? assetIconWidth;
  final double? assetIconHeight;
  final double? iconSize;
  final double? radius;
  final double? borderWidth;
  final EdgeInsets? margin;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 360),
      child: Container(
        width: width ?? 45,
        height: height ?? 45,
        margin: margin,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 360),
            side: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: borderWidth ?? 1,
            ),
          ),
          color: backgroundColor ?? Theme.of(context).colorScheme.primary.withOpacity(.1),
        ),
        child: InkWell(
          onTap: () {
            onPressed?.call();
          },
          borderRadius: BorderRadius.circular(radius ?? 360),
          child: Builder(
            builder: (context) {
              if(assetIcon != null){
                return Center(
                  child: AppIcons.icon(
                    assetIcon!,
                    width: assetIconWidth ?? AppIcons.sizeSmall,
                    height: assetIconHeight ?? AppIcons.sizeSmall,
                    color: iconColor,
                    fit: BoxFit.contain,
                  ),
                );
              }
              return Icon(
                icon ?? Icons.circle,
                color: iconColor ?? Theme.of(context).colorScheme.primary,
                size: iconSize,
              );
            }
          ),
        ),
      ),
    );
  }
}