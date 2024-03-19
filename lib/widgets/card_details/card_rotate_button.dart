import 'package:flutter/material.dart';
import 'package:icon_decoration/icon_decoration.dart';

import '../../constants.dart';

class CardRotateButton extends StatelessWidget {
  final Function onTap;
  const CardRotateButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onTap(),
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
    );
  }
}
