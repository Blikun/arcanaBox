import 'package:flutter/material.dart';
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
          cacheHeight: 260,
          cacheWidth: 187,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return GestureDetector(
                  onTap: () => onTap(),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      child.animate(effects: [
                        const FlipEffect(
                            direction: Axis.horizontal,
                            curve: Curves.fastEaseInToSlowEaseOut)
                      ]),
                      if (enchantedMark)
                        Positioned(
                            bottom: 0,
                            child: Image.asset(
                              Constants.enchanted,
                              scale: 9,
                              isAntiAlias: true,
                            )),
                    ],
                  ));
            }
            return Animate(
              effects: const [FadeEffect()],
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  Constants.cardBack,
                  cacheWidth: 187,
                  cacheHeight: 260,
                ),
              ),
            );
          },
          errorBuilder: (context, object, e) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Transform.translate(
                offset: Offset.fromDirection(1, -1),
                child: Image.asset(
                  Constants.cardBack,
                  color: Colors.black87,
                  colorBlendMode: BlendMode.color,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
