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
    final response = await dio.get("${super.cardsFetch}?page=$page&pagesize=${super.pageSize}");
    cards = List<LCard>.from(response.data.map((x) => LCard.fromJson(x)));
    return cards;
  }
}
