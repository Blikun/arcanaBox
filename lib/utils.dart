import 'package:flutter/material.dart';
import 'dart:io';

import 'constants.dart';

class Utils {
  RichText buildCoolText(String text) {
    // regular expression to find text within parentheses
    final RegExp regExpPar = RegExp(r'\(([^)]+)\)');
    final Iterable<RegExpMatch> matches = regExpPar.allMatches(text);

    List<TextSpan> spans = [];
    int start = 0;
    for (final RegExpMatch match in matches) {
      if (match.start > start) {
        spans.add(TextSpan(text: text.substring(start, match.start)));
      }
      String matchText =
          match.group(0)!; // Group 0 is match including parentheses
      spans.add(TextSpan(
          text: matchText,
          style: Constants.cabinStyle.copyWith(fontStyle: FontStyle.italic)));

      start = match.end;
    }
    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }
    return RichText(
        text: TextSpan(style: Constants.cabinStyle, children: spans));
  }

  String? getEnchantedImage(int? cardNum) {
    switch (cardNum) {
      case 1931:
        return "assets/1931e.jpg";
      case 211:
        return "assets/211e.jpeg";
      case 1891:
        return "assets/1891e.jpeg";
      case 511:
        return "assets/511e.jpeg";
      case 881:
        return "assets/881e.jpeg";
      case 1141:
        return "assets/1141e.jpeg";
      case 51:
        return "assets/51e.jpeg";
      case 751:
        return "assets/751e.jpeg";
      case 421:
        return "assets/421e.jpeg";
      case 1421:
        return "assets/1421e.jpeg";
      case 1391:
        return "assets/1391e.jpeg";
      case 1041:
        return "assets/1041e.jpeg";

      case 1372:
        return "assets/1372e.jpeg";
      case 32:
        return "assets/32e.jpeg";
      case 702:
        return "assets/702e.jpeg";
      case 352:
        return "assets/352e.jpeg";
      case 1592:
        return "assets/1592e.jpeg";
      case 1812:
        return "assets/1812e.jpeg";
      case 1102:
        return "assets/1102e.jpg";
      case 472:
        return "assets/472e.jpeg";
      case 1892:
        return "assets/1892e.jpeg";
      case 882:
        return "assets/882e.jpeg";
      case 1262:
        return "assets/1262e.jpeg";
      case 252:
        return "assets/252e.jpeg";
      default:
        return null; // Default image or an empty string if no match
    }

  }

  double calculateAveragePrice(
      {required List<dynamic> entries, int max = 5, String currency = 'EUR'}) {

    double sum = 0;
    int checked = 0;

    for (var i = 0; i < entries.length && checked < max; i++) {
      if (entries[i]['price_currency'] == 'EUR') {
        sum += entries[i]['price_cents'] ?? 0;
        checked++;
      }
    }
    double averagePriceCents = checked > 0 ? sum / checked : 0;
    return averagePriceCents / 100;
  }

  int cardNumberFix(String number) {
    // Remove all non-numeric characters (including letters and special characters)
    String cleanedNumber = number.replaceAll(RegExp(r'[^0-9/]'), '');

    if (cleanedNumber.contains('/')) {
      List<String> split = cleanedNumber.split('/');
      return int.parse(split.first);
    }
    return int.parse(cleanedNumber);
  }

  Color sliderNativeColorFix() {
    return Platform.isAndroid
        ? Constants.goldColor.withOpacity(0.25)
        : Colors.black12;
  }

  String handlerCostFormat(String cost) {
    switch (cost) {
      case "0":
        return "0";
      case "-1":
        return "-";
      default:
        return cost;
    }
  }

  String handlerTooltipFormat(String val) {
    if (val == "-1.0") return "?";
    if (val == "0.0") return "0";
    return val.replaceAll(".0", "");
  }


  AssetImage attributeTypeImage(int type) {
    switch (type) {
      case 1:
        return const AssetImage(Constants.willpowerFrame);
      case 2:
        return const AssetImage(Constants.strengthFrame);
      default:
        return const AssetImage(Constants.loreFrame);
    }
  }
}
