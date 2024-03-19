import 'package:flutter/material.dart';

import '../../constants.dart';

class EnchantedButton extends StatelessWidget {
  final Function onTap;
  final bool isToggled;
  const EnchantedButton({super.key, required this.onTap, required this.isToggled});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ElevatedButton(
          onPressed: () => onTap(),
          child: Padding(
            padding: const EdgeInsets.only(left: 22),
            child:  Text(
                isToggled == true ? "Alternate" : "Standard",
                style: const TextStyle(fontSize: 13)),
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
    );
  }
}
