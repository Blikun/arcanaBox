import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:icon_decoration/icon_decoration.dart';

import '../../constants.dart';

class RotateCardButton extends StatelessWidget {
  final VoidCallback onRotate;
  final RxBool rotated;

  const RotateCardButton({
    super.key,
    required this.onRotate,
    required this.rotated,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: rotated.isTrue ? null : 0,
      child: IconButton(
        onPressed: onRotate,
        highlightColor: Colors.black38,
        padding: EdgeInsets.zero,
        icon: const DecoratedIcon(
          icon: Icon(
            Icons.rotate_90_degrees_cw_rounded,
            color: Constants.goldColor,
            size: 35,
          ),
          decoration: IconDecoration(
              border: IconBorder(width: 10, color: Colors.black87)),
        ),
      ),
    );
  }
}