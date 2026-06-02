import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../home/presentation/widgets/home_prayer_ui.dart';

/// YouTube thumbnail using the official i.ytimg.com CDN (more reliable than img.youtube.com).
class YoutubeVideoThumbnail extends StatelessWidget {
  const YoutubeVideoThumbnail({
    super.key,
    required this.videoId,
    this.width,
    this.height,
    this.borderRadius = 8,
    this.showPlayIcon = true,
  });

  final String videoId;
  final double? width;
  final double? height;
  final double borderRadius;
  final bool showPlayIcon;

  static String thumbnailUrl(
    String videoId, {
    ThumbnailQuality quality = ThumbnailQuality.medium,
    ThumbnailFormat format = ThumbnailFormat.jpeg,
  }) {
    return YoutubePlayerController.getThumbnail(
      videoId: videoId,
      quality: quality,
      format: format,
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final url = thumbnailUrl(videoId);

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(
            url,
            width: width,
            height: height,
            fit: BoxFit.cover,
            gaplessPlayback: true,
            errorBuilder: (_, __, ___) => _Placeholder(
              width: width,
              height: height,
              scheme: scheme,
            ),
            loadingBuilder: (_, child, progress) {
              if (progress == null) return child;
              return _Placeholder(
                width: width,
                height: height,
                scheme: scheme,
                loading: true,
              );
            },
          ),
          if (showPlayIcon)
            Icon(
              Icons.play_circle_fill_rounded,
              color: Colors.white.withOpacity(0.92),
              size: (height ?? 64) * 0.45,
            ),
        ],
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({
    required this.scheme,
    this.width,
    this.height,
    this.loading = false,
  });

  final ColorScheme scheme;
  final double? width;
  final double? height;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: scheme.surfaceContainerHighest,
      alignment: Alignment.center,
      child: loading
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Icon(
              Icons.video_library_rounded,
              color: scheme.outline,
              size: HomePrayerUi.radius * 2,
            ),
    );
  }
}
