
import '../../models/price_details.dart';
import 'api_cardtrader.dart';

class PricesApiClient extends CardTraderApi {

  Future<Map<int, PriceDetails>> getBlueprintIds({required int expansionId}){
    return super.getStoreIds(expansionId);
  }

}
