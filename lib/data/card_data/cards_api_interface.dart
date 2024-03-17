
import 'package:arcana_box/models/filters.dart';

import '../../models/card.dart';

abstract class CardsAPI {

  Future<List<CardModel>> searchFilterCard(
     FiltersModel filters,
      int page,);
}
