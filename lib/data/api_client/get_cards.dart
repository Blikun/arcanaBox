import 'package:arcana_box/data/api_client/lorcana_api.dart';

import '../models/card.dart';

class GetCards extends LorcanaApi {
  @override
  Future<List<LCard>> all() async {
    List<LCard> cards = [];
    final response = await dio.get(super.cardsAll);

    cards = List<LCard>.from(response.data.map((x) => LCard.fromJson(x)));
    return cards;
  }

  @override
  Future<List<LCard>> fetch(int page) async {
    List<LCard> cards = [];
    final response = await dio
        .get("${super.cardsFetch}?page=$page&pagesize=${super.pageSize}");

    cards = List<LCard>.from(response.data.map((x) => LCard.fromJson(x)));
    return cards;
  }

  @override
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
    int page,
  ) async {
    List<String> searchParams = [];

    if (type != null && type != "Any") searchParams.add("Type=$type");
    if (name != null) searchParams.add("Name=$name");
    if (rarity != null) searchParams.add("Rarity=$rarity");
    if (inkable != null) searchParams.add("Inkable=$inkable");
    if (cost != null) {
      searchParams.add("Cost>${cost[0] - 1}");
      searchParams.add("Cost<${cost[1] + 1}");
    }
    if (color != null) searchParams.add("Color=$color");
    if (cardNum != null) searchParams.add("CardNum=$cardNum");
    if (setNum != null && setNum != 0) searchParams.add("Set_Num=$setNum");
    if (abilities != null) searchParams.add("Abilities=$abilities");
    if (setName != null) searchParams.add("SetName=$setName");
    if (bodyText != null) searchParams.add("BodyText=$bodyText");
    if (willpower != null && willpower != -1) searchParams.add("Willpower=$willpower");
    if (strength != null && strength != -1) searchParams.add("Strength=$strength");
    if (lore != null && lore != -1) {
      searchParams.add("Lore=$lore");
    }

    String searchQuery = searchParams.join(';');
    print("'${super.cardsFetch}?page=$page&pagesize=${super.pageSize}&search=$searchQuery'");
    final response = await dio.get(
        '${super.cardsFetch}?page=$page&pagesize=${super.pageSize}&search=$searchQuery');

    List<LCard> cards =
        List<LCard>.from(response.data.map((x) => LCard.fromJson(x)));
    return cards;
  }
}
