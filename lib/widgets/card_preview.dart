import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants.dart';

class CardPreview extends StatelessWidget {
  final String image;
  final Function onTap;
  final bool enchantedMark;

  const CardPreview({
    super.key,
    required this.image,
    required this.onTap,
    this.enchantedMark = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Transform.translate(
        offset: Offset.fromDirection(1, -1),
        child: Image.network(
          image,
          cacheHeight: 306,
          cacheWidth: 220,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return FlipCard(
                front: GestureDetector(
                    onTap: () => onTap(),
                    child: Stack(
                      children: [
                        child,
                        if (enchantedMark)
                          Positioned(
                              left: 7,
                              top: 36,
                              child: Image.asset(
                                Constants.enchanted,
                                scale: 7,
                                isAntiAlias: true,
                              )),
                      ],
                    )),
                flipOnTouch: false,
                back: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Transform.translate(
                    offset: Offset.fromDirection(1, -1),
                    child: Image.asset(
                      Constants.cardBack,
                    ),
                  ),
                ),
                speed: 300,
                autoFlipDuration: 0.seconds,
                side: CardSide.BACK,
              );
            }
            return Center(
              child: Image.asset(Constants.cardBack),
            );
          },
        ),
      ),
    );
  }
}
