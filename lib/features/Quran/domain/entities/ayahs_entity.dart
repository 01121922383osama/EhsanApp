import 'package:equatable/equatable.dart';

class AyahEntity extends Equatable {
  final int number;
  final String audio;
  final List<String> audioSecondary;
  final int numberInSurah;

  const AyahEntity({
    required this.number,
    required this.audio,
    required this.audioSecondary,
    required this.numberInSurah,
  });

  @override
  List<Object?> get props => [
        number,
        audio,
        audioSecondary,
        numberInSurah,
      ];
}
