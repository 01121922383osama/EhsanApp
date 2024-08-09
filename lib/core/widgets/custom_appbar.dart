import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final Color color;
  final double scrolledUnderElevation;
  final bool centerTitle;
  const CustomAppbar({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.color = Colors.transparent,
    this.centerTitle = false,
    this.scrolledUnderElevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        scrolledUnderElevation: scrolledUnderElevation,
        backgroundColor: Colors.transparent,
        leading: leading,
        title: title,
        centerTitle: centerTitle,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 60);
}
