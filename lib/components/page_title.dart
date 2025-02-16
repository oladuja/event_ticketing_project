import 'package:flutter/material.dart';
import 'package:project/helpers/extensions.dart';



class PageTitle extends StatelessWidget{
  const PageTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.fontSize,
    this.subTitleFontSize,
    this.height = 0,
    this.subTitleColor,
  });
  final String title;
  final String? subtitle;
  final double? fontSize;
  final double? subTitleFontSize;
  final double height;
  final Color? subTitleColor;

  @override
  Widget build(BuildContext context) => Column(
    key: key,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontSize: fontSize ?? 30,
          fontWeight: FontWeight.w600,
        ),
      ),
      height.heightBox,
      if(subtitle != null)...[
        Text(
          subtitle!,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: subTitleFontSize ?? 16,
            fontWeight: FontWeight.w500,
            color: subTitleColor ?? Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    ],
  );
}

class PageTitleAndSubtitle extends StatelessWidget{
  const PageTitleAndSubtitle({
    super.key,
    required this.title,
    required this.subtitle,
    this.startWidget,
  });
  final String title;
  final String subtitle;
  final Widget? startWidget;

  @override
  Widget build(BuildContext context) => RichText(
    textAlign: TextAlign.start,
    text: TextSpan(
      children: [
        if(startWidget != null)...[
          WidgetSpan(
            child: startWidget!,
            alignment: PlaceholderAlignment.top,
          ),
        ],
        TextSpan(
          text: title,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 16.responsiveText,
            decoration: TextDecoration.underline,
            decorationColor: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        TextSpan(
          text: ': ',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w400,
            fontSize: 14.responsiveText,
          ),
        ),
        TextSpan(
          text: subtitle,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w400,
            fontSize: 14.responsiveText,
          ),
        ),
      ],
    ),
  );
}