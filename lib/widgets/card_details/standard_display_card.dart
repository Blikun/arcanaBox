import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../constants.dart';
import '../../models/card.dart';

class StandardDisplayCard extends StatelessWidget {
  final CardModel card;

  const StandardDisplayCard({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      card.image!,
      errorBuilder: (context, error, stackTrace) =>
          Image.asset(Constants.cardBack),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Opacity(
          opacity: 0.4,
          child: Image.asset(Constants.cardBack, color: Colors.black),
        ).animate(onPlay: (controller) => controller.repeat(), effects: [
          ShimmerEffect(
              duration: const Duration(seconds: 1),
              color: Colors.purple.withOpacity(0.25))
        ]);
      },
    );
  }
}
