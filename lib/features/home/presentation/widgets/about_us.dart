import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/extension/extension.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/build_leading_widget.dart';
import '../../../Setting/presentation/cubit/Theme/theme_cubit.dart';

class AboutUsWidget extends StatelessWidget {
  final String name;
  final String jobTitle;
  final String description;
  const AboutUsWidget({
    super.key,
    required this.name,
    required this.jobTitle,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.read<ThemeCubit>().state
            ? AppColors.white.withOpacity(0.4)
            : AppColors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: AppColors.grey.withOpacity(0.2),
            offset: const Offset(0, 5),
          ),
          BoxShadow(
            blurRadius: 5,
            color: AppColors.grey.withOpacity(0.2),
            offset: const Offset(5, 0),
          ),
          BoxShadow(
            blurRadius: 5,
            color: AppColors.grey.withOpacity(0.2),
            offset: const Offset(-5, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 0.5,
            color: AppColors.white.withOpacity(0.8),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                ).animate().shimmer(),
                Text(
                  name,
                  style: AppTextStyles.textStyleFont20.copyWith(
                    color: AppColors.black,
                  ),
                ).animate().rotate(),
                const SizedBox(height: 5),
                Text(
                  jobTitle,
                  style: AppTextStyles.textStyleFont15.copyWith(
                    color: AppColors.black,
                  ),
                ).animate().scale(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              description,
              style: AppTextStyles.textStyleFont15.copyWith(
                color: AppColors.black,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.chat_bubble_fill,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fade();
  }
}

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const BuildIconBackWidget(),
          title: Text(AppLocalizations.of(context)!.about),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              AboutUsWidget(
                name: AppLocalizations.of(context)!.nameOsama,
                jobTitle: AppLocalizations.of(context)!.jobTitleOsama,
                description: AppLocalizations.of(context)!.descriptionOsama,
              ),
              AboutUsWidget(
                name: AppLocalizations.of(context)!.nameBilal,
                jobTitle: AppLocalizations.of(context)!.jobTitleBilal,
                description: AppLocalizations.of(context)!.descriptionBilal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
