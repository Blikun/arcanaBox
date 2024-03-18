import 'package:dio/dio.dart';
import '../../models/price_details.dart';
import '../../secret.dart';
import 'prices_api_interface.dart';

class CardTraderApi implements PricesAPI {
  final dio = Dio(BaseOptions(
      baseUrl: "https://api.cardtrader.com/api/v2",
      headers: {"Authorization": cardTraderToken}));

  String blueprintsEp = "/blueprints/export";
  String productsEp = "marketplace/products";

  final Map<int, int> expansionIdMatches = {
    1 : 3469,
    2 : 3505,
    3 : 3469,
  };

  Future<Map<int, PriceDetails>> getStoreIds(int expansionId) async {

    Map<int, PriceDetails> detailsMap = {};

    int getNumber(String number) {
      if (number.contains("/")) {
        List<String> split = number.split("/");
        return int.parse(split.first);
      }
      return int.parse(number);
    }

    int id = expansionIdMatches.entries.firstWhere((entry) => entry.key == expansionId).value;

    try {
      final response = await dio.get("$blueprintsEp?expansion_id=$id");

      for (var element in response.data) {
        if (element["fixed_properties"].isNotEmpty &&
            element["fixed_properties"]["collector_number"] != "") {
          detailsMap.addAll({
            getNumber(element["fixed_properties"]["collector_number"]):
                PriceDetails(detailsId: element["id"])
          });
        }
      }
      return detailsMap;
    } catch (e) {
      throw Exception('Failed to get store ids - $e');
    }
  }



}
