import 'dart:developer';

import 'package:dio/dio.dart';

import '../../models/card.dart';
import '../../models/filters.dart';
import 'api_interface.dart';

class LorcanaApi implements API {

  final dio = Dio(BaseOptions(baseUrl: "https://api.lorcana-api.com"));
  String cardsAll = "/cards/all";
  String cardsFetch = "/cards/fetch";
  int pageSize = 21;


  @override
  Future<List<CardModel>> searchFilterCard(FiltersModel filters, int page) async {
    List<String> searchParams = [];

    if (filters.type != null && filters.type != "Any") searchParams.add("Type=${filters.type}");
    if (filters.name != null) searchParams.add("Name=${filters.name}");
    if (filters.rarity != null) searchParams.add("Rarity=${filters.rarity}");
    if (filters.inkable != null) searchParams.add("Inkable=${filters.inkable}");
    if (filters.cost != null) {
      searchParams.add("Cost>${filters.cost![0] - 1}");
      searchParams.add("Cost<${filters.cost![1] + 1}");
    }
    if (filters.color != null) searchParams.add("Color=${filters.color}");
    if (filters.cardNum != null) searchParams.add("CardNum=${filters.cardNum}");
    if (filters.setNum != null && filters.setNum != 0) searchParams.add("Set_Num=${filters.setNum}");
    if (filters.abilities != null) searchParams.add("Abilities=${filters.abilities}");
    if (filters.setName != null) searchParams.add("SetName=${filters.setName}");
    if (filters.bodyText != null) searchParams.add("BodyText=${filters.bodyText}");
    if (filters.willpower != null && filters.willpower != -1) {
      searchParams.add("Willpower=${filters.willpower}");
    }
    if (filters.strength != null && filters.strength != -1) {
      searchParams.add("Strength=${filters.strength}");
    }
    if (filters.lore != null && filters.lore != -1) {
      searchParams.add("Lore=${filters.lore}");
    }

    String searchQuery = searchParams.join(';');
    log("'$cardsFetch?page=$page&pagesize=$pageSize&search=$searchQuery'");
    final response = await dio.get('$cardsFetch?page=$page&pagesize=$pageSize&search=$searchQuery');

    List<CardModel> cards = List<CardModel>.from(response.data.map((x) => CardModel.fromJson(x)));
    return cards;
  }
}
