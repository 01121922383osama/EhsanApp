part of 'change_language_cubit.dart';

sealed class ChangeLanguageState extends Equatable {
  final String lang;
  const ChangeLanguageState({required this.lang});

  @override
  List<Object> get props => [lang];
}

final class ChangeLanguageInitial extends ChangeLanguageState {
  const ChangeLanguageInitial({required super.lang});
}
