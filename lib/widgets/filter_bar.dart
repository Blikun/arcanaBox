import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            AnimatedContainer(
              duration: 1.seconds,
              width: double.infinity,
              height: 55,
              decoration: const BoxDecoration(
                color: Constants.amethystColor,
                image: DecorationImage(
                    image: AssetImage(Constants.decorationFrame),
                    alignment: Alignment.bottomCenter,
                    fit: BoxFit.cover,
                    opacity: 0.1),
              ),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.filter_list_rounded,
                        color: Constants.goldColor,
                      ))
                ],
              ), // Your existing container
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 50, // Height of the gradient line
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      // Start with transparent color
                      Constants.goldColor.withOpacity(0.15),
                      // End with yellow color
                    ],
                    begin: Alignment.topCenter, // Gradient starts from the top
                    end: Alignment.bottomCenter, // And ends at the bottom
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 5, // Height of the gradient line
            decoration:
                BoxDecoration(color: Constants.goldColor.withOpacity(0.9)),
          ),
        ),
      ],
    );
  }
}
