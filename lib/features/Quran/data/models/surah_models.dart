import '../../domain/entities/surah_entity.dart';
import 'ayah_models.dart';

class SurahModels extends SurahEntity {
  const SurahModels({
    required super.number,
    required super.name,
    required super.englishName,
    required super.englishNameTranslation,
    required super.revelationType,
    required List<AyahModels> ayahs,
  }) : super(ayahs: ayahs);
  factory SurahModels.fromJson(Map<String, dynamic> json) => SurahModels(
        number: json['number'],
        name: json['name'],
        englishName: json['englishName'],
        englishNameTranslation: json['englishNameTranslation'],
        revelationType: json['revelationType'],
        ayahs: List<AyahModels>.from(
            json['ayahs'].map((x) => AyahModels.fromJson(x))),
      );
  Map<String, dynamic> toJson() => {
        'number': number,
        'name': name,
        'englishName': englishName,
        'englishNameTranslation': englishNameTranslation,
        'revelationType': revelationType,
        'ayahs': List<AyahModels>.from(ayahs.map((x) => x)),
      };
}
