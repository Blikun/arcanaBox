
part of 'translation_controller.dart';

class TranslationState {

    final Rx<CommState> commState = CommState.idle.obs;
    final Rx<String> language = languageCodes(Lang.es).obs;
    final baseLanguageFromApi = languageCodes(Lang.en);
    final translator = GoogleTranslator();
    final Rx<Map<String,CardTranslation>> translations = Rx<Map<String,CardTranslation>>({});

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
