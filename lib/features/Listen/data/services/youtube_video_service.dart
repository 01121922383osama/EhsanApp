import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/constants/api_keys.dart';
import '../models/youtube_models.dart';

const _cacheBoxName = 'youtube_video_cache';
const _cacheDuration = Duration(hours: 24);
const _sectionsAsset = 'assets/jsons/youtube/sections.json';

class YoutubeVideoService {
  final Dio _dio;

  List<YoutubeSection>? _sections;
  YoutubeVideoService({Dio? dio}) : _dio = dio ?? Dio();

  bool get hasApiKey =>
      ApiKeys.youtubeApiKey.isNotEmpty &&
      ApiKeys.youtubeApiKey != 'YOUR_YOUTUBE_API_KEY_HERE';

  Future<List<YoutubeVideo>> getVideosForSection(
    YoutubeSection section, {
    required String locale,
  }) async {
    final fallbacks = section.fallbackForLocale(locale);
    if (section.playlistId.isEmpty || !hasApiKey) {
      return fallbacks;
    }

    final cacheKey = 'playlist_${section.id}';
    final cached = await _readCache(cacheKey);
    if (cached != null) return cached;

    try {
      final response = await _dio.get<Map<String, dynamic>>(
        'https://www.googleapis.com/youtube/v3/playlistItems',
        queryParameters: {
          'part': 'snippet',
          'playlistId': section.playlistId,
          'maxResults': 25,
          'key': ApiKeys.youtubeApiKey,
        },
      );

      final items = response.data?['items'] as List<dynamic>? ?? [];
      final videos = items
          .map((item) {
            final snippet = (item as Map<String, dynamic>)['snippet']
                as Map<String, dynamic>?;
            if (snippet == null) return null;
            return YoutubeVideo.fromApiItem(snippet);
          })
          .whereType<YoutubeVideo>()
          .where((video) => video.id.isNotEmpty && video.title.isNotEmpty)
          .toList();

      if (videos.isEmpty) return fallbacks;

      await _writeCache(cacheKey, videos);
      return videos;
    } catch (_) {
      return fallbacks;
    }
  }

  Future<List<YoutubeSection>> loadSections() async {
    if (_sections != null) return _sections!;
    final raw = await rootBundle.loadString(_sectionsAsset);
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    _sections = (decoded['sections'] as List<dynamic>)
        .map((item) => YoutubeSection.fromJson(item as Map<String, dynamic>))
        .toList();
    return _sections!;
  }

  Future<List<YoutubeVideo>?> _readCache(String key) async {
    final box = await Hive.openBox<String>(_cacheBoxName);
    final raw = box.get(key);
    if (raw == null) return null;

    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    final cachedAt = DateTime.tryParse(decoded['cachedAt'] as String? ?? '');
    if (cachedAt == null ||
        DateTime.now().difference(cachedAt) > _cacheDuration) {
      await box.delete(key);
      return null;
    }

    final videos = (decoded['videos'] as List<dynamic>)
        .map((item) => YoutubeVideo.fromJson(item as Map<String, dynamic>))
        .toList();
    return videos;
  }

  Future<void> _writeCache(String key, List<YoutubeVideo> videos) async {
    final box = await Hive.openBox<String>(_cacheBoxName);
    await box.put(
      key,
      jsonEncode({
        'cachedAt': DateTime.now().toIso8601String(),
        'videos': videos.map((video) => video.toJson()).toList(),
      }),
    );
  }
}
