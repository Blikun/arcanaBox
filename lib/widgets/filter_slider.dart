import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'dart:io';

import '../constants.dart';
import '../utils.dart';

class FilterSlider extends StatelessWidget {
  final dynamic value;
  final Function(List<int>) setValue;
  final double max;
  final double min;
  final String label;
  final bool isRange;
  final Function onChanged;
  final int? type;

  const FilterSlider({
    super.key,
    required this.value,
    required this.setValue,
    required this.isRange,
    required this.max,
    required this.label,
    required this.min,
    required this.onChanged,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return
       FlutterSlider(
        rangeSlider: isRange,
        handler: _determineHandler(value),
        rightHandler: _determineHandler(value, isRightHandler: true),
        trackBar: FlutterSliderTrackBar(
          centralWidget: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text(
                label,
                style: Constants.cabinStyle
                    .copyWith(color: Constants.goldColor.withOpacity(0.8)),
              )),
          inactiveTrackBar: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Utils().sliderNativeColorFix(),
            border: Border.all(
                width: 8, color: Constants.goldColor.withOpacity(0.4)),
          ),
          activeTrackBar: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Utils().sliderNativeColorFix(),
            border: Border.all(
                width: Platform.isAndroid ? 1 : 8, color: Constants.goldColor),
          ),
        ),
        min: min,
        max: max,
        onDragCompleted: (handlerIndex, lower, upper) {
          if (isRange) {
            setValue([lower.toInt(), upper.toInt()]);
          } else {
            setValue([lower.toInt()]);
          }
          onChanged();
        },
        values: isRange == true
            ? [value[0].toDouble(), value[1].toDouble()]
            : [value.toDouble()],
        tooltip: _tooltip(),
      );

  }

  // Tooltip
  _tooltip() {
    return FlutterSliderTooltip(
        format: (val) => Utils().handlerTooltipFormat(val),
        positionOffset: FlutterSliderTooltipPositionOffset(top: 20),
        textStyle:
            Constants.cabinStyle.copyWith(color: Colors.white.withOpacity(0.8)),
        boxStyle: FlutterSliderTooltipBox(
            decoration: BoxDecoration(
          border: Border.all(color: Constants.goldColor, width: 2),
          shape: BoxShape.circle,
          color: Constants.darkBlue,
        )));
  }

  // Helper method to determine the appropriate sliderHandler
  FlutterSliderHandler _determineHandler(dynamic value,
      {bool isRightHandler = false}) {

    bool isRangeAndRight = isRange && isRightHandler;
    String handlerValue = "";

    if (isRange) {
      handlerValue =
          isRangeAndRight ? value[1].toString() : value[0].toString();
    }
    if (!isRange) {
      handlerValue = value.toString();
    }

    bool useThemedHandler = type != null && !isRange;

    return useThemedHandler
        ? _sliderThemedHandler(handlerValue, isRightHandler ? 1 : type!)
        : _sliderHandler(handlerValue);
  }

  // plain rounded handler widget
  _sliderHandler(String cost) {
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

  // themed handler widget based on card's attribute type
  _sliderThemedHandler(String cost, int type) {
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
}
