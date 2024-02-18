import 'package:arcana_box/widgets/translation_frame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../controllers/translation_service.dart';
import '../models/card.dart';

class CardDetails extends StatefulWidget {
  final LCard card;

  const CardDetails({
    super.key,
    required this.card,
  });

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  final translationService = TranslationService();
  bool alternate = false;

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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Transform.translate(
                        offset: Offset.fromDirection(1, -1),
                        child: alternate
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
                                child: Image.asset(widget.card.enchantedImage!),
                              )
                            : Image.network(widget.card.image!),
                      ),
                    ),
                    if (widget.card.enchantedImage != null &&
                        widget.card.enchantedImage! != "")
                      Positioned(
                          right: 4,
                          child: Stack(children: [
                            ElevatedButton(
                                onPressed: () => setState(() {
                                      alternate = !alternate;
                                    }),
                                child: Text(
                                  alternate
                                      ? "       Alternate"
                                      : "       Standard",
                                  style: const TextStyle(fontSize: 12),
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
                    translationService: translationService, card: widget.card)
              ],
            ),
          ),
        ));
  }
}
