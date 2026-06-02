import 'package:flutter/material.dart';

class YoutubeVideo {
  const YoutubeVideo({
    required this.id,
    required this.title,
    this.channelTitle,
    this.thumbnailUrl,
  });

  final String id;
  final String title;
  final String? channelTitle;
  final String? thumbnailUrl;

  String get defaultThumbnailUrl =>
      thumbnailUrl ?? 'https://i3.ytimg.com/vi/$id/mqdefault.jpg';

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'channelTitle': channelTitle,
        'thumbnailUrl': thumbnailUrl,
      };

  factory YoutubeVideo.fromJson(Map<String, dynamic> json) {
    return YoutubeVideo(
      id: json['id'] as String,
      title: json['title'] as String,
      channelTitle: json['channelTitle'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
    );
  }

  factory YoutubeVideo.fromApiItem(Map<String, dynamic> snippet) {
    final resourceId = snippet['resourceId'] as Map<String, dynamic>?;
    final videoId = resourceId?['videoId'] as String? ??
        snippet['id'] as String? ??
        '';
    final thumbnails = snippet['thumbnails'] as Map<String, dynamic>?;
    final high = thumbnails?['high'] as Map<String, dynamic>?;
    final medium = thumbnails?['medium'] as Map<String, dynamic>?;
    final thumbUrl =
        high?['url'] as String? ?? medium?['url'] as String?;

    return YoutubeVideo(
      id: videoId,
      title: snippet['title'] as String? ?? '',
      channelTitle: snippet['videoOwnerChannelTitle'] as String? ??
          snippet['channelTitle'] as String?,
      thumbnailUrl: thumbUrl,
    );
  }

  factory YoutubeVideo.fromFallback(Map<String, dynamic> json, String locale) {
    final titleKey = _titleKeyForLocale(locale);
    return YoutubeVideo(
      id: json['id'] as String,
      title: json[titleKey] as String? ??
          json['titleAr'] as String? ??
          json['titleEn'] as String? ??
          '',
    );
  }
}

class YoutubeSection {
  const YoutubeSection({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.titleFr,
    required this.icon,
    required this.playlistId,
    required this.fallbackVideos,
  });

  final String id;
  final String titleAr;
  final String titleEn;
  final String titleFr;
  final String icon;
  final String playlistId;
  final List<Map<String, dynamic>> fallbackVideos;

  String titleForLocale(String locale) {
    if (locale.startsWith('ar')) return titleAr;
    if (locale.startsWith('fr')) return titleFr;
    return titleEn;
  }

  List<YoutubeVideo> fallbackForLocale(String locale) {
    return fallbackVideos
        .map((item) => YoutubeVideo.fromFallback(item, locale))
        .toList();
  }

  IconData get iconData {
    switch (icon) {
      case 'auto_stories_rounded':
        return Icons.auto_stories_rounded;
      case 'school_rounded':
        return Icons.school_rounded;
      case 'history_edu_rounded':
        return Icons.history_edu_rounded;
      case 'volunteer_activism_rounded':
        return Icons.volunteer_activism_rounded;
      case 'child_care_rounded':
        return Icons.child_care_rounded;
      default:
        return Icons.play_circle_outline_rounded;
    }
  }

  factory YoutubeSection.fromJson(Map<String, dynamic> json) {
    return YoutubeSection(
      id: json['id'] as String,
      titleAr: json['titleAr'] as String,
      titleEn: json['titleEn'] as String,
      titleFr: json['titleFr'] as String,
      icon: json['icon'] as String? ?? 'play_circle_outline_rounded',
      playlistId: json['playlistId'] as String? ?? '',
      fallbackVideos: (json['fallbackVideos'] as List<dynamic>? ?? [])
          .cast<Map<String, dynamic>>(),
    );
  }
}

String _titleKeyForLocale(String locale) {
  if (locale.startsWith('ar')) return 'titleAr';
  if (locale.startsWith('fr')) return 'titleFr';
  return 'titleEn';
}
