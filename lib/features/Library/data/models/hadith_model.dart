class HadithModel {
  final String number;
  final String text;
  final String label;

  HadithModel({
    required this.number,
    required this.text,
    required this.label,
  });

  factory HadithModel.fromJson(Map<String, dynamic> json) {
    return HadithModel(
      number: json['number']?.toString() ?? '',
      text: json['text']?.toString() ?? '',
      label: json['label']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'text': text,
      'label': label,
    };
  }
}
