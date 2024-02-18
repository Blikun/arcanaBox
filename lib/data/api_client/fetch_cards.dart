
import 'package:arcana_box/data/api_client/lorcana_api.dart';
import 'package:arcana_box/models/card.dart';

class FetchCards extends LorcanaApi {

  @override
  Future<List<LCard>> all() async {
    List<LCard> cards = [];
    print("fetching all");
    final response = await dio.get(super.cardsAll);
    cards = List<LCard>.from(response.data.map((x) => LCard.fromJson(x)));
    return cards;
  }
}