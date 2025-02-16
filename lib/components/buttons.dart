import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/helpers/extensions.dart';



class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    this.targetPlatform,
    this.title,
    this.customTitle,
    this.onPressed,
    this.contentColor,
    this.backgroundColor,
    this.borderColor,
    this.style,
    this.isEnabled = true,
    this.textStyle,
    this.borderRadius, this.height, this.width,
  });

  final TargetPlatform? targetPlatform;
  final String? title;
  final Widget? customTitle;
  final Function? onPressed;
  final Color? contentColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final double? height;
  final double? width;
  final ButtonStyle? style;
  final TextStyle? textStyle;
  final bool isEnabled;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if(TargetPlatform.iOS == (widget.targetPlatform ?? context.platform))...[
          SizedBox(
            width: widget.width ?? double.infinity,
            height: widget.height ?? 50.0,
            child: CupertinoButton(
              onPressed: !widget.isEnabled ? null : () async {
                if(widget.isEnabled){
                  HapticFeedback.selectionClick();
                  if(mounted){
                    setState(() {
                      isLoading = true;
                    });
                  }else{
                    isLoading = true;
                  }
                  await widget.onPressed?.call();
                  if(mounted){
                    setState(() {
                      isLoading = false;
                    });
                  }else{
                    isLoading = false;
                  }
                }
              },
              color: widget.backgroundColor ?? Theme.of(context).colorScheme.primary,
              disabledColor: context.colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 4),
              padding: 0.allPadding,
              child: widget.customTitle != null ? (isLoading ? const SizedBox.shrink() : (widget.customTitle ?? const SizedBox.shrink())) : Text(
                isLoading ? '' : widget.title ?? '',
                style: widget.textStyle ?? Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:  !widget.isEnabled ? Theme.of(context).colorScheme.onSurface.withOpacity(.5) : widget.contentColor ?? Theme.of(context).colorScheme.onPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
        if(TargetPlatform.iOS != (widget.targetPlatform ?? context.platform))...[
          SizedBox(
            width: widget.width ?? double.infinity,
            height: widget.height ?? 50.0,
            child: FilledButton(
              onPressed: !widget.isEnabled ? null : () async {
                if(widget.isEnabled){
                  HapticFeedback.selectionClick();
                  if(mounted){
                    setState(() {
                      isLoading = true;
                    });
                  }else{
                    isLoading = true;
                  }
                  await widget.onPressed?.call();
                  if(mounted){
                    setState(() {
                      isLoading = false;
                    });
                  }else{
                    isLoading = false;
                  }
                }
              },
              style: widget.style ?? ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                  !widget.isEnabled ? Theme.of(context).colorScheme.outlineVariant : widget.backgroundColor ?? Theme.of(context).colorScheme.primary,
                ),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius ?? 4),
                    side: BorderSide(color: !widget.isEnabled ? Theme.of(context).colorScheme.outlineVariant : widget.borderColor ?? Theme.of(context).colorScheme.primary,),
                  ),
                ),
              ),
              child: widget.customTitle != null ? (isLoading ? null : widget.customTitle) : Text(
                isLoading ? '' : widget.title ?? '',
                style: widget.textStyle ?? Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:  !widget.isEnabled ? Theme.of(context).colorScheme.onSurface.withOpacity(.5) : widget.contentColor ?? Theme.of(context).colorScheme.onPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],

        if(TargetPlatform.iOS == (widget.targetPlatform ?? context.platform) && isLoading)...{
          SizedBox(
            width: (widget.height ?? 50.0) - 10,
            height: (widget.height ?? 50.0) - 10,
            child: CupertinoActivityIndicator(
              radius: ((widget.height ?? 50.0)/2) - 10,
              color: widget.contentColor ?? Theme.of(context).colorScheme.onPrimary,
            ),
          )
        },
        if(TargetPlatform.iOS != (widget.targetPlatform ?? context.platform) && isLoading)...{
          SizedBox(
            width: 25,
            height: 25,
            child: CircularProgressIndicator(
              color: widget.contentColor ?? Theme.of(context).colorScheme.onPrimary,
              strokeWidth: 2,
            ),
          )
        }
      ],
    );
  }
}