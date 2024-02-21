import 'package:arcana_box/widgets/translation_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../constants.dart';
import '../controllers/translation_service.dart';
import '../models/card.dart';

class CardDetailsDialog extends StatelessWidget {
  final LCard card;
  final TranslationService? translationService;

  CardDetailsDialog({super.key, required this.card, this.translationService});

  final RxBool _hasAlternateArt = false.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Material(
        color: Colors.black54,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Transform.translate(
                      offset: Offset.fromDirection(1, -1),
                      child: Obx(() => _hasAlternateArt.isTrue
                          ? _enchantedDisplay()
                          : _standardDisplay()),
                    ),
                  ),
                  if (card.enchantedImage?.isNotEmpty ?? false)
                    _enchantedButton(),
                ],
              ),
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

  Widget _enchantedButton() {
    return Positioned(
      right: 4,
      child: Stack(
        children: [
          ElevatedButton(
            onPressed: () => _hasAlternateArt.toggle(),
            child: Padding(
              padding: const EdgeInsets.only(left: 22),
              child: Obx(() => Text(
                  _hasAlternateArt.isTrue ? "Alternate" : "Standard",
                  style: const TextStyle(fontSize: 13))),
            ),
          ),
          Positioned(
              top: 12,
              left: 17,
              child: IgnorePointer(
                child: Image.asset(
                  Constants.enchanted,
                  scale: 8,
                ),
              )),
        ],
      ),
    );
  }
}