
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

import '../../constants.dart';
import '../../utils.dart';

FlutterSliderHandler sliderPlainHandler(String cost) {
  return FlutterSliderHandler(
    decoration: const BoxDecoration(),
    child: Container(
      decoration: const BoxDecoration(
        color: Constants.goldColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              color: Colors.black,
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 1))
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(2),
        width: 20,
        decoration: const BoxDecoration(
            color: Constants.darkBlue, shape: BoxShape.circle),
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Text(
            Utils().handlerCostFormat(cost),
            style: Constants.cabinStyle
                .copyWith(color: Colors.white.withOpacity(0.8)),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}