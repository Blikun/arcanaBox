import 'dart:developer';

import 'package:dio/dio.dart';
import '../../models/price_details.dart';
import '../../secret.dart';
import '../../utils.dart';
import 'prices_api_interface.dart';

class CardTraderApi implements PricesAPI {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.cardtrader.com/api/v2',
      headers: {'Authorization': cardTraderToken}));

  String blueprintsEp = '/blueprints/export';
  String productsEp = '/marketplace/products';

  final Map<int, int> expansionIdMatches = {
    1 : 3469,
    2 : 3505,
    3 : 3469,
  };

  Future<Map<int, PriceDetails>> getStoreIds(int expansionId) async {

    Map<int, PriceDetails> detailsMap = {};

    int expansionBlueprintId = expansionIdMatches.entries.firstWhere((entry) => entry.key == expansionId).value;

    try {
      final response = await dio.get('$blueprintsEp?expansion_id=$expansionBlueprintId');

      for (var element in response.data) {
        if (element['fixed_properties'].isNotEmpty &&
            element['fixed_properties']['collector_number'] != '') {
          detailsMap.addAll({
            Utils().cardNumberFix(element['fixed_properties']['collector_number']):
                PriceDetails(blueprintId: element['id'])
          });
        }
      }
      return detailsMap;
    } catch (e) {
      throw Exception('Failed to get store ids - $e');
    }
  }



  Future<PriceDetails?> getPrice(int blueprintId) async {
    PriceDetails? details;
    try {
      final response = await dio.get('$productsEp?blueprint_id=$blueprintId&quantity=1');
      double averagePrice = Utils().calculateAveragePrice(entries: response.data.entries.first.value, max: 10, currency: 'EUR');
      details = PriceDetails(blueprintId: blueprintId, currency: '€', priceCents: averagePrice);
      log("Got price -> ${details.priceCents}${details.currency}");
      return details;
    } catch (e) {
      throw Exception('Failed to get store price - $e');
    }
  }
}
