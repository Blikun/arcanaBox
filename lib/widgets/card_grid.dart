import 'package:arcana_box/controllers/price_controller/price_controller.dart';
import 'package:arcana_box/models/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../controllers/library_controller/library_controller.dart';
import 'card_details_dialog.dart';
import 'card_preview.dart';

class CardGrid extends StatelessWidget {
  CardGrid({
    super.key,
  });

  final libraryController = Get.find<LibraryController>();
  final priceController = Get.find<PriceController>();

  @override
  Widget build(BuildContext context) {
    return GetX<LibraryController>(
      builder: (controller) {
        return Column(
          children: [
            Expanded(
              // Ensure the GridView takes up all available space, minus the loading indicator
              child: GridView.builder(
                controller: libraryController.scrollController,
                padding: const EdgeInsets.all(5),
                itemCount: libraryController.state.library.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: Constants.cardAspectRatio,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  return Animate(
                    effects: const [FadeEffect()],
                    child: CardPreview(
                      image: libraryController.state.library[index].image!,
                      enchantedMark:
                          (libraryController.state.library[index].enchantedImage !=
                                  "" &&
                              libraryController.state.library[index].enchantedImage !=
                                  null),
                      onTap: () {
                        CardModel card = libraryController.state.library[index];
                        priceController.getPrice(card.setNum!, card.cardNum!);
                        Get.dialog(CardDetailsDialog(
                          card: card,
                          translationService:
                              libraryController.translationController,
                        ));
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
