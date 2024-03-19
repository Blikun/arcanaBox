import '../../models/price_details.dart';

abstract class PricesAPI {
  Future<Map<int, PriceDetails>> queryStoreIds({required int expansionId});

  Future<PriceDetails?> queryPrice(
      {required int blueprintId, required bool isFoil});
}
