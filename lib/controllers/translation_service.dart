import 'package:arcana_box/models/card.dart';
import 'package:get/get.dart';
import 'package:translator/translator.dart';

class TranslationService {
  final language = "es".obs;
  static const baseLanguage = "en";
  final translator = GoogleTranslator();

  Future<CardTranslations> getTranslate(String? text) async {
    if (text != null) {
      var translation = await translator.translate(prepareForTranslate(text),
          from: baseLanguage, to: language.value);
      return CardTranslations(bodyText: translation.toString());
    }
    return CardTranslations();
  }

  String prepareForTranslate(String text) {
    String preparedText = text
        .replaceAll("{s}", "Strength value")
        .replaceAll("{l}", "'Lore'")
        .replaceAll("{e}", "be turned sideways")
        .replaceAll("{i}", "ink")
        .replaceAll("on top of", "placed over")
        .replaceAll("draw", "get")
        .replaceAll("top", "top placed")
        .replaceAll("quest", 'do "quest"')
        .replaceAll("this turn", "in this turn")
        .replaceAll("play this character", "put this character in play")
        .replaceAll("play a character", "put a character in play")
        .replaceAll("can challenge", "can do a challenge")
        .replaceAll("the turn", "in the turn")
        .replaceAll("exerted", "turned sideways")
        .replaceAll("item", "object")
        .replaceAll("gain", "obtain")
        .replaceAll("chosen", "the chosen")
        .replaceAll("if able", "if its possible")
        .replaceAll("facedown", "faced downwards")
        .replaceAll("instead", "instead of that");

    return preparedText;
  }
}
