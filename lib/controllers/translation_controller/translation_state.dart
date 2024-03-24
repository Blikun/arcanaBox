
part of 'translation_controller.dart';

class TranslationState {

    final Rx<CommState> commState = CommState.idle.obs;
    final Rx<Lang> appLanguage = Lang.es.obs;
    final baseLanguageFromApi = Lang.en;
    final translator = GoogleTranslator();
    final Rx<Map<Lang,List<CardTranslation>>> translations = Rx<Map<Lang,List<CardTranslation>>>({});

}

String languageCodes(language) {
    return language.toString().split('.').last;
}

enum Lang {
    en, // English
    es, // Spanish
    fr, // French
    de, // German
    ru, // Russian
    pt, // Portuguese
}
