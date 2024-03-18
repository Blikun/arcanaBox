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
        .replaceAll("{s}", "[Strength]")
        .replaceAll("{p}", "[Power]")
        .replaceAll("{l}", "[Lore]")
        .replaceAll("{e}", "[Turn itself sideways]")
        .replaceAll("{i}", "[Ink]")
        .replaceAll("on top of", "placed over")
        .replaceAll("draw", "get")
        .replaceAll("Draw", "Get")
        .replaceAll("top", "top placed")
        .replaceAll("play this location", "put this location in play")
        .replaceAll("play a location", "put a location in play")
        .replaceAll("quests", 'does [Quest]')
        .replaceAll("quest", 'do [Quest]')
        .replaceAll("lore", '[Lore]')
        .replaceAll("this turn", "in this turn")
        .replaceAll("play this character", "put this character in play")
        .replaceAll("play a character", "put a character in play")
        .replaceAll("can challenge", "can do a challenge")
        .replaceAll("the turn", "in the turn")
        .replaceAll("doesn't ready", "doesn't get ready")
        .replaceAll("ready one", "get ready one")
        .replaceAll("exerted", "turned sideways")
        .replaceAll("exert", "turn sideways")
        .replaceAll("Exert", "Turn sideways")
        .replaceAll("item", "object")
        .replaceAll("Deal", "Do")
        .replaceAll("gain", "obtain")
        .replaceAll("chosen", "the chosen")
        .replaceAll("if able", "if possible")
        .replaceAll("facedown", "faced downwards")
        .replaceAll("instead", "instead of that");

    return preparedText;
  }
}
