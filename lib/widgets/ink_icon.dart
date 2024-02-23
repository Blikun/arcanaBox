import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InkIcon extends StatelessWidget {
  final Color color;
  final String ink;
  final double size;
  final bool selected;
  final Function() onTap;

  const InkIcon({
    super.key,
    required this.color,
    required this.ink,
    required this.onTap,
    this.size = 35,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: 0.3.seconds,
      height: size,
      width: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          color: selected ? color : Colors.transparent // color,
          ),
      child: IconButton(
          padding: const EdgeInsets.all(2),
          onPressed: () {
            onTap();
          },
          icon: Image.asset(
            ink,
          )),
    );
  }
}
