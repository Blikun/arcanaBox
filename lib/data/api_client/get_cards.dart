import 'package:arcana_box/data/api_client/lorcana_api.dart';
import 'package:flutter/material.dart';

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
    List<int>? lore,
    int page,
  ) async {
    List<String> searchParams = [];

    if (type != null) searchParams.add("Type=$type");
    if (name != null) searchParams.add("Name=$name");
    if (rarity != null) searchParams.add("Rarity=$rarity");
    if (inkable != null) searchParams.add("Inkable=$inkable");
    if (cost != null) {
      searchParams.add("Cost>${cost[0]-1}");
      searchParams.add("Cost<${cost[1]+1}");
    }
    if (color != null) searchParams.add("Color=$color");
    if (cardNum != null) searchParams.add("CardNum=$cardNum");
    if (setNum != null) searchParams.add("SetNum=$setNum");
    if (abilities != null) searchParams.add("Abilities=$abilities");
    if (setName != null) searchParams.add("SetName=$setName");
    if (bodyText != null) searchParams.add("BodyText=$bodyText");
    if (willpower != null) searchParams.add("Willpower=$willpower");
    if (strength != null) searchParams.add("Strength=$strength");
    if (lore != null)  {
      searchParams.add("Lore>${lore[0]-1}");
      searchParams.add("Lore<${lore[1]+1}");
    }

    String searchQuery = searchParams.join(';');
    final response = await dio.get(
        '${super.cardsFetch}?page=$page&pagesize=${super.pageSize}&search=$searchQuery');

    List<LCard> cards =
        List<LCard>.from(response.data.map((x) => LCard.fromJson(x)));
    return cards;
  }
}
