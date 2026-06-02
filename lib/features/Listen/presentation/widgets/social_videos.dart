import 'package:flutter/material.dart';

import '../../../../core/extension/extension.dart';
import 'listen_ui.dart';
import '../pages/youtube_page.dart';

class SocialVideos extends StatelessWidget {
  const SocialVideos({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(
            child: ListenUi.quickActionButton(
              context: context,
              icon: Icons.play_circle_outline_rounded,
              iconColor: Colors.red.shade600,
              onPressed: () => context.push(widget: const YoutubePage()),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: ListenUi.quickActionButton(
              context: context,
              icon: Icons.share_rounded,
              iconColor: Theme.of(context).colorScheme.primary,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
