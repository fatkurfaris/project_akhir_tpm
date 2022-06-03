import 'package:hive/hive.dart';
import 'package:project_resep/models/fav.dart';

class Boxes {
  static Box<Fav> getTransactions() => Hive.box<Fav>('fav');
}
