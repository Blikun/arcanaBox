import 'package:arcana_box/models/filters.dart';

import '../../models/card.dart';
import 'api_lorcana.dart';

class ApiClient extends LorcanaApi {

  Future<List<CardModel>> searchPaginated(
      FiltersModel filters,
      int page,
  ) {
    return super.searchFilterCard(
   filters, page);
  }
}
