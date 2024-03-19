import 'package:arcana_box/controllers/price_controller/price_controller.dart';
import 'package:arcana_box/widgets/card_details/card_rotate_button.dart';
import 'package:arcana_box/widgets/card_details/enchanted_button.dart';
import 'package:arcana_box/widgets/translation_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import '../../controllers/translation_controller/translation_controller.dart';
import '../../models/card.dart';
import 'dart:math' as math;

import 'card_price_details.dart';

class CardDetailsDialog extends StatelessWidget {
  final CardModel card;
  final TranslationController? translationService;

  CardDetailsDialog({super.key, required this.card, this.translationService});

  final PriceController priceController = Get.find<PriceController>();
  final RxBool _showAlternateArt = false.obs;
  final RxBool _rotated = false.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Material(
        color: Colors.black54,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Obx(() {
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
                                ? _enchantedDisplay()
                                : _standardDisplay()),
                          ),
                        ),
                        Positioned(
                            top: 0,
                            right: 0,
                            child: CardPriceDetails(
                              card: card,
                            )),
                        if (card.enchantedImage?.isNotEmpty ?? false)
                          EnchantedButton(
                              onTap: () {
                                _showAlternateArt.toggle();
                              },
                              isToggled: _showAlternateArt.value),
                        if (card.type == 'Location')
                          Positioned(
                              right: 0,
                              bottom: _rotated.isTrue ? null : 0,
                              child: CardRotateButton(
                                onTap: () => _rotated.toggle(),
                              )),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 5),
              if (translationService != null)
                TranslationFrame(
                    translationService: translationService!, card: card),
            ],
          ),
        ),
      ),
    );
  }

  Widget _standardDisplay() {
    return Image.network(
      card.image!,
      errorBuilder: (context, error, stackTrace) =>
          Image.asset(Constants.cardBack),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Opacity(
          opacity: 0.4,
          child: Image.asset(Constants.cardBack, color: Colors.black),
        ).animate(onPlay: (controller) => controller.repeat(), effects: [
          ShimmerEffect(
              duration: const Duration(seconds: 1),
              color: Colors.purple.withOpacity(0.25))
        ]);
      },
    );
  }

  Widget _enchantedDisplay() {
    return Animate(
      autoPlay: true,
      onPlay: (controller) => controller.repeat(),
      effects: [
        ShimmerEffect(
            duration: const Duration(seconds: 6),
            angle: 40,
            size: 4,
            colors: Constants.foilColors),
        ShimmerEffect(
            angle: 40,
            duration: const Duration(milliseconds: 2500),
            size: 0.5,
            color: Colors.white.withOpacity(0.07)),
      ],
      child: Image.asset(card.enchantedImage!),
    );
  }
}
