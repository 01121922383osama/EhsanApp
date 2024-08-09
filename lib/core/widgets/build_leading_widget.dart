import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../extension/extension.dart';

class BuildIconBackWidget extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? icon;
  const BuildIconBackWidget({
    super.key,
    this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: IconButton.outlined(
        onPressed: onPressed ??
            () {
              context.pop();
            },
        icon: icon ??
            const Icon(
              CupertinoIcons.back,
              // color:
            ),
      ),
    );
  }
}
