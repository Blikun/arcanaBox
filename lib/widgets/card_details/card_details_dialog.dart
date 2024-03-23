import 'dart:developer';

import 'package:arcana_box/controllers/library_controller/library_controller.dart';
import 'package:arcana_box/models/card.dart';
import 'package:arcana_box/widgets/card_details/enchanted_button.dart';
import 'package:arcana_box/widgets/card_details/enchanted_display_card.dart';
import 'package:arcana_box/widgets/card_details/price_info.dart';
import 'package:arcana_box/widgets/card_details/rotate_card_button.dart';
import 'package:arcana_box/widgets/card_details/standard_display_card.dart';
import 'package:arcana_box/widgets/translation_frame.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/translation_controller/translation_controller.dart';
import 'dart:math' as math;

class CardDetailsDialog extends StatelessWidget {
  final int index;
  final TranslationController? translationService;

  CardDetailsDialog({super.key, this.translationService, required this.index});

  final LibraryController libraryController = Get.find<LibraryController>();
  final RxBool _showAlternateArt = false.obs;
  final RxBool _rotated = false.obs;
  final RxInt _indexDisplacement = 0.obs;
  static const _sensibilityThreshold = 25;

  @override
  Widget build(BuildContext context) {
    Offset? initialDragPosition;

    return GestureDetector(
      onTap: () => Get.back(),
      onHorizontalDragStart: (details) {
        initialDragPosition = details.globalPosition;
      },
      onHorizontalDragUpdate: (details) {
        if (initialDragPosition != null) {
          final delta = details.globalPosition.dx - initialDragPosition!.dx;
          if (delta.abs() > _sensibilityThreshold) {
            if (delta < 0 &&
                _indexDisplacement.value <
                    libraryController.state.library.length) {
              _indexDisplacement.value++;
              log('Dragged left $_indexDisplacement');
            } else if (delta > 0 && _indexDisplacement.value+index > 0) {
              _indexDisplacement.value--;
              log('Dragged right $_indexDisplacement');
            }
            initialDragPosition = null;
            _showAlternateArt.value = false;
          }
        }
      },
      child: Material(
        color: Colors.black54,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(() {
            int newIndex = index + _indexDisplacement.value;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (newIndex == libraryController.state.library.length - 4 ||
                  newIndex == libraryController.state.library.length - 1) {
                libraryController.paginateLibrary();
              }
            });
            final cardValue = libraryController.state.library[newIndex];
            return Column(
              children: [
                cardDisplay(cardValue),
                const SizedBox(height: 5),
                if (translationService != null)
                  TranslationFrame(
                      translationService: translationService!, card: cardValue),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget cardDisplay(CardModel cardValue) {
    return AnimatedScale(
      scale: _rotated.isTrue ? 0.72 : 1,
      curve: Curves.fastEaseInToSlowEaseOut,
      duration: const Duration(milliseconds: 500),
      child: Transform.rotate(
        angle: _rotated.isTrue ? -math.pi / -2 : 0,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Transform.translate(
                offset: Offset.fromDirection(1, -1),
                child: Obx(() => _showAlternateArt.isTrue
                    ? EnchantedDisplayCard(card: cardValue)
                    : StandardDisplayCard(card: cardValue)),
              ),
            ),
            PriceInfoDetails(card: cardValue),
            if (cardValue.enchantedImage?.isNotEmpty ?? false)
              EnchantedButton(
                  onToggle: () => _showAlternateArt.toggle(),
                  showAlternateArt: _showAlternateArt),
            if (cardValue.type == 'Location')
              RotateCardButton(
                  onRotate: () => _rotated.value = !_rotated.value,
                  rotated: _rotated),
          ],
        ),
      ),
    );
  }
}
