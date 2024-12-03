import 'package:flutter/material.dart';
import '../../../../core/extension/extension.dart';
import 'youtube_page.dart';

class SocialVideos extends StatelessWidget {
  const SocialVideos({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton.filledTonal(
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                onPressed: () {
                  context.push(widget: const YoutubePage());
                },
                icon: const Icon(
                  Icons.video_collection_sharp,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton.filledTonal(
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                onPressed: () {},
                icon: const Icon(
                  Icons.social_distance,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
