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
  void onInit() {
    getBlueprintIds(1);
    super.onInit();
  }

  Future<void> getBlueprintIds(int expansionId) async {
    Map<int, PriceDetails> priceDetails =
        await pricesApiClient.getBlueprintIds(expansionId: expansionId);
    state.priceDetails.value[expansionId] = priceDetails;
    log("Got expansion $expansionId blueprints for total ${priceDetails.length}");
  }

  Future<void> updatePrice(int expansionId, int cardId) async {
    int blueprintId = state.priceDetails.value[expansionId]!.entries
        .firstWhere((entry) => entry.key == cardId)
        .value
        .blueprintId;

    PriceDetails? newPriceDetails = await pricesApiClient.getPrice(blueprintId);

    if (newPriceDetails != null) {
      final newPriceDetailsState =
          Map<int, Map<int, PriceDetails>>.from(state.priceDetails.value);

      newPriceDetailsState[expansionId]![cardId] =
          newPriceDetailsState[expansionId]![cardId]!.copyWith(
        detailsID: newPriceDetails.blueprintId,
        currency: newPriceDetails.currency,
        priceCents: newPriceDetails.priceCents,
      );
      state.priceDetails.value = newPriceDetailsState;
      log("Card $cardId - $expansionId price updated");
    }
  }

  Future<void> getPrice(int expansionId, int cardId) async {
    bool exists = state.priceDetails.value.containsKey(expansionId) &&
        state.priceDetails.value[expansionId]!.containsKey(cardId) &&
        state.priceDetails.value[expansionId]![cardId]!.priceCents != null;
    if (!exists) updatePrice(expansionId, cardId);
  }
}
