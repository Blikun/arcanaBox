import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants.dart';
import '../controllers/translation_service.dart';
import '../models/card.dart';

class TranslationFrame extends StatelessWidget {
  const TranslationFrame({
    super.key,
    required this.translationService,
    required this.card,
  });

  final TranslationService translationService;
  final LCard card;

  @override
  Widget build(BuildContext context) {
    return card.bodyText != null
        ? Animate(
            effects: const [FadeEffect(delay: Duration(milliseconds: 200))],
            child: Container(
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  gradient: const LinearGradient(colors: [
                    Color(0xffd0b37e),
                    Color(0xffd0b37e),
                    Color(0xffe7c48a),
                    Color(0xffeed08d),
                    Color(0xffffe4b0)
                  ]),
                ),
                width: double.infinity,
                child: FutureBuilder<CardTranslations>(
                    future: translationService.getTranslate(card.bodyText),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: Padding(
                                padding: EdgeInsets.all(5),
                                child: CircularProgressIndicator(
                                  color: Color(0xffeed08d),
                                )));
                      } else {
                        if (snapshot.data!.bodyText != null) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            child: SingleChildScrollView(
                              child: Text(
                                snapshot.data!.bodyText!,
                                style: Constants.bodyStyle,
                              ),
                            ),
                          );
                        } else {
                          return const Text("Unable to translate");
                        }
                      }
                    }),
              ),
            ),
          )
        : SizedBox();
  }
}
