import 'dart:developer';

import 'package:arcana_box/data/prices_data/prices_api_client.dart';
import 'package:get/get.dart';
import '../../models/price_details.dart';

part 'price_state.dart';

class PriceController extends GetxController {
  PriceState state;
  final PricesApiClient pricesApiClient;

  PriceController(this.state, this.pricesApiClient);

  @override
  void onInit(){
    getBlueprintIds(1);
    super.onInit();
  }

  Future<void> getBlueprintIds(int expansionId) async {
    Map<int, PriceDetails> priceDetails = await pricesApiClient.getBlueprintIds(expansionId: expansionId);
    state.priceDetails.value[expansionId] = priceDetails;
    log("Got expansion $expansionId blueprints for total ${priceDetails.length}");
  }


  Future<void> getPrice(int expansionId, int blueprintId) async {


  }

  Future<void> updatePrice(int expansionId, int blueprintId) async {


  }

}
