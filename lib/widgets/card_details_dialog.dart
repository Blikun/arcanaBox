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

  final _alternate = false.obs;

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
                    Obx(
                      () => ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Transform.translate(
                          offset: Offset.fromDirection(1, -1),
                          child: _alternate.isTrue
                              ? Animate(
                                  autoPlay: true,
                                  onPlay: (controller) => controller.repeat(),
                                  effects: [
                                    ShimmerEffect(
                                        duration: const Duration(seconds: 6),
                                        angle: 40,
                                        colors: Constants.foilColors)
                                  ],
                                  child: Image.asset(card.enchantedImage!),
                                )
                              : Image.network(
                                  card.image!,
                                  errorBuilder: (BuildContext context,
                                      Object error, StackTrace? stackTrace) {
                                    return Image.asset(Constants.cardBack);
                                  },
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Opacity(
                                            opacity: 0.4,
                                            child: Image.asset(
                                              Constants.cardBack,
                                              color: Colors.black,
                                            ))
                                        .animate(
                                            onPlay: (controller) =>
                                                controller.repeat(),
                                            effects: [
                                          ShimmerEffect(
                                              duration: const Duration(seconds: 1),
                                              color: Colors.purple
                                                  .withOpacity(0.2))
                                        ]);
                                  },
                                ),
                        ),
                      ),
                    ),
                    if (card.enchantedImage != null &&
                        card.enchantedImage! != "")
                      Positioned(
                          right: 4,
                          child: Stack(children: [
                            ElevatedButton(
                                onPressed: () {
                                  _alternate.value = !_alternate.value;
                                },
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 22),
                                    child: Obx(
                                      () => Text(
                                        _alternate.isTrue
                                            ? "Alternate"
                                            : "Standard",
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ))),
                            Positioned(
                                top: 12,
                                left: 17,
                                child: IgnorePointer(
                                  child: Image.asset(
                                    Constants.enchanted,
                                    scale: 8,
                                  ),
                                )),
                          ]))
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                if (translationService != null)
                  TranslationFrame(
                      translationService: translationService!, card: card)
              ],
            ),
          ),
        ));
  }
}
