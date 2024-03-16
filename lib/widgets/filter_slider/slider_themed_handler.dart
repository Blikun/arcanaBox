import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

import '../../constants.dart';
import '../../utils.dart';

FlutterSliderHandler sliderThemedHandler(String cost, int type, ) {
    // todo: this is a bad patch for fine fitting the icons, todo -> fix the icons img
    final double? fontSize = cost == "-1" ? 13.5 : null;
    final double? height = cost == "-1" ? 1.6 : null;
    final EdgeInsets margin;
    final EdgeInsets padding;
    switch (type) {
      case 1:
        margin = const EdgeInsets.all(2);
        break;
      default:
        margin = EdgeInsets.zero;
    }
    switch (type) {
      case 1:
        padding = const EdgeInsets.only(top: 5);
        break;
      case 2:
        padding = const EdgeInsets.only(top: 6);
        break;
      default:
        padding = const EdgeInsets.only(top: 10);
    }

    return FlutterSliderHandler(
      decoration: const BoxDecoration(),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.black54,
                spreadRadius: 0.05,
                blurRadius: 5,
                offset: Offset(0, 1))
          ],
        ),
        child: Container(
          margin: margin,
          width: 40,
          height: 35,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: Utils().attributeTypeImage(type),
                  fit: BoxFit.contain)),
          child: Padding(
            padding: padding,
            child: Text(
              cost == "-1" ? "?" : cost,
              style: Constants.cabinStyle.copyWith(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: fontSize,
                  height: height),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );

}