import 'package:arcana_box/widgets/translation_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../controllers/translation_service.dart';
import '../models/card.dart';

class CardDetailsDialog extends StatelessWidget {
  final LCard card;

  CardDetailsDialog({super.key, required this.card});

  final translationService = TranslationService();
  var alternate = false.obs;

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
                Stack(
                  children: [
                    Obx(
                          () => ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Transform.translate(
                          offset: Offset.fromDirection(1, -1),
                          child: alternate.isTrue
                              ? Animate(
                            autoPlay: true,
                            onPlay: (controller) => controller.repeat(),
                            effects: [
                              ShimmerEffect(
                                  duration: const Duration(seconds: 6),
                                  angle: 40,
                                  colors: [
                                    Colors.greenAccent.withOpacity(0.15),
                                    Colors.white.withOpacity(0.3),
                                    Colors.yellow.withOpacity(0.2),
                                    Colors.blue.withOpacity(0.15),
                                    Colors.pinkAccent.withOpacity(0.15),
                                    Colors.greenAccent.withOpacity(0.15),
                                  ])
                            ],
                            child:
                            Image.asset(card.enchantedImage!),
                          )
                              : Image.network(card.image!),
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
                                  alternate.value = !alternate.value;
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(left: 22),
                                  child: Text(
                                    alternate.value ? "Alternate" : "Standard",
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                )),
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
                TranslationFrame(
                    translationService: translationService, card: card)
              ],
            ),
          ),
        ));
  }
}

