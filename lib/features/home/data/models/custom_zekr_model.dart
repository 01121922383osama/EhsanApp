import 'package:hive/hive.dart';

part 'custom_zekr_model.g.dart';

@HiveType(typeId: 100)
class CustomZekrModel extends HiveObject {
  @HiveField(0)
  String text;

  CustomZekrModel({required this.text});
}
