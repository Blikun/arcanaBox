import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {

  /// static assets
  static const String cardBack = "assets/cardback.webp";
  static const String enchanted = "assets/enchanted.png";
  static const String cadCanvas = "assets/canvas.png";

  ///static styles
  static final TextStyle cabinStyle = GoogleFonts.cabinCondensed(
      fontSize: 16.5,
      color: Colors.black.withOpacity(0.8),
      fontWeight: FontWeight.w500,
      height: 0,
      letterSpacing: 0,
      wordSpacing: 0);

  static final TextStyle googleHeebo = GoogleFonts.josefinSans(
      fontSize: 14,
      color: Colors.black87,
      fontWeight: FontWeight.w500,
      height: 0,
      letterSpacing: 0,
      wordSpacing: 0);

  ///static values
  static const cardAspectRatio = 693 / 985;
  static final List<Color> foilColors = [
    Colors.greenAccent.withOpacity(0.15),
    Colors.white.withOpacity(0.2),
    Colors.yellow.withOpacity(0.2),
    Colors.blue.withOpacity(0.15),
    Colors.pinkAccent.withOpacity(0.15),
    Colors.greenAccent.withOpacity(0.15),
  ];
}
