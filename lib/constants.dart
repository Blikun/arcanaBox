import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {

  /// static assets
  static const String cardBack = "assets/cardback.webp";
  static const String cadCanvas = "assets/canvas.png";
  static const String decorationFrame = "assets/decoration_frame.png";

  static const String enchanted = "assets/icons/enchantedIcon.png";

  static const String cardTrader = "assets/icons/cardtrader.png";

  static const String willpowerFrame = "assets/willpower.png";
  static const String strengthFrame = "assets/strength.png";
  static const String loreFrame = "assets/lore.png";

  static const String inkSapphire = "assets/icons/ink_sapphire.png";
  static const String inkAmber = "assets/icons/ink_amber.png";
  static const String inkAmethyst = "assets/icons/ink_amethyst.png";
  static const String inkEmerald = "assets/icons/ink_emerald.png";
  static const String inkSteel = "assets/icons/ink_steel.png";
  static const String inkRuby = "assets/icons/ink_ruby.png";

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

  static const darkBlue = Color(0xFF1F1D2A);

  static const goldColor = Color(0xFFE3C886);
  static const amethystColor = Color(0xFF7D3978);
  static const emeraldColor = Color(0xFF298634);
  static const sapphireColor = Color(0xFF3085BE);
  static const rubyColor = Color(0xFFCB1230);
  static const steelColor = Color(0xFF9AA4AD);
  static const amberColor = Color(0xFFECAE0D);

  static const List<Map<String, dynamic>> inkColors = [
    {'ink': Constants.inkSteel, 'color': Constants.steelColor, 'name': "Steel"},
    {'ink': Constants.inkRuby, 'color': Constants.rubyColor, 'name': "Ruby"},
    {'ink': Constants.inkAmber, 'color': Constants.amberColor, 'name': "Amber"},
    {'ink': Constants.inkEmerald, 'color': Constants.emeraldColor, 'name': "Emerald"},
    {'ink': Constants.inkSapphire, 'color': Constants.sapphireColor, 'name': "Sapphire"},
    {'ink': Constants.inkAmethyst, 'color': Constants.amethystColor, 'name': "Amethyst"},
  ];

  static final List<Color> foilColors = [
    Colors.greenAccent.withOpacity(0.15),
    Colors.white.withOpacity(0.2),
    Colors.yellow.withOpacity(0.2),
    Colors.blue.withOpacity(0.15),
    Colors.pinkAccent.withOpacity(0.15),
    Colors.greenAccent.withOpacity(0.15),
  ];
}

enum CommState {
  loading,
  done,
  error,
  idle
}
