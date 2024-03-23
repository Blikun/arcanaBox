import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../constants.dart';

class EnchantedButton extends StatelessWidget {
  final VoidCallback onToggle;
  final RxBool showAlternateArt;

  const EnchantedButton({
    super.key,
    required this.onToggle,
    required this.showAlternateArt,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Stack(
        children: [
          ElevatedButton(
            onPressed: onToggle,
            child: Padding(
              padding: const EdgeInsets.only(left: 22),
              child: Obx(() => Text(
                  showAlternateArt.isTrue ? "Alternate" : "Standard",
                  style: const TextStyle(fontSize: 13))),
            ),
          ),
          Positioned(
              top: 12,
              left: 17,
              child: IgnorePointer(
                child: Image.asset(
                  Constants.enchanted,
                  scale: 8,
                ),
              )),
        ],
      ),
    );
  }
}
