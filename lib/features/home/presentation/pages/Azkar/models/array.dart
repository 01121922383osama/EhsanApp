class ArrayModel {
  final num id;
  final String text;
  final int count;

  ArrayModel({
    required this.id,
    required this.text,
    required this.count,
  });
  factory ArrayModel.fromJson(Map<String, dynamic> json) {
    return ArrayModel(
      id: json['id'],
      text: json['text'],
      count: json['count'],
    );
  }
}
