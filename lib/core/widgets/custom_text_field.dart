import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function()? onTap;
  final Color? fillColor;
  final TextStyle? hintStyle;
  final Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.onChanged,
    this.fillColor = AppColors.backgroundScaffold,
    this.hintStyle = const TextStyle(
      color: AppColors.grey,
    ),
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.emailAddress,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      controller: controller,
      onTap: onTap,
      onChanged: onChanged,
      autocorrect: true,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide.none,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        fillColor: fillColor,
        filled: true,
        isDense: true,
      ),
      keyboardType: keyboardType,
      textInputAction: textInputAction,
    );
  }
}
