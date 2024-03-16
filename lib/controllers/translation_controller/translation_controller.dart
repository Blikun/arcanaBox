import 'package:get/get.dart';
import 'package:translator/translator.dart';

import '../../models/card.dart';
part 'translation_state.dart';

class TranslationController {
  final TranslationState state;
  TranslationController(this.state);


  Future<CardTranslations> getTranslate(String? text) async {
    if (text != null) {
      try {
        var translation = await state.translator.translate(
            prepareForTranslate(text),
            from: state.baseLanguage,
            to: state.language.value);
        return CardTranslations(bodyText: translation.toString());
      } catch (e) {
        //todo: rework
        //returning a default error translation by now
        return CardTranslations(bodyText: "Translation error");
      }
    }
    return CardTranslations();
  }

  String prepareForTranslate(String text) {
    String preparedText = text
        .replaceAll("{s}", "Strength value")
        .replaceAll("{l}", "Lore")
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
        .replaceAll("if able", "if possible")
        .replaceAll("facedown", "faced downwards")
        .replaceAll("instead", "instead of that");

    return preparedText;
  }
}
