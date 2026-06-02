class CategoryModel {
  final String category;
  final List<CategoryItem> items;

  CategoryModel({
    required this.category,
    required this.items,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      category: json['category'] ?? json['title'] ?? '',
      items: (json['items'] as List<dynamic>? ?? [])
          .map((item) => CategoryItem.fromJson(item))
          .toList(),
    );
  }
}

class CategoryItem {
  final String text;
  final String? title;
  final String? description;
  final String? source;
  final int count;

  CategoryItem({
    required this.text,
    this.title,
    this.description,
    this.source,
    this.count = 1,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    String text = '';
    if (json['text'] != null) {
      text = json['text'];
    } else if (json['content'] != null) {
      text = json['content'];
    }

    return CategoryItem(
      text: text,
      title: json['title'],
      description: json['description'] ?? json['subtitle'],
      source: json['source'],
      count: json['count'] ?? 1,
    );
  }
}
