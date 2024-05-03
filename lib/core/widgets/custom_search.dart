// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:free_lancer/core/extension/extension.dart';
import 'package:free_lancer/core/utils/app_colors.dart';
import 'package:free_lancer/core/widgets/custom_text_field.dart';

class CustomSearchWidget extends StatelessWidget {
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final Function(String value)? onChanged;
  final Color? color;
  final Function()? onTap;
  const CustomSearchWidget({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.onChanged,
    this.color = AppColors.redDart,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(8),
      height: context.width / 3.3,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.lightgray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: CustomTextField(
        hintText: hintText,
        fillColor: AppColors.white,
        hintStyle: TextStyle(
          color: color,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        onChanged: onChanged,
        onTap: onTap,
        controller: controller,
      ),
    );
  }
}
