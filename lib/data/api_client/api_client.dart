
import '../models/card.dart';

abstract class ApiClient {
  Future<List<LCard>> all();

  Future<List<LCard>> fetch(int page);

  Future<List<LCard>> searchFilterCard(
      String? type,
      String? name,
      String? rarity,
      String? inkable,
      List<int>? cost,
      String? color,
      int? cardNum,
      int? setNum,
      String? abilities,
      String? setName,
      String? bodyText,
      int? willpower,
      int? strength,
      int? lore,
      int page,);
}
