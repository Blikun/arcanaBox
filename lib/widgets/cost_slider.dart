import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';

import '../constants.dart';

class FilterSlider extends StatelessWidget {
  final Rx<List<int>> Function() getValue;
  final Function(List<int>) setValue;
  final double max;
  final double min;
  final String label;
  final bool range;
  final Function onChanged;

  const FilterSlider({
    super.key,
    required this.getValue,
    required this.setValue,
    required this.range,
    required this.max, required this.label, required this.min, required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var values = getValue().value;
      return FlutterSlider(
        rangeSlider: range,
        handler: _costHandler(Icons.chevron_right, values[0].toString()),
        rightHandler: _costHandler(Icons.chevron_right, values[1].toString()),
        trackBar: FlutterSliderTrackBar(
          centralWidget: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                label,
                style: Constants.cabinStyle.copyWith(color: Constants.goldColor.withOpacity(0.8)),
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
        onDragCompleted: (handlerIndex, lower, upper){
          setValue([lower.toInt(), upper.toInt()]);
          onChanged();
        },
        values: [values[0].toDouble(), values[1].toDouble()],
        tooltip: _tooltip(),
      );
    });
  }

  _tooltip() {
    return FlutterSliderTooltip(
        format: (val) {
          if (val == "0.0" ) return "-";
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

  _costHandler(IconData icon, String cost) {
    return FlutterSliderHandler(
      decoration: const BoxDecoration(),
      child: Container(
        decoration: const BoxDecoration(
          color: Constants.goldColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                spreadRadius: 0.05,
                blurRadius: 5,
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
              cost == "0" ? "-" : cost,
              style: Constants.cabinStyle
                  .copyWith(color: Colors.white.withOpacity(0.8)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
