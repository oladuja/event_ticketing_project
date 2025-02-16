
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:project/helpers/extensions.dart';



import 'app_icon_button.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({super.key,
    this.controller,
    this.onChanged,
    this.hint,
    this.label,
    this.validator,
    this.borderRadius,
    this.borderColor,
    this.focusedBorderColor,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.onTap,
    this.labelSuffix,
    this.textStyle,
    this.readOnly,
    this.enabled,
    this.keyboardType,
    this.keyboardAction,
    this.height,
    this.width,
    this.borderWidth,
    this.suffix,
    this.prefix,
    this.focusNode,
    this.onEditingComplete,
    this.autoValidateMode,
    this.textColor,
    this.onFocusChanged,
    this.contentPadding,
    this.inputFormatters,
    this.customLabel, this.obscureText, this.obscuringCharacter, this.hideMaxLengthCounter,
    this.textAlign, this.textAlignVertical,
    this.fillColor,
    this.hintColor,
    this.mainAxisAlignment,
  });

  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Widget? customLabel;
  final String? hint;
  final String? label;
  final String? labelSuffix;
  final String? Function(String?)? validator;
  final AutovalidateMode? autoValidateMode;
  final TextStyle? textStyle;

  final double? borderRadius;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? textColor;
  final Color? fillColor;
  final Color? hintColor;

  final int? maxLines;
  final int? minLines;
  final int? maxLength;

  final Function()? onTap;

  final bool? enabled;
  final bool? readOnly;
  final bool? obscureText;
  final String? obscuringCharacter;
  final String? hideMaxLengthCounter;
  final TextInputType? keyboardType;
  final TextInputAction? keyboardAction;

  final double? height;
  final double? width;
  final double? borderWidth;

  final Widget? suffix;
  final Widget? prefix;

  final FocusNode? focusNode;
  final Function()? onEditingComplete;
  final Function(bool)? onFocusChanged;

  final EdgeInsets? contentPadding;

  final List<TextInputFormatter>? inputFormatters;

  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;

  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
    children: [
      if(label != null || customLabel != null)...[
        Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(label != null)...[
                Text(
                  label!,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.responsiveText,
                  ),
                ),
              ],
              if(customLabel != null)...[
                customLabel!,
              ],
            ],
          ),
        ),
      ],
      SizedBox(
        height: height,
        width: width,
        child: Focus(
          onFocusChange: onFocusChanged,
          child: TextFormField(
            focusNode: focusNode,
            key: key,
            maxLength: maxLength,
            controller: controller,
            maxLines: height == null ? maxLines ?? 1 : null,
            minLines: height == null ? minLines ?? 1 : null,
            validator: validator,
            onTap: onTap,
            textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
            textAlign: textAlign ?? TextAlign.start,
            expands: height != null,
            onChanged: onChanged,
            readOnly: readOnly ?? false,
            enabled: enabled ?? true,
            obscureText: obscureText ?? false,
            obscuringCharacter: obscuringCharacter ?? '•',
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            autovalidateMode: autoValidateMode ?? AutovalidateMode.disabled,
            textInputAction: keyboardAction,
            onEditingComplete: onEditingComplete,
            cursorColor: textColor ?? Theme.of(context).colorScheme.onSurface,
            cursorWidth: 1,
            style: textStyle ??
                Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16.responsiveText,
                  fontWeight: FontWeight.w400,
                  color: textColor ?? Theme.of(context).colorScheme.onSurface,
                ),
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              hintStyle: (textStyle ?? Theme.of(context).textTheme.bodyLarge)?.copyWith(
                color: hintColor ?? Theme.of(context).colorScheme.onSurface.withOpacity(.5),
              ),
              fillColor: fillColor ?? Colors.transparent,
              contentPadding: contentPadding ?? const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 5)),
                borderSide: BorderSide(
                  color: borderColor ?? context.colorScheme.onSurface,
                  width: borderWidth ?? 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 5)),
                borderSide: BorderSide(
                  color: borderColor ?? context.colorScheme.onSurface,
                  width: borderWidth ?? 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 5)),
                borderSide: BorderSide(
                  color: borderColor ?? context.colorScheme.onSurface,
                  width: borderWidth ?? 1,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 5)),
                borderSide: BorderSide(
                  color: borderColor ?? context.colorScheme.onSurface,
                  width: borderWidth ?? 1,
                ),
              ),
              suffixIcon: suffix,
              suffixIconConstraints: const BoxConstraints(),
              prefixIcon: prefix,
              prefixIconConstraints: const BoxConstraints(),
              counterText: hideMaxLengthCounter ?? '',
            ),
          ),
        ),
      ),
    ],
  );
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.searchController,
    this.hint,
    this.showFilter = true,
    this.onFilterPressed,
  });

  final TextEditingController searchController;
  final String? hint;
  final bool showFilter;
  final void Function()? onFilterPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: AppTextField(
            controller: searchController,
            hint: hint ?? "search",
            prefix: Padding(
              padding: 8.horizontalPadding,
              child: Icon(
                Iconsax.search_normal,
                size: 20,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(.5),
              ),
            ),
            borderRadius: 5,
          ),
        ),
        if(showFilter)...[
          AppIconButton(
            icon: Iconsax.filter,
            margin: 15.leftPadding,
            radius: 5,
            onPressed: () {
              onFilterPressed?.call();
            },
          ),
        ],
      ],
    );
  }
}

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    this.passwordController,
    this.hint,
    this.label,
    this.validator,
  });

  final TextEditingController? passwordController;
  final String? hint;
  final String? label;
  final String? Function(String?)? validator;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}
class _PasswordTextFieldState extends State<PasswordTextField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: widget.passwordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: !showPassword,
      obscuringCharacter: '*',
      customLabel: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: Row(
          children: [
            Text(
              widget.label ?? 'Password',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w600,
                fontSize: 16.responsiveText,
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              child: Text(
                showPassword ? 'HIDE' : 'SHOW',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.responsiveText,
                  decoration: TextDecoration.underline,
                  decorationColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
      hint: widget.hint ?? '******',
      validator: widget.validator ?? (value) {
        if (value!.isEmpty) {
          return 'Password is required';
        }
        return null;
      },
    );
  }
}

// class PhoneNumberTextField extends StatefulWidget {
//   const PhoneNumberTextField({
//     super.key,
//     this.selectedCountry,
//     this.selectedCountryCode,
//     this.displayCountryCode = false,
//     this.validator,
//     this.hintText,
//     this.phoneNumberController,
//     this.onCountrySelected,
//     this.supportedCountries = const [],
//   });
//   final Country? selectedCountry;
//   final TextEditingController? selectedCountryCode;
//   final bool displayCountryCode;
//   final String? hintText;
//   final String? Function(String?)? validator;
//   final TextEditingController? phoneNumberController;
//   final Function(Country?)? onCountrySelected;
//   final List<String> supportedCountries;
//
//   @override
//   State<PhoneNumberTextField> createState() => _PhoneNumberTextFieldState();
// }
//
// class _PhoneNumberTextFieldState extends State<PhoneNumberTextField> {
//   TextEditingController selectedCountryCode = TextEditingController();
//   Country? selectedCountry;
//
//   @override
//   void initState() {
//     super.initState();
//     if(widget.selectedCountryCode != null){
//       selectedCountryCode = widget.selectedCountryCode!;
//     }else{
//       selectedCountryCode.text = '234';
//     }
//     if(widget.displayCountryCode) {
//       selectedCountryCode.text = selectedCountry?.phoneCode ?? "";
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CountryPicker(
//           width: 104,
//           displayFullCountryName: false,
//           countryController: selectedCountryCode,
//           supportedCountries: widget.supportedCountries,
//           selectedCountry: widget.selectedCountry,
//           onCountrySelected: (value) {
//             selectedCountry = value as Country;
//             if(widget.displayCountryCode) {
//               selectedCountryCode.text = selectedCountry?.phoneCode ?? "";
//             }
//             setState(() {});
//             if(widget.onCountrySelected != null){
//               widget.onCountrySelected!(value);
//             }
//           },
//         ),
//         10.widthBox,
//         Expanded(
//           child: AppTextField(
//             controller: widget.phoneNumberController,
//             hint: widget.hintText,
//             keyboardType: TextInputType.phone,
//             textAlignVertical: TextAlignVertical.center,
//             prefix: Text('+${selectedCountry?.phoneCode ?? "1"}',
//               style: const TextStyle(fontSize: 12),
//             ).withPadding(left: 10, right: 5, bottom: 1.5),
//             textStyle: const TextStyle(
//               fontSize: 12
//             ),
//             validator: widget.validator,
//           ),
//         )
//       ],
//     );
//   }
// }

