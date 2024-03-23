
import 'package:arcana_box/models/filters.dart';

import '../../models/card.dart';

abstract class CardsAPI {

  Future<List<CardModel>> queryFilterCard(
     FiltersModel filters,
      int page,);
}
