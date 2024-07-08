import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      style: TextStyle(color: AppColors.black.withOpacity(0.5)),
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus!.unfocus();
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
          return AppLocalizations.of(context)!.plzEnterSomeText;
        }
        return null;
      },
    );
  }
}
