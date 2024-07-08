import 'array.dart';

class ZekrModel {
  final num id;
  final String category;
  final List<ArrayModel> array;

  ZekrModel({
    required this.id,
    required this.category,
    required this.array,
  });
  factory ZekrModel.fromJson(Map<String, dynamic> json) {
    var arrayList = json['array'] as List;
    var arrayItem = arrayList.map((item) => ArrayModel.fromJson(item)).toList();
    return ZekrModel(
      id: json['id'],
      category: json['category'],
      array: arrayItem,
    );
  }
}
