import 'dart:developer';

import 'package:arcana_box/constants.dart';
import 'package:get/get.dart';
import 'package:translator/translator.dart';

import '../../models/card.dart';
import '../../models/card_translation.dart';
part 'translation_state.dart';

class TranslationController {
  final TranslationState state;
  TranslationController(this.state);

  void translateCard(CardModel card) async {
    CardTranslation translation = await getTranslate(card);

    if (translation.bodyText != null) {
      final Map<Lang, List<CardTranslation>> storedTranslations = state.translations.value;

      if (storedTranslations[state.appLanguage.value] == null) {
        storedTranslations[state.appLanguage.value] = [];
      }

      List<CardTranslation> actualLangTranslations = storedTranslations[state.appLanguage.value]!;

      int existingTranslationIndex = actualLangTranslations.indexWhere((cardTranslation) => cardTranslation.cardId == card.cardNum);

      if (existingTranslationIndex != -1) {
        actualLangTranslations[existingTranslationIndex] = translation;
      } else {
        actualLangTranslations.add(translation);
      }

      state.translations.value = storedTranslations;

      log("${card.name} - Translated");
    }
  }


  Future<CardTranslation> getTranslate(CardModel card) async {
    String? text = card.bodyText;
    if (text != null && state.commState.value != CommState.loading) {
      state.commState.value = CommState.loading;
      try {
        log("Translating");
        var translation = await state.translator.translate(
            prepareForTranslate(text),
            from: languageCodes(state.baseLanguageFromApi),
            to: languageCodes(state.appLanguage));
        state.commState.value = CommState.idle;
        return CardTranslation(bodyText: translation.toString(), cardId: card.cardNum);
      } catch (e) {
        state.commState.value = CommState.error;
        return CardTranslation(cardId: card.cardNum);
      }
    }
    return CardTranslation(cardId: card.cardNum);
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
