import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final bool isEnabled;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextDirection? textDirection;
  final TextInputType? keyboardType;
  final bool readOnly;
  final int maxLines;
  final int? minLines;
  final int? lenght;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final Widget? suffixIcon;
  final AutovalidateMode? autoValidateMode;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final TextAlign? textAlign;
  final double? horizontalPadding;
  final double? minSuffixWidth;
  final double? maxSuffixWidth;
  final bool? filled;
  final Color? fillColor;
  final List<TextInputFormatter>? inputFormatters;
  final bool autoFocus;
  final TextInputAction? textInputAction;
  const CustomTextField({
    super.key,
    this.hintText,
    this.onSubmit,
    this.label,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.textDirection,
    this.keyboardType,
    this.readOnly = false,
    this.maxLines = 1,
    this.onTap,
    this.suffixIcon,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.labelStyle,
    this.hintStyle,
    this.prefixIcon,
    this.textAlign,
    this.horizontalPadding,
    this.minLines,
    this.inputFormatters,
    this.minSuffixWidth = 70,
    this.maxSuffixWidth = 100,
    this.filled,
    this.fillColor = const Color(0xFFFBFBFB),
    this.onChanged,
    this.autoFocus = false,
    this.textInputAction,
    this.lenght,
    this.isEnabled = true,
  });

  static const _border = 14.0;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      autovalidateMode: autoValidateMode,
      onTap: onTap,
      onFieldSubmitted: onSubmit,
      enabled: isEnabled,
      maxLength: lenght,
      textInputAction: textInputAction,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      minLines: minLines,
      readOnly: readOnly,
      style: TextStyle(fontSize: 15, color: Colors.grey),
      keyboardType: keyboardType,
      textDirection: textDirection,
      obscureText: obscureText,
      validator: validator,
      controller: controller,
      onChanged: onChanged,
      autofocus: autoFocus,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        label: label == null ? null : Text(label!),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.3)),
        labelStyle:
            TextStyle(color: Colors.grey.withOpacity(0.5), fontSize: 14),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        suffixIconConstraints: BoxConstraints(
          maxHeight: 50,
          minWidth: minSuffixWidth == null ? 70 : minSuffixWidth!,
          maxWidth: maxSuffixWidth == null ? 70 : maxSuffixWidth!,
        ),
        prefixIconConstraints: const BoxConstraints(
          maxHeight: 50,
          minWidth: 45,
          maxWidth: 45,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_border),
          borderSide: const BorderSide(color: Colors.grey, width: 0.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_border),
          borderSide: const BorderSide(color: Colors.white, width: 0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_border),
          borderSide: const BorderSide(color: Colors.grey, width: 0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_border),
          borderSide: const BorderSide(color: Color(0xFFE70044)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_border),
          borderSide: const BorderSide(color: Color(0xFFE70044)),
        ),
        errorStyle: const TextStyle(fontSize: 12, color: Colors.red),
      ),
    );
  }
}
