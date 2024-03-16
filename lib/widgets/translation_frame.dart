import 'package:arcana_box/widgets/text_progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants.dart';
import '../controllers/translation_controller/translation_controller.dart';
import '../models/card.dart';
import '../utils.dart';

class TranslationFrame extends StatelessWidget {
  const TranslationFrame({
    super.key,
    required this.translationService,
    required this.card,
  });

  final TranslationController translationService;
  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return card.bodyText != null
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
                      child: FutureBuilder<CardTranslations>(
                          future:
                              translationService.getTranslate(card.bodyText),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const SizedBox(height: 85,
                                child: Center(
                                    child: TextLoadingProgressIndicator()),
                              );
                            } else {
                              if (snapshot.data!.bodyText != null) {
                                return RawScrollbar(
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
                                          .buildRichText(
                                              snapshot.data!.bodyText!)
                                          .animate(effects: [
                                        FadeEffect(duration: 200.milliseconds)
                                      ]),
                                    ),
                                  ),
                                );
                              } else {
                                return const Text(" No translation available ");
                              }
                            }
                          }),
                    ),
                  ),
                ),
                Positioned(
                  right: 15,
                  bottom: 1.5,
                  child: Text(
                    "Unofficial translation",
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
  }
}
