
import '../../models/price_details.dart';
import 'api_cardtrader.dart';

class PricesApiClient extends CardTraderApi {

  Future<Map<int, PriceDetails>> getBlueprintIds({required int expansionId}){
    return super.queryStoreIds(expansionId: expansionId);
  }

  Future<PriceDetails?> getPrice(
      {required int blueprintId, required bool isFoil}){
    return super.queryPrice(blueprintId: blueprintId, isFoil: isFoil);
  }

}
