import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/services.dart';

import '../models/category_model.dart';
import '../models/hadith_model.dart';

class LibraryService {
  static const String _ahadithPrefix = 'assets/jsons/ahadith/';
  static const String _azkarPrefix = 'assets/jsons/azkaJson/';
  static const String _ad3yaPrefix = 'assets/jsons/ad3ya/';
  static const String _hajjPrefix = 'assets/jsons/hajw3omra/';
  static const String _ramadanPrefix = 'assets/jsons/rmdan/';
  static const String _seerahPrefix = 'assets/jsons/seranbwya/';

  Future<List<CategoryModel>> getAdiya() =>
      _loadCategoriesFromAssetPrefix(_ad3yaPrefix);

  Future<List<CategoryModel>> getAhadethCategories() =>
      _loadCategoriesFromAssetPrefix(_ahadithPrefix);

  Future<List<CategoryModel>> getAzkar() =>
      _loadCategoriesFromAssetPrefix(_azkarPrefix);

  Future<List<CategoryModel>> getHajj() =>
      _loadCategoriesFromAssetPrefix(_hajjPrefix);

  Future<List<CategoryModel>> getRamadan() =>
      _loadCategoriesFromAssetPrefix(_ramadanPrefix);

  Future<List<CategoryModel>> getSeerah() =>
      _loadCategoriesFromAssetPrefix(_seerahPrefix);

  Future<List<HadithModel>> getAhadith() async {
    try {
      final categories = await getAhadethCategories();
      final ahadith = <HadithModel>[];

      for (final category in categories) {
        for (final item in category.items) {
          ahadith.add(
            HadithModel(
              number: item.title ?? category.category,
              text: item.text,
              label: item.source ?? '',
            ),
          );
        }
      }

      return ahadith;
    } catch (e) {
      developer.log('Error in getAhadith: $e');
      return [];
    }
  }

  Future<List<CategoryModel>> _loadCategoriesFromAssetPrefix(
    String prefix,
  ) async {
    try {
      final paths = await _listJsonAssetPaths(prefix);
      if (paths.isEmpty) {
        developer.log('No JSON assets found for prefix: $prefix');
        return [];
      }

      final categories = <CategoryModel>[];
      for (final path in paths) {
        final items = await _loadJsonData(path);
        if (items.isEmpty) continue;

        categories.add(
          CategoryModel(
            category: _categoryNameFromPath(path),
            items: items.map(_mapToCategoryItem).toList(),
          ),
        );
      }

      return categories;
    } catch (e) {
      developer.log('Error loading categories from $prefix: $e');
      return [];
    }
  }

  Future<List<String>> _listJsonAssetPaths(String prefix) async {
    final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    return manifest
        .listAssets()
        .where((path) => path.startsWith(prefix) && path.endsWith('.json'))
        .toList()
      ..sort();
  }

  String _categoryNameFromPath(String path) {
    final relative = path.replaceFirst('assets/jsons/', '');
    final segments = relative.split('/');
    final fileName = segments.last.replaceAll('.json', '').trim();
    final displayName = _displayNameForFile(fileName);

    if (segments.length > 2) {
      final folderName = segments[segments.length - 2].trim();
      return '$folderName - $displayName';
    }

    return displayName;
  }

  String _displayNameForFile(String fileName) {
    const overrides = <String, String>{
      'ahadith': 'أحاديث',
    };
    return overrides[fileName.toLowerCase()] ?? fileName;
  }

  CategoryItem _mapToCategoryItem(dynamic raw) {
    if (raw is! Map) {
      return CategoryItem(text: raw.toString());
    }

    final item = Map<String, dynamic>.from(raw);

    final textValue = item['text']?.toString().trim() ?? '';
    final labelValue = item['label']?.toString().trim() ?? '';
    final contentValue = item['content']?.toString().trim() ?? '';

    final text = textValue.isNotEmpty
        ? textValue
        : labelValue.isNotEmpty
            ? labelValue
            : contentValue;

    final titleCandidate = item['title']?.toString().trim() ?? '';
    final numberCandidate = item['number']?.toString().trim() ?? '';
    final title = titleCandidate.isNotEmpty
        ? titleCandidate
        : numberCandidate.isNotEmpty && text != numberCandidate
            ? numberCandidate
            : null;

    final description = item['description']?.toString().trim();
    final sourceRaw = item['source']?.toString().trim() ?? '';
    final source = sourceRaw.isNotEmpty
        ? sourceRaw
        : labelValue.isNotEmpty && textValue.isNotEmpty
            ? labelValue
            : null;

    final count = item['count'] is int
        ? item['count'] as int
        : int.tryParse('${item['count']}') ?? 1;

    return CategoryItem(
      text: text,
      title: title?.isEmpty ?? true ? null : title,
      description: description?.isEmpty ?? true ? null : description,
      source: source?.isEmpty ?? true ? null : source,
      count: count,
    );
  }

  Future<List<dynamic>> _loadJsonData(String path) async {
    try {
      final jsonString = await rootBundle.loadString(path);
      final decoded = json.decode(jsonString);

      if (decoded is List) return decoded;
      if (decoded is Map && decoded['items'] is List) {
        return decoded['items'] as List;
      }

      developer.log('Unexpected JSON root type at $path');
      return [];
    } catch (e) {
      developer.log('Error loading JSON data from $path: $e');
      return [];
    }
  }
}
