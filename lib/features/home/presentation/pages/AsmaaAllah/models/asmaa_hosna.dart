class AsmaaHosnaModel {
  final int id;
  final String name;
  final String text;

  AsmaaHosnaModel({
    required this.id,
    required this.name,
    required this.text,
  });

  factory AsmaaHosnaModel.fromJson(Map<String, dynamic> json) {
    return AsmaaHosnaModel(
      id: json['id'],
      name: json['name'],
      text: json['text'],
    );
  }
}
