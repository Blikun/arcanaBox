import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TextLoadingProgressIndicator extends StatelessWidget {
  const TextLoadingProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          _buildAnimatedDivider(),
          _buildAnimatedDivider(delay: 0.2),
          _buildAnimatedDivider(delay: 0.4, endIndent: 140),
        ],
      ),
    );
  }

  Widget _buildAnimatedDivider({double delay = 0, double endIndent = 0}) {
    return Animate(
      onPlay: (controller) => controller.repeat(),
      effects: [ShimmerEffect(duration: 1.seconds, delay: delay.seconds)],
      child: Divider(
        thickness: 10,
        color: Colors.black12,
        endIndent: endIndent,
      ),
    );
  }
}