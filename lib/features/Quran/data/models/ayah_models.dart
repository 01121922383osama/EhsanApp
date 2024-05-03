import '../../domain/entities/ayahs_entity.dart';

class AyahModels extends AyahEntity {
  const AyahModels({
    required super.number,
    required super.audio,
    required super.audioSecondary,
    required super.numberInSurah,
  });
  factory AyahModels.fromJson(Map<String, dynamic> json) => AyahModels(
        number: json['number'],
        audio: json['audio'],
        audioSecondary: json['audioSecondary'] is String
            ? [json['audioSecondary']]
            : List<String>.from(json['audioSecondary']),
        numberInSurah: json['numberInSurah'],
      );
  Map<String, dynamic> toJson() => {
        'number': number,
        'audio': audio,
        'audioSecondary': audioSecondary,
        'numberInSurah': numberInSurah,
      };
}
