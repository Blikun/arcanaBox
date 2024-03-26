import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../controllers/translation_controller/translation_controller.dart';
import '../models/card.dart';
import '../models/card_translation.dart';
import '../utils.dart';

class TranslationFrame extends StatelessWidget {
  TranslationFrame({
    super.key,
    required this.translationService,
    required this.card,
  });

  final TranslationController translationService;
  final CardModel card;
  final Rx<bool> _hasContent = false.obs;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TranslationController>(builder: (controller) {
      CardTranslation? existingTranslation;

      // Attempt to find a translation that matches the card's number
      for (var translation in controller
              .state.translations.value[card.setNum]?[controller.state.appLanguage.value] ??
          []) {
        if (translation.cardId == card.cardNum) {
          existingTranslation = translation;
          break; // Break the loop once a match is found
        }
      }

      (existingTranslation == null || existingTranslation.bodyText == null)
          ? _hasContent.value = false
          : _hasContent.value = true;

      if (_hasContent.isFalse) {
        controller.translateCard(card);
      }

      return Obx(() {
        return _hasContent.isTrue
            ? Animate(
                effects: const [FadeEffect()],
                child: Stack(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 220),
                      child: Container(
                        padding: const EdgeInsets.all(13),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              image: const DecorationImage(
                                  image: AssetImage(
                                    Constants.cadCanvas,
                                  ),
                                  fit: BoxFit.fill)),
                          width: double.infinity,
                          child: RawScrollbar(
                            thickness: 3,
                            thumbColor: Colors.black,
                            thumbVisibility: true,
                            padding: const EdgeInsets.only(right: 1.5),
                            radius: const Radius.circular(90),
                            mainAxisMargin: 1.5,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 10),
                                child: Utils()
                                    .buildCoolText(translationService
                                        .state
                                        .translations
                                        .value[card.setNum]![translationService
                                            .state.appLanguage.value]!
                                        .firstWhere((translation) =>
                                            translation.cardId == card.cardNum)
                                        .bodyText!)
                                    .animate(effects: [
                                  const FadeEffect(
                                      duration: Duration(milliseconds: 200))
                                ]),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 15,
                      bottom: 1.5,
                      child: Text(
                        "Translation by Google",
                        style: Constants.googleHeebo.copyWith(
                          color: Colors.white.withOpacity(0.75),
                          fontSize: 9,
                        ),
                      ),
                    )
                  ],
                ),
              )
            : const SizedBox();
      });
    });
  }
}
