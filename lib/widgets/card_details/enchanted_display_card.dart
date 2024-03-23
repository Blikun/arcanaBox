import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../constants.dart';
import '../../models/card.dart';

class EnchantedDisplayCard extends StatelessWidget {
  final CardModel card;

  const EnchantedDisplayCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
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
}
