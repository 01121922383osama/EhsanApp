import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class BuildTextFieldWidget extends StatelessWidget {
  final String hintText;
  final bool inputAction;
  const BuildTextFieldWidget({
    super.key,
    required this.hintText,
    this.inputAction = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.black.withOpacity(0.3)),
        fillColor: AppColors.white,
        filled: true,
      ),
      textInputAction:
          inputAction ? TextInputAction.done : TextInputAction.next,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}
