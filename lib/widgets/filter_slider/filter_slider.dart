import 'package:arcana_box/widgets/filter_slider/slider_plain_handler.dart';
import 'package:arcana_box/widgets/filter_slider/slider_themed_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'dart:io';

import '../../constants.dart';
import '../../utils.dart';

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
        ? sliderThemedHandler(handlerValue, isRightHandler ? 1 : type!)
        : sliderPlainHandler(handlerValue);
  }
}
