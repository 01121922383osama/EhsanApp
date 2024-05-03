import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../extension/extension.dart';
import '../utils/app_colors.dart';

class BuildIconBackWidget extends StatelessWidget {
  const BuildIconBackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: CircleAvatar(
          radius: 25,
          child: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              CupertinoIcons.back,
              color: AppColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
