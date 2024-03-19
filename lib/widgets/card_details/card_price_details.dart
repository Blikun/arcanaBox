import 'package:arcana_box/controllers/price_controller/price_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../models/card.dart';
import '../../models/price_details.dart';

class CardPriceDetails extends StatelessWidget {
  final CardModel card;
  const CardPriceDetails({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PriceController>(builder: (priceController) {
      PriceDetails priceDetails = priceController
          .state.priceDetails.value.entries
          .firstWhere((generationEntry) => generationEntry.key == card.setNum)
          .value
          .entries
          .firstWhere((cardEntry) => cardEntry.key == card.cardNum)
          .value;
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          color: Colors.black,
        ),
        child: Padding(
            padding:
                const EdgeInsets.only(bottom: 8, left: 8, top: 10, right: 10),
            child: Row(
              children: [
                SizedBox(height: 18, child: Image.asset(Constants.cardTrader)),
                const SizedBox(
                  width: 5,
                ),
                priceDetails.priceCents != null
                    ? Row(
                        children: [
                          Text(
                            priceDetails.priceCents!
                                .toStringAsFixed(2)
                                .replaceAll(".", ","),
                            style: (Constants.cabinStyle.copyWith(
                                color: Colors.white60,
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.7)),
                          ),
                          Text(
                            " ${priceDetails.currency} ",
                            style: (Constants.cabinStyle
                                .copyWith(color: Colors.white60, fontSize: 13)),
                          )
                        ],
                      )
                    : const SizedBox(
                        width: 43,
                        child: LinearProgressIndicator(
                          color: Colors.white10,
                        ),
                      ),
              ],
            )),
      );
    });
  }
}
