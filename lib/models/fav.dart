import 'package:hive/hive.dart';

part 'fav.g.dart';

@HiveType(typeId: 0)
class Fav extends HiveObject{
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String image;
}