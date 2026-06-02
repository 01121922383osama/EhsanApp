import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Setting/presentation/cubit/Theme/theme_cubit.dart';

class BuildListTileWidget extends StatelessWidget {
  final String titlel;
  final Widget trailing;
  final VoidCallback onTap;

  const BuildListTileWidget({
    super.key,
    required this.titlel,
    required this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor.withOpacity(0.1),
                Theme.of(context).primaryColor.withOpacity(0.05),
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Row(
            children: [
              trailing,
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  titlel,
                  style: TextStyle(
                      color: context.read<ThemeCubit>().state
                          ? Colors.white
                          : Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 50.ms)
        .slideX(begin: 0.2, end: 0, duration: 50.ms);
  }
}
