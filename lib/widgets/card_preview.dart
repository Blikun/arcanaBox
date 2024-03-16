import 'package:cached_network_image/cached_network_image.dart';
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
      borderRadius: BorderRadius.circular(10),
      child: Transform.translate(
        offset: Offset.fromDirection(1, -1),
        child: CachedNetworkImage(
          imageUrl: image,
          imageBuilder: (context, imageProvider) => GestureDetector(
              onTap: () => onTap(),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image(
                    image: imageProvider,
                  ),
                  if (enchantedMark)
                    Positioned(
                        bottom: 0,
                        child: Image.asset(
                          Constants.enchanted,
                          scale: 9,
                          isAntiAlias: true,
                        )),
                ],
              )),
          placeholder: (context, url) => Animate(
            effects: const [],
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                Constants.cardBack,
                cacheWidth: 187,
                cacheHeight: 260,
              ),
            ),
          ),
          errorWidget: (context, url, e) {
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
