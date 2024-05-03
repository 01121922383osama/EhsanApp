import 'package:flutter/cupertino.dart';

import '../../../../core/utils/app_colors.dart';

class TrailingWidget extends StatelessWidget {
  final String suraName;
  const TrailingWidget({super.key, required this.suraName});

  @override
  Widget build(BuildContext context) {
    return Text(
      suraName,
      style: const TextStyle(
        color: AppColors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
