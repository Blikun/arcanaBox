class Utils {
  String? getEnchantedImage(int? cardNum) {
    switch (cardNum) {
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
}