import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../utils.dart';

class FilterSlider extends StatelessWidget {
  final Function() getValue;
  final Function(List<int>) setValue;
  final double max;
  final double min;
  final String label;
  final bool range;
  final Function onChanged;
  final int? type;

  const FilterSlider({
    super.key,
    required this.getValue,
    required this.setValue,
    required this.range,
    required this.max,
    required this.label,
    required this.min,
    required this.onChanged,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var value = getValue().value;
      return FlutterSlider(
        rangeSlider: range,
        handler: range
            ? type != null
                ? _sliderThemedHandler(value[0].toString(), 1)
                : _sliderHandler(value[0].toString())
            : type != null
                ? _sliderThemedHandler(value.toString(), type!)
                : _sliderHandler(value.toString()),
        rightHandler: range
            ? type != null
                ? _sliderThemedHandler(value[1].toString(), 1)
                : _sliderHandler(value[1].toString())
            : null,
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
            color: Colors.black12,
            border: Border.all(
                width: 8, color: Constants.goldColor.withOpacity(0.4)),
          ),
          activeTrackBar: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black12,
            border: Border.all(width: 8, color: Constants.goldColor),
          ),
        ),
        min: min,
        max: max,
        onDragCompleted: (handlerIndex, lower, upper) {
          if (range) {
            setValue([lower.toInt(), upper.toInt()]);
          } else {
            setValue([lower.toInt()]);
          }
          onChanged();
        },
        values: range == true
            ? [value[0].toDouble(), value[1].toDouble()]
            : [value.toDouble()],
        tooltip: _tooltip(),
      );
    });
  }

  _tooltip() {
    return FlutterSliderTooltip(
        format: (val) {
          if (val == "-1.0") return "?";
          if (val == "0.0") return "0";
          return val.replaceAll(".0", "");
        },
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
              Utils().formatCost(cost),
              style: Constants.cabinStyle
                  .copyWith(color: Colors.white.withOpacity(0.8)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  _sliderThemedHandler(String cost, int type) {
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
          margin: EdgeInsets.all(type == 1
              ? 2
              : type == 2
                  ? 0
                  : 0),
          width: 40,
          height: 35,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: Utils().typeToImageAsset(type), fit: BoxFit.contain)),
          child: Padding(
            padding: EdgeInsets.only(
                top: type == 1
                    ? 5
                    : type == 2
                        ? 6
                        : 10),
            child: Text(
              cost == "-1" ? "?" : cost,
              style: Constants.cabinStyle.copyWith(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: cost == "-1" ? 13.5 : null,
                  height: cost == "-1" ? 1.6 : null),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
