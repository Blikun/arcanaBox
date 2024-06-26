import 'package:arcana_box/models/filters.dart';

import '../../models/card.dart';
import 'api_lorcana.dart';

class CardsApiClient extends LorcanaApi {

  Future<List<CardModel>> searchPaginated(
      FiltersModel filters,
      int page,
  ) {
    return super.queryFilterCard(
   filters, page);
  }
}
