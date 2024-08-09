import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/extension/extension.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/build_leading_widget.dart';

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
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 0.5,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                  ).animate().shimmer(),
                  Text(
                    name,
                    style: AppTextStyles.textStyleFont20,
                  ).animate().rotate(),
                  const SizedBox(height: 5),
                  Text(
                    jobTitle,
                    style: AppTextStyles.textStyleFont15,
                  ).animate().scale(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              description,
              style: AppTextStyles.textStyleFont15,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton.outlined(
                onPressed: () {},
                icon: const Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              ),
              IconButton.outlined(
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
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Row(
              children: [
                const BuildIconBackWidget(),
                Text(
                  AppLocalizations.of(context)!.about,
                  style: AppTextStyles.textStyleFont20,
                ),
              ],
            ),
          ),
        ),
        body: ListView(
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
    );
  }
}
