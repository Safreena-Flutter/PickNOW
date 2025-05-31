import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picknow/costants/theme/appcolors.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final Widget? suffix;
  final String? hinttext;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? Function(String?)? submitFun;
  final List<TextInputFormatter>? textInputFormatter;
  final Color? fillColor;
  final IconButton? icon;
  final Widget? prefixIcon;
  final int? maxLengths;
  final int? minLines;
  final int? maxLines;
  final bool? isEnabled;
  final bool obscureText;
  final Color? focusColor;

  const CustomTextfield({
    this.textInputFormatter,
    this.fillColor,
    this.controller,
    super.key,
    this.label,
    this.suffix,
    this.maxLines,
    this.hinttext,
    this.keyboardType,
    this.validator,
    this.icon,
    this.prefixIcon,
    this.maxLengths,
    this.minLines,
    this.submitFun,
    this.isEnabled,
    this.focusColor,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnabled,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: submitFun,
      inputFormatters: textInputFormatter,
      maxLines: obscureText ? 1 : maxLines,
      maxLength: maxLengths,
      minLines:obscureText ? 1 : minLines,
      cursorColor: AppColors.cream,
      style: TextStyle(color: Colors.black),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffix: suffix,
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.whiteColor),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: focusColor ?? Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: focusColor ?? Colors.grey),
        ),
        fillColor: fillColor ?? AppColors.whiteColor,
        filled: true,
        labelText: label,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade600),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade600),
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: hinttext,
        prefixIcon: prefixIcon,
        suffixIcon: icon,
        hintStyle: const TextStyle(color: AppColors.grey),
        labelStyle: const TextStyle(
            color: AppColors.grey, fontSize: 15, fontWeight: FontWeight.w500),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(90),
        ),
      ),
      keyboardType: keyboardType,
    );
  }
}
 Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(prefixIcon, color: Color(0xFFFF6F00)),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
